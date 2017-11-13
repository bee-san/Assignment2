import Data.List
import System.IO.Unsafe

---- Data Paths
-- Remember to use double backslashes for windows paths

data_path :: String
data_path = "//mnt//c//Users//brand//Documents//haskell//assignment21//data.csv"

sales_path :: String 
sales_path = "//mnt//c//Users//brand//Documents//haskell//assignment21//sales.txt"

---- Part A

convert_single :: [Float] -> Float -> [Float]
convert_single series exchange = map (*exchange) series
-- The above is self explanatory.
-- above code is tested against series 0, 1 and 2 as well as exchange = -1, 0, "a" and 1. Tests were successful.

convert_all :: [[Float]] -> Float -> [[Float]]
-- what we want to do is map over every element in the list and map over the elements inside that list
-- and convert each element into a different currency
convert_all series exchange = map (map (*exchange ) ) series
-- above code is tested to work against exchange being -1, 0, "a" and 1. tests sucessful.

-- what we want to do is to go over every single element in the list and if that
-- element is > amount then return that element in a list
days_above :: [Float] -> Float -> Integert
days_above series amount = length(filter (>amount) series)
-- TODO: John said the above days_above code doesn't work, check it over?

-- This is basically the same as above but using an aonymous function
days_between :: [Float] -> Float -> Float -> Int
days_between series lower upper = length(filter (\x -> x > lower && x < upper) series)

----- Part B

modify_position :: Float -> Float -> Float -> Float -> Float
modify_position buy_price sell_price position price = 
    

final_position :: Float -> Float -> [Float] -> Float
final_position buy_price sell_price series = 
    error "Not implemented"


daily_position :: Float -> Float -> [Float] -> [Float]
daily_position buy_price sell_price series =
    error "Not implemented"


daily_holding_values :: Float -> Float -> [Float] -> [Float]
daily_holding_values buy_price sell_price series =
    error "Not implemented"


---- Part C

sales_final_position :: [String] -> [Float]
sales_final_position sales =
    error "Not implemented"


sales_holding_value :: [String] -> [[Float]] -> [Float]
sales_holding_value sales series =
    error "Not implemented"


---- Code for loading the data -- do not modify!

splitOn :: Eq a => a -> [a] -> [[a]]
splitOn sep [] = []
splitOn sep list =
    let
        ne_sep = \ x -> x /= sep
        first = takeWhile ne_sep list
        second = dropWhile ne_sep list
        rest = if null second then [] else tail second
    in
        first : splitOn sep rest

get_data :: [[Float]]
get_data = 
    unsafePerformIO $
        do
            file <- readFile data_path
            let line_split = splitOn '\n' file
                remove_r = map init line_split
                full_split = map (splitOn ',') line_split
                converted = map (map (read :: String -> Float)) full_split
            return converted

get_series :: Int -> [Float]
get_series n = 
    if n >= 0 && n < 10
    then (transpose get_data) !! n
    else error ("There is no series " ++ show n)

get_sales :: [String]
get_sales =
    unsafePerformIO $
        do 
            file <- readFile sales_path
            return $ map init $ splitOn '\n' file

short_data :: [[Float]]
short_data = take 10 get_data

get_short_series :: Int -> [Float]
get_short_series n = take 10 (get_series n)


-- I wanted a ever-so slightly shorter version of this function,sorry!!
get_short_series :: Int -> [Float]
get_shorter_series n = take 3 (get_series n)
