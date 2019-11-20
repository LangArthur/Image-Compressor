module Parser
    (
    readFileValues, parseArg, isCoord, checkLine, checkDoublePoint, convertLine, toFloatArray, readFileRawContent
    ) where

import Data.Maybe
import Text.Read

import Utils
import Algo

isCoord::String->Int->Bool
isCoord str pt
    | head str /= '(' || last str /= ')' = False
    | otherwise = if length values == pt then not(-1 `elem` (map (convertToInt) values)) else False
        where values = wordsWhen (==',') $ cleanStr str "()"

checkLineContent::[String]->Bool
checkLineContent [pos, color] = if isCoord pos 2 && isCoord color 3 then True else False
checkLineContent content = False

checkLine::String->Bool
checkLine str
    | length str < 13 = False
    | isOnly str ("(), " ++ ['0'..'9']) == False = False
    | (checkLineContent $ wordsWhen (== ' ') str) == False = False
    | otherwise = True

checkDoublePoint::[(String, Point)]->[String]->Bool
checkDoublePoint [] _ = True
checkDoublePoint ((s, p):xs) vals = if s `elem` vals then False else checkDoublePoint xs (vals ++ [s])

convertLine::String->(String, [Float])
convertLine str = (pos, map (read :: String->Float) (wordsWhen (== ',') $ cleanStr elems "()"))
    where [pos, elems] = wordsWhen (==' ') str


toFloatArray::[String]-> Maybe [(String, [Float])]
toFloatArray array = if not(elem False (map (checkLine) array)) then Just (map (convertLine) array) else Nothing

readFileRawContent::String->IO([String])
readFileRawContent name = do
    content <- readFile name
    return (lines content)

readFileValues::String-> IO( Maybe [(String, [Float])])
readFileValues name = do
    content <- readFileRawContent name
    return $ toFloatArray content

parseArg::Int->Float->String->IO()
parseArg n e path
    | n <= 0 || e <= 0 = do
        my_exit "Error: Invalid arguments"
    | otherwise = do
        a <- readFileValues path
        if a /= Nothing && (checkDoublePoint (fromJust a) []) == True then compressor n e (fromJust a) else my_exit "Error: file has an incorrect format."
        return ()
