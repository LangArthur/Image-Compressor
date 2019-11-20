module Output
    (
    dispCompression, formatPoint
    ) where

import Utils

formatPoint::Point->String
formatPoint p = "(" ++ show (round $ p !! 0) ++ "," ++ show (round $ p !! 1) ++ "," ++ show (round $ p !! 2) ++ ")"

dispPoints::[(String, Point)]->IO()
dispPoints [] = do
    return ()
dispPoints ((n, p):xs) = do
    putStrLn (n ++ " " ++ formatPoint p)
    dispPoints xs

dispCentroid::[(String, Point)]->Point->IO()
dispCentroid points centroid = do
    putStrLn ("--\n" ++ formatPoint centroid ++ "\n-")
    dispPoints points
    return ()


dispCompression::[(Point, [(String, Point)])]->IO()
dispCompression [(c, p)] = do
    dispCentroid p c
    return ()
dispCompression ((c, p):xs) = do
    dispCentroid p c
    dispCompression xs
    return ()
