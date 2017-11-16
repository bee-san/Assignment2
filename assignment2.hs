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
days_above :: [Float] -> Float -> Int
days_above series amount = length(filter (>amount) series)
-- TODO: John said the above days_above code doesn't work, check it over?

-- This is basically the same as above but using an aonymous function
days_between :: [Float] -> Float -> Float -> Int
days_between series lower upper = length(filter (\x -> x > lower && x < upper) series)

----- Part B

modify_position :: Float -> Float -> Float -> Float -> Float
modify_position buy_price sell_price position price =
    if price < buy_price then position + 1
    else if position /= 0 && price > sell_price then position - 1
    else position

-- we want to use foldl to turn the list reutrn by modify position into a single final postitio
-- we want to increase the modify position position to increaes by 1 everytime, is this what accumulator is for?
-- the x is the current element in the list, maybe use this for price?
--test = (\ acc x -> modify_position 37 38 acc x)
--final_position :: Float -> Float -> [Float] -> Float
final_position buy_price sell_price series = foldl (\ acc x -> modify_position buy_price sell_price acc x) 0 series

-- Literally the same as above but with slight modifcations
-- TODO: test this
daily_position :: Float -> Float -> [Float] -> [Float]
daily_position buy_price sell_price series = scanl  (\ acc x -> modify_position buy_price sell_price acc x) 0 series


-- we want to map through every element of daily_position and map through every element in series
-- and times element X in series by element X in daily_position
daily_holding_values :: Float -> Float -> [Float] -> [Float]
daily_holding_values buy_price sell_price series = zipWith (\ x y -> x * y) series (daily_position buy_price sell_price series) 
-- To myself; all the above code is working on branch MASTER. If you mess up, rebase.




---- Part C


-- so what we want to do create a function that takes the list of strings and split them up into indivudal strings
-- and then from there i assume 1 line in sales.txt is equal to 1 string
-- therefore we need to split the string up using the spaces and format it into a custom data type
-- as such BOOL float, int int where BOOL is BUY / SELL
-- do I want to create a new list using the new data type, or do I want to be able to call a function
-- to convert each string into useful data then use that?

-- This is self explanatory
--data Sale :: Bool Float Int Int

-- ACTION UNITS SERIES DAY

-- helper function, self explanatory
sales_data_get = map (words) (get_sales)


-- TUPLIFY --  NOT A HARRY POTTER SPELL -- Helper function. TODO: make your own data type?
element_to_tuple :: [[Char]] -> (Bool, Float, Int, Int)
element_to_tuple list = ((if list !! 0 == "BUY" then True else False), (read (list !! 1) :: Float), read (list !! 2) :: Int, read (list !! 3) :: Int )

-- Function that uses helper functions
tuple_to_data = map (\ x -> element_to_tuple x) (sales_data_get)

-- we want to go through the list, 1 element at a time and access each element. given a list of a sale
-- we want to send that to a function that executes the sale and then returns back the number for it

-- TODO: map this
calculate_sales list = if list !! 0 == "BUY" then buy_sale else if list !! 0 == "SELL" then sell_sale else error"NIGGA"



-- Map every element of [[a]] and then map the elements inside of it and check if its
-- the correct thing
--what_goes_where = map map((calculate_sales) (tuple_to_data)) tuple_to_data


--TODO: this might be 9 and not 10
make_fake_list = take 10 (repeat 0)

--modify_sale_buy sales_list empty_list= ()

--modify_sale_buy 

buy_sale = [1]
sell_sale = [0]


-- begin_sale (tuple_to_data) = map (\x -> map(\c -> if c == True then buy_sale x else sell_sale x)) tuple_to_data

--get_n_element_of_list n = tuple_to_data !! n



sales_final_position :: [String] -> [Float]
sales_final_position sales = zipWith (\ x y -> x + y) (buy_sale) (sell_sale)


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
                remove_r = map (filter (/='\r')) line_split
                full_split = map (splitOn ',') remove_r
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
            return $ map (filter (/='\r')) $ splitOn '\n' file

short_data :: [[Float]]
short_data = take 10 get_data

get_short_series :: Int -> [Float]
get_short_series n = take 10 (get_series n)

