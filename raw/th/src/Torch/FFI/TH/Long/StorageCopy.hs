{-# LANGUAGE ForeignFunctionInterface #-}
module Torch.FFI.TH.Long.StorageCopy where

import Foreign
import Foreign.C.Types
import Torch.Types.TH
import Data.Word
import Data.Int

-- | c_rawCopy :  storage src -> void
foreign import ccall "THStorageCopy.h THLongStorage_rawCopy"
  c_rawCopy :: Ptr CTHLongStorage -> Ptr CLong -> IO ()

-- | c_copy :  storage src -> void
foreign import ccall "THStorageCopy.h THLongStorage_copy"
  c_copy :: Ptr CTHLongStorage -> Ptr CTHLongStorage -> IO ()

-- | c_copyByte :  storage src -> void
foreign import ccall "THStorageCopy.h THLongStorage_copyByte"
  c_copyByte :: Ptr CTHLongStorage -> Ptr CTHByteStorage -> IO ()

-- | c_copyChar :  storage src -> void
foreign import ccall "THStorageCopy.h THLongStorage_copyChar"
  c_copyChar :: Ptr CTHLongStorage -> Ptr CTHCharStorage -> IO ()

-- | c_copyShort :  storage src -> void
foreign import ccall "THStorageCopy.h THLongStorage_copyShort"
  c_copyShort :: Ptr CTHLongStorage -> Ptr CTHShortStorage -> IO ()

-- | c_copyInt :  storage src -> void
foreign import ccall "THStorageCopy.h THLongStorage_copyInt"
  c_copyInt :: Ptr CTHLongStorage -> Ptr CTHIntStorage -> IO ()

-- | c_copyLong :  storage src -> void
foreign import ccall "THStorageCopy.h THLongStorage_copyLong"
  c_copyLong :: Ptr CTHLongStorage -> Ptr CTHLongStorage -> IO ()

-- | c_copyFloat :  storage src -> void
foreign import ccall "THStorageCopy.h THLongStorage_copyFloat"
  c_copyFloat :: Ptr CTHLongStorage -> Ptr CTHFloatStorage -> IO ()

-- | c_copyDouble :  storage src -> void
foreign import ccall "THStorageCopy.h THLongStorage_copyDouble"
  c_copyDouble :: Ptr CTHLongStorage -> Ptr CTHDoubleStorage -> IO ()

-- | c_copyHalf :  storage src -> void
foreign import ccall "THStorageCopy.h THLongStorage_copyHalf"
  c_copyHalf :: Ptr CTHLongStorage -> Ptr CTHHalfStorage -> IO ()

-- | p_rawCopy : Pointer to function : storage src -> void
foreign import ccall "THStorageCopy.h &THLongStorage_rawCopy"
  p_rawCopy :: FunPtr (Ptr CTHLongStorage -> Ptr CLong -> IO ())

-- | p_copy : Pointer to function : storage src -> void
foreign import ccall "THStorageCopy.h &THLongStorage_copy"
  p_copy :: FunPtr (Ptr CTHLongStorage -> Ptr CTHLongStorage -> IO ())

-- | p_copyByte : Pointer to function : storage src -> void
foreign import ccall "THStorageCopy.h &THLongStorage_copyByte"
  p_copyByte :: FunPtr (Ptr CTHLongStorage -> Ptr CTHByteStorage -> IO ())

-- | p_copyChar : Pointer to function : storage src -> void
foreign import ccall "THStorageCopy.h &THLongStorage_copyChar"
  p_copyChar :: FunPtr (Ptr CTHLongStorage -> Ptr CTHCharStorage -> IO ())

-- | p_copyShort : Pointer to function : storage src -> void
foreign import ccall "THStorageCopy.h &THLongStorage_copyShort"
  p_copyShort :: FunPtr (Ptr CTHLongStorage -> Ptr CTHShortStorage -> IO ())

-- | p_copyInt : Pointer to function : storage src -> void
foreign import ccall "THStorageCopy.h &THLongStorage_copyInt"
  p_copyInt :: FunPtr (Ptr CTHLongStorage -> Ptr CTHIntStorage -> IO ())

-- | p_copyLong : Pointer to function : storage src -> void
foreign import ccall "THStorageCopy.h &THLongStorage_copyLong"
  p_copyLong :: FunPtr (Ptr CTHLongStorage -> Ptr CTHLongStorage -> IO ())

-- | p_copyFloat : Pointer to function : storage src -> void
foreign import ccall "THStorageCopy.h &THLongStorage_copyFloat"
  p_copyFloat :: FunPtr (Ptr CTHLongStorage -> Ptr CTHFloatStorage -> IO ())

-- | p_copyDouble : Pointer to function : storage src -> void
foreign import ccall "THStorageCopy.h &THLongStorage_copyDouble"
  p_copyDouble :: FunPtr (Ptr CTHLongStorage -> Ptr CTHDoubleStorage -> IO ())

-- | p_copyHalf : Pointer to function : storage src -> void
foreign import ccall "THStorageCopy.h &THLongStorage_copyHalf"
  p_copyHalf :: FunPtr (Ptr CTHLongStorage -> Ptr CTHHalfStorage -> IO ())