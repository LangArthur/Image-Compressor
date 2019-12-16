import Test.Hspec
import System.Exit

import Algo
import Output
import Parser
import Utils

main :: IO ()
main = hspec $ do
    it "Clear string" $ cleanStr "T..o-)to::" ".:-()" `shouldBe` "Toto"
    it "Split string into words" $ wordsWhen (==',') "This,is,a,test" `shouldBe` ["This", "is", "a", "test"]
    it "Round float to float" $ roundF 1.3 `shouldBe` 1.0
    it "Get specific col 0 of double array" $ getColVal [[1, 4, 5], [3, 2, 33], [55, 6, 5, 5, 3]] 0 `shouldBe` [1, 3, 55]
    it "Get specific col 2 of double array" $ getColVal [['a', 'z', 'v'], ['r', 't', '3'], ['v', 'C', 'B', '2', 'E']] 2 `shouldBe` ['v', '3', 'B']
    it "Compute mean" $ mean ([1, 2, 3] :: [Integer]) `shouldBe` 2
    it "isOnly check True" $ isOnly "toto" "to" `shouldBe` True
    it "isOnly check False" $ isOnly "Toto" "to" `shouldBe` False
    it "Convert to int" $ convertToInt "23" `shouldBe` 23
    it "Convert to int failed" $ convertToInt "23E" `shouldBe` -1
    it "Convert to float" $ convertToFloat "44" `shouldBe` 44.0
    it "Convert to float failed" $ convertToFloat "4 4" `shouldBe` -1
    it "My exit" $ my_exit("Error: this is a test, don't panic") `shouldThrow` (== ExitFailure 84)

    it "Check good formating coordonates" $ isCoord "(2, 3)" 2 `shouldBe` True
    it "Check false formating coordonates" $ isCoord "(2, 3)" 4 `shouldBe` False
    it "Check false formating coordonates" $ isCoord "2, 3" 4 `shouldBe` False
    it "Check good line formating" $ checkLine "(3,2) (4,33,1)" `shouldBe` True
    it "Check good line formating" $ checkLine "(3,2)(4,33,1)" `shouldBe` False
    it "Check false line formating" $ checkLine "(4,1)" `shouldBe` False
    it "Check false line formating" $ checkLine "(3,2) (t,33,1)" `shouldBe` False
    it "Check false line formating" $ checkLine "(3,2) (4,33,-1)" `shouldBe` False
    it "Check for multiple point" $ checkDoublePoint [("(3,3)", [2.0, 3.0, 2.0]), ("(3,3)", [2.0, 3.0, 2.0])] [] `shouldBe` False
    it "Check for multiple point" $ checkDoublePoint [("(3,3)", [2.0, 3.0, 2.0]), ("(3,2)", [2.0, 3.0, 2.0])] [] `shouldBe` True
    it "Convert a line" $ convertLine "(3,2) (4,33,1)" `shouldBe` ("(3,2)", [4.0, 33.0, 1.0])
    it "Convert data to float array" $ toFloatArray ["(3,2) (4,33,1)"] `shouldBe` Just ([("(3,2)", [4.0, 33.0, 1.0])])
    it "Test bad arguments" $ parseArg 0 6 "unit_test_ko" `shouldThrow` (== ExitFailure 84)
    it "Test bad file" $ parseArg 3 6 "./test/unit_test_ko" `shouldThrow` (== ExitFailure 84)
    it "Test bad file" $ parseArg 3 6 "./test/unit_test_ko" `shouldThrow` (== ExitFailure 84)

    it "Compute euclidian distance" $ computeDistance [3, 4, 5] [3, 8, 2] `shouldBe` 5.0
    it "Find shorter distance point position" $ findShorterPos [[3, 5, 5], [6, 3, 2], [4, 3, 3]] [3, 2, 3] `shouldBe` [4.0, 3.0, 3.0]
    it "Compute Barycenter" $ computeBarycenter [2, 3, 4] [4, 2, 2] `shouldBe` [3.0, 2.0, 3.0]
    it "Find news Centroids" $ findNewCentroids [[("(2,2)", [2.0, 4.0, 3.0]), ("(2,2)", [5.0, 1.0, 3.0])]] [[100, 100, 100]] [[7.0, 9.0, 4.0]] 1 `shouldBe` [[5.0, 5.5, 4.0]]
    it "End of Algorithm : True" $ isAlgoOver [[3.0, 2.0, 1.0]] [[3.0, 2.0, 1.0]] 5 `shouldBe` True
    it "End of Algorithm : False" $ isAlgoOver [[3.0, 2.0, 1.0]] [[22.0, 50.0, 45.0]] 0.1 `shouldBe` False
    it "Assign to centroids" $ assignToCentroid [[3.0, 3.0, 3.0]] [("(2,2)", [2.0, 4.0, 3.0]), ("(2,2)", [5.0, 1.0, 3.0])] `shouldBe` [[("(2,2)", [2.0, 4.0, 3.0]), ("(2,2)", [5.0, 1.0, 3.0])]]
    it "Run Kmeans Algorithme" $ runKMeans [] [[2.0, 3.0, 3.0], [3.0, 4.0, 3.0]] 0.1 [("(3,3)", [2.0, 3.0, 2.0]), ("(3,2)", [2.0, 3.0, 2.0])] `shouldBe` [([2.0,3.0,2.0],[("(3,3)",[2.0,3.0,2.0]),("(3,2)",[2.0,3.0,2.0])]),([3.0,4.0,3.0],[])]

    it "Format a point" $ formatPoint [3, 2, 5] `shouldBe` "(3,2,5)"

    return ()
