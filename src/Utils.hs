module Utils
    (
    wordsWhen, cleanStr, my_exit, roundF, getColVal, mean, isOnly, convertToInt, convertToFloat, Point(..)
    ) where

import System.Exit
import System.IO
import Data.List
import Text.Read

type Point = [Float]

my_exit::String->IO()
my_exit msg = do
    hPutStrLn stderr msg
    exitWith (ExitFailure 84)

wordsWhen::(Char->Bool)-> String->[String]
wordsWhen p s = case dropWhile p s of
                     "" -> []
                     s' -> w : wordsWhen p s''
                        where (w, s'') = break p s'

cleanStr::String->String->String
cleanStr str to_rem = [x | x <- str, not(x `elem` to_rem)]

roundF::Float->Float
roundF nb = fromIntegral $ round nb

getColVal::[[a]]->Int->[a]
getColVal values i = [ e !! i | e <- values]

mean::(Real a, Fractional b)=>[a]->b
mean values = realToFrac (sum values) / genericLength values

isOnly::String->String->Bool
isOnly [] constraints = True
isOnly (c:str) constraints = if c `elem` constraints then isOnly str constraints else False

convertToInt::String->Int
convertToInt to_int = case readMaybe to_int :: Maybe Int of
                   Just to_int -> to_int
                   Nothing -> (-1)

convertToFloat::String->Float
convertToFloat to_float = case readMaybe to_float :: Maybe Float of
                  Just to_float -> to_float
                  Nothing -> (-1)
