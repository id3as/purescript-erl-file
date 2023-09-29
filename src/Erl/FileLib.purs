module Erl.FileLib
  ( ensureDir
  , mkTemp
  , module StandardResult
  ) where

import Prelude

import Data.Either (Either)
import Effect (Effect)
import Erl.StandardResult (Reason(..)) as StandardResult
import Erl.StandardResult (Reason, ReasonResult, standardResultToEither)

foreign import ensureDir_ :: String -> Effect (ReasonResult Unit)

ensureDir :: String -> Effect (Either Reason Unit)
ensureDir f = standardResultToEither <$> ensureDir_ f

foreign import fileSize :: String -> Effect Int

foreign import isDir :: String -> Effect Boolean

foreign import isFile :: String -> Effect Boolean

foreign import isRegular :: String -> Effect Boolean

foreign import mkTemp_ :: Effect String

mkTemp :: Effect String
mkTemp = mkTemp_
