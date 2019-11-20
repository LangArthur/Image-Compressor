module Algo
    (
    compressor, findShorterPos, computeDistance, computeBarycenter, findNewCentroids, isAlgoOver, runKMeans, assignToCentroid
    ) where

import Data.List
import Data.Maybe
import System.Random

import Utils
import Output

randomCentroid::IO (Point)
randomCentroid = do
    r <- randomRIO (0, 255) :: IO Float
    g <- randomRIO (0, 255) :: IO Float
    b <- randomRIO (0, 255) :: IO Float
    return ([roundF r, roundF g, roundF b])

randomCentroids::Int->[Point]->IO ([Point])
randomCentroids n res
    | n < 0 = do
        return []
    | n == 0 = do
        return res
    | otherwise = do
        rand <- randomCentroid
        res <- randomCentroids (n - 1) (res ++ [rand])
        return res

computeDistance::Point->Point->Float
computeDistance [r1, g1, b1] [r2, g2, b2] = sqrt $ ((r1 - r2) ** 2 + (g1 - g2) ** 2 + (b1 - b2) ** 2)
computeDistance p1 p2 = error "Arguments are not point coordonates"

findShorterPos::[Point]->Point->Point
findShorterPos [] _ = error "Empty list in findShorterPos"
findShorterPos [x] _ = x
findShorterPos (x:xs) p = if (computeDistance x p) < computeDistance next p then x else next
        where next = findShorterPos xs p

findAllShorterPoint::Point->[Point]->[(String, Point)]->[(String, Point)]
findAllShorterPoint c centroids values = [ (s, p) | (s, p) <- values, findShorterPos centroids p == c]

computeBarycenter::Point->Point->Point
computeBarycenter [x1, y1, z1] [x2, y2, z2] = [center x1 x2, center y1 y2, center z1 z2]
    where center a b = fromIntegral $ round ((a + b) / 2)
computeBarycenter _ _ = error "Error: can't compute barycenter: arguments are not points."

findNewCentroid::[(String, Point)]->Point->Point->Float->Point
findNewCentroid values o c e
    | values == [] = c
    | o /= [] && computeDistance o c <= e = c
    | otherwise = [mean ((getColVal bary 0) :: Point), mean ((getColVal bary 1) :: Point), mean ((getColVal bary 2) :: Point)]
        where bary = [computeBarycenter p c | (s, p) <- values]

findNewCentroids::[[(String, Point)]]->[Point]->[Point]->Float->[Point]
findNewCentroids values [] centroids e = [ findNewCentroid (values !! (fromJust $ elemIndex c centroids) ) [] c e | c <- centroids]
findNewCentroids values o c e = [ findNewCentroid (values !! (fromJust $ elemIndex (c !! i) c) ) (o !! i) (c !! i) e | i <- [0..(length c) - 1]]

assignToCentroid::[Point]->[(String, Point)]->[[(String, Point)]]
assignToCentroid [] _ = error "Error : No centroids to assign points."
assignToCentroid centroids points = [ findAllShorterPoint c centroids points | c <- centroids]

isAlgoOver::[Point]->[Point]->Float->Bool
isAlgoOver [] new e = False
isAlgoOver old new e = if dist == [] then True else False
    where dist = [ computeDistance (old !! i) (new !! i) | i <- [0 .. (length old) - 1], (old !! i) /= [] && (new !! i) /= [] && computeDistance (old !! i) (new !! i) > e]

runKMeans::[Point]->[Point]->Float->[(String, Point)]->[(Point, [(String, Point)])]
runKMeans old_centroids centroids e values
    | (isAlgoOver old_centroids centroids e) == True = [(c, (findAllShorterPoint c centroids values)) | c <- centroids]
    | otherwise = runKMeans centroids (findNewCentroids (assignToCentroid centroids values) old_centroids centroids e) e values

compressor::Int->Float->[(String, Point)]->IO ()
compressor n e array = do
    rand_c <- randomCentroids n []
    let algo = runKMeans [] rand_c e array
    dispCompression algo
    return ()