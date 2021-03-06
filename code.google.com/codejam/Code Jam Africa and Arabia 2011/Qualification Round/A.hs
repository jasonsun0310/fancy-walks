{-# OPTIONS_GHC -O2 #-}

import Data.List
import Data.Maybe
import Data.Char
import Data.Array
import Data.Int
import Data.Ratio
import Data.Bits
import Data.Function
import Data.Ord
import Control.Monad.State
import Control.Monad
import Control.Applicative
import Data.ByteString.Char8 (ByteString)
import qualified Data.ByteString.Char8 as BS
import Data.Set (Set)
import qualified Data.Set as Set
import Data.Map (Map)
import qualified Data.Map as Map
import Data.IntMap (IntMap)
import qualified Data.IntMap as IntMap
import Data.Sequence (Seq)
import qualified Data.Sequence as Seq
import Data.Tree
import Data.Graph

solve p = sum ab - length ab * 2
  where
    a = reverse . sort . map fst $ filter snd p
    b = reverse . sort . map fst $ filter (not.snd) p
    ab = zipWith (+) a b

parseInput = do 
    cas <- readInt
    replicateM cas $ do
        n <- readInt
        replicateM n $ do
            str <- BS.unpack <$> readString
            return (read (init str) :: Int, last str == 'B')
  where
    readInt = state $ fromJust . BS.readInt . BS.dropWhile isSpace
    readString = state $ BS.span (not . isSpace) . BS.dropWhile isSpace

main = do
    input <- evalState parseInput <$> BS.getContents
    forM_ (zip [1..] input) $ \(cas, a) -> do
        putStrLn $ "Case #" ++ show cas ++ ": " ++ show (solve a)
