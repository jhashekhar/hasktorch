{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE ScopedTypeVariables #-}

module CovidData where

import qualified Data.ByteString.Lazy as BL
import qualified Data.Vector as V
import qualified Data.Map as M
import qualified Data.Set as S
import Data.Time
import GHC.Generics (Generic)
import Data.Csv
import Torch as T

-- This is a placeholder for this example until we have a more formal data loader abstraction
--
class Dataset d a where
    getItem
        :: d
        -> Int -- index
        -> Int -- batchSize
        -> a

data UsCounties = UsCounties
  { date :: String,
    county :: String,
    state :: String,
    fips :: String,
    cases :: Int,
    deaths :: Int
  }
  deriving (Eq, Generic, Show)

instance FromRecord UsCounties
-- instance FromNamedRecord UsCounties

data ModelData = ModelData
  { timePoints :: [Int],
    fipsStrs :: [String],
    fipsIdxs :: [Int],
    fipsMap :: M.Map String Int,
    caseCounts :: [Int],
    deathCounts :: [Int]
  }
  deriving (Eq, Generic, Show)

data TensorData = TensorData
  { tTimes :: Tensor,
    tFips :: Tensor,
    tCases :: Tensor,
    tDeaths :: Tensor
  }
  deriving (Eq, Generic, Show)

loadDataset fileName = do
  csvData <- BL.readFile fileName
  case decode HasHeader csvData of
    Left err -> error err
    Right (v :: V.Vector UsCounties) -> pure v


prepData :: V.Vector UsCounties -> IO ModelData
prepData dataset = do
  let fipsSet = S.fromList . V.toList $ fips <$> dataset
  let idxMap = M.fromList $ zip (S.toList fipsSet)  [0 .. length fipsSet - 1] 
  let indices = V.toList $ ((M.!) idxMap) <$> (fips <$> dataset)
  times <- datesToTimepoints "2020-01-21" (V.toList $ date <$> dataset)
  pure ModelData {
    timePoints=times,
    fipsStrs=V.toList $ fips <$> dataset,
    fipsIdxs=indices,
    fipsMap=idxMap,
    caseCounts=V.toList $ cases <$> dataset,
    deathCounts=V.toList $ deaths <$> dataset
  }

prepTensors :: ModelData -> TensorData
prepTensors modelData =
  TensorData {
    tTimes = (asTensor . timePoints $ modelData),
    tFips = (asTensor . fipsIdxs $ modelData),
    tCases = (asTensor . caseCounts $ modelData),
    tDeaths = (asTensor . deathCounts $ modelData)
    }

filterOn 
  :: (TensorData -> Tensor) -- getter
  -> (Tensor -> Tensor) -- predicate
  -> TensorData -- input data
  -> TensorData -- filtered data
filterOn getter pred tData =
  TensorData {
    tTimes = selector (tTimes tData),
    tFips = selector (tFips tData),
    tCases = selector (tCases tData),
    tDeaths = selector (tDeaths tData)
    }
  where
    selector :: Tensor -> Tensor
    selector = indexSelect 0 (squeezeAll . nonzero . pred . getter $ tData)
  

-- | Convert date strings to days since 1/21/2020 (the first date of this dataset)
datesToTimepoints :: String -> [String] -> IO [Int]
datesToTimepoints day0 dateStrings = do
  firstDay :: Day <- parseTimeM False defaultTimeLocale "%F" day0
  days :: [Day] <- sequence $ parseTimeM False defaultTimeLocale "%F" <$> dateStrings
  pure $ fromIntegral <$> flip diffDays firstDay <$> days

-- | calculate first differences of a tensor
diff t = (indexSelect' 0 [1..len-1] t) - (indexSelect' 0 [0..len-2] t)
  where len = shape t !! 0

-- | trim leading zeros from a tensor
trim t = 
  if hasVal then
    let firstNonzero = asValue $ nz ! (0 :: Int)
      in indexSelect' 0 [firstNonzero..len-1] t
  else t
  where 
    len = shape t !! 0
    nz = squeezeAll . nonzero $ t 
    hasVal = T.all $ toDType Bool nz