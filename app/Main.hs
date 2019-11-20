module Main where

import System.Environment

import Parser
import Utils

main :: IO ()
main = do
    args <- getArgs
    if (length args == 3) then parseArg (convertToInt $ args !! 0) (convertToFloat $ args !! 1) (args !! 2) else my_exit "Error: Invalid number of arguments"
    return ()
