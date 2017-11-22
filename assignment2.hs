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
final_position :: Float -> Float -> [Float] -> Float
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


-- ACTION UNITS SERIES DAY

-- helper function, self explanatory
sales_data_get = map (words) (get_sales)

-- TUPLIFY --  NOT A HARRY POTTER SPELL -- Helper function. TODO: make your own data type?
element_to_tuple :: [[Char]] -> (Bool, Float, Int, Int)
element_to_tuple list = ((if list !! 0 == "BUY" then True else False), (read (list !! 1) :: Float), read (list !! 2) :: Int, read (list !! 3) :: Int )

-- Function that uses helper functions
tuple_to_data = map (\ x -> element_to_tuple x) (sales_data_get)

-- Quickly checks to see if the current position of the list is the same as the series
-- qik_chk series x = if series == x  then True else False

-- if it is buy then return units, if it is sell return units * -1
buy_or_sell (isBuy, quantity, _, _) = if isBuy == True then (quantity) else (quantity) * (-1)

modify_list list pos new =
    let
        before = take  pos list
        after  = drop (pos+1) list
    in
        before ++ [new] ++ after

-- modifies the list to contain the right data and then outputs the positions list
change_list (isBuy, quantity, series, day) positions =
    let
        units = buy_or_sell (isBuy, quantity, series, day)
        cur_pos = positions !! series
    in
        modify_list positions series (cur_pos + units)

sales_final_position :: [String] -> [Float]
sales_final_position sales = foldl (\acc x -> change_list x acc) (replicate 10 0) tuple_to_data

----------------------------------------------------------------------------------------------------
---------------------------------Graveyard of attempted code ---------------------------------------
----------------------------------------------------------------------------------------------------


-- acculmator is both the number of units and a motherfucking list
-- we need to make sure the current element in the list is equal to 

-- if Buy is true then add accumulator + units
-- if sell is true then add accumulator + units * -1
-- otherwise just add accumulator to list

-- edits a list in a tuple
--edit_lst_tple (x, y, z) element_to_add = (x, y ++ [element_to_add], z)
--edit_tple_pp1 (x, y, z) acc = ((x +1), y, z)
-- pp1 stands for ++1


-- for the foldl implementation what we want to do is to to map an anonymous function onto the tuple_to_data list
-- and then use an if statement so if the current day in the sale is the same position in a list then
    -- if it is a sell transaction then times it by *-1 so it becomes negative
    -- then place this value into the accumulator 
    -- because of how the map works, if there are 2 day 4's or even 6 day 4's it will iterate over all of them at once so the accumulator will
        -- always have the current value for the day
    -- if the day changes, like it goes onto the next bit of map then write the accumulator value into the list
    -- this may be a function inside a function?
    -- then once the list is complete, you are done!!
    
-- Let's build tis a step at a time
-- test = map (\x -> ) tuple_to_data
-- okay so in the above code, x is always the current element in the list of TUPLES!!!
--test = map (\x -> foldl(x c a -> if x !! 4 == )) tuple_to_data
-- you're going to hate me john but this is the only way i can do it (i've been stuck on this for 2 weeks)
-- okay so we want to map an anonymous function onto tuple_to_data
-- the anonymous function will use foldl to return a single item, an accumulator which contaisn the current price (like if its 100 - 50 etc)
-- test = map (\x -> (foldl (\y acc -> if x !! 4 )))

--    make_fake_list = take 10 (repeat 0)

-- where list is empty list of 10 and slaes is list of sales
--begin_sale list sales = map (\x -> map(\c acc -> if x !! 4 == ) 0.0 sales) list

-- okay new plan
-- we map over every item in the 10 element empty list
-- we then use fold to count where in the list we are (using the accumulator)
-- in this folded funtion we then map every elemtn in the sales list
-- we then use fold and the accumulator to work out how much there is
-- so if DAY == original accumulator in empty list
-- then if sell add to accumulator UNITS*-1
-- else add to acculator +UNITS
-- when map is finished, add acculmator to a new list like
-- accumulator ++ the function we just gone did
-- recursion shouldn't be too hard as we can just make sure it goes until the list of 10 elements is achieved
-- we also need to drop the current elements from the list before we recurse
-- so if we just did day 1 then we need to call a drop_elements functin that returns the list minus every item in the list with day == 1

-- psuedocode for drop_elements
-- given the sales data and the current day
-- we will make a new list minus the sales data

-- drop_elements [] day = []
--drop_elements([x:xs], ys) day = map (\c -> if c !! 4 == day then drop_elements ys else drop_elements ([x:xs], ys))


-- sales_final_position :: [String] -> [Float]
-- sales_final_position sales = zipWith (\ x y -> x + y) (buy_sale) (sell_sale)

-- we want to go through the list, 1 element at a time and access each element. given a list of a sale
-- we want to send that to a function that executes the sale and then returns back the number for it

-- calculate_sales (x, y, z, b) = if x == True then [1] else if x  == False  then [0] 10 else error"ERROR 1"

-- calculate_buys [] length = []
-- calculate_buys list length = map (\ x -> if x !! 0 == True then x : calculate_buys list (length - 1) else calculate_buys list (length - 1)) list

-- buy_or_sell list = map (\ x -> calculate_sales x)
-- Map every element of [[a]] and then map the elements inside of it and check if its
-- the correct thing

--get_n_element_of_list n = tuple_to_data !! n

-- EXTRA GRAVEYARD OF NON-WORKING FOLDLS


-- test = foldl (\acc x -> if qik_chk series x then if by_r_sel x then acc + (x !! 2) else acc + (x !! 2 * (-1)) else edit_lst_tple ((edit_tple_pp1), list, acc)) (0, [], 0)
-- test list = foldl (\acc x -> if qik_chk (x !! 0) x then x + 1 else x + 2) 0 list 
--test list = foldl (\acc x -> if qik_chk (1) (x) then (x!!0)+1 else (x!!0)+2) (0, 0) list
--test list = foldl (\acc x -> if qik_chk (counter x) 0 list

-- test list = foldl (\acc x -> if acc !! 0 == 1 then 1 else 0) (0, 1) list

--test = foldl (\ acc x -> if series == x !! 3 then if x !! 0 then acc _ x !! 2 else acc + (x !! 2 * (-1)) else list ++ acc) (0.0, [])
-- test = foldl (\ acc x -> folded_function acc (x !!) x) (0.0, []) tuple_to_data






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

