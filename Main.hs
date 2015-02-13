module Main where

import Data.ByteString.Builder (Builder, toLazyByteString, word32BE)
import qualified Data.ByteString.Lazy as L

import Data.Monoid ((<>))

import System.Random.TF.Gen (TFGen, next)
import System.Random.TF.Init (newTFGen)

import System.IO (stdout, hSetBinaryMode)

randomBytesBuilder :: TFGen -> Builder
randomBytesBuilder g = word32BE w32 <> randomBytesBuilder n
    where (w32, n) = next g

main :: IO ()
main = do
    hSetBinaryMode stdout True

    gen <- newTFGen
    let builder = randomBytesBuilder gen
    L.hPut stdout (toLazyByteString builder)
