# COMP105 Assignment 2: Higher order functions

# Assessment Number 2
Weighting 25%
Assignment Date Circulated 9th November 2017
Deadline 12:00 22nd November 2017
Submission Mode Electronic Only
Learning outcome asses:
• Apply common functional programming idioms such as map, filter, and fold.
• Write programs using a functional programming language.

## Purpose of assessment
Marking criteria Implement various functions for manipulating financial data
manipulating financial data.
Correctness: 100%

# Important: Please read all of the instructions carefully before starting the assignment.

Introduction. In this assignment, you will implement various functions for processing financial data.
Before starting, you should download a2.zip from the module webpage. It contains the following files:
• assignment2.hs. This is a template file with stub code for each question, and with some helper
code for loading the data, which is described below.
• data.csv. This is a data file with price data for ten financial series that will be used in all three
parts of the assignment.
• sales.txt. This is a data file with transaction data that will be used in part C.

Extract the files (do not just open the zip file in Windows explorer). Open assignment2.hs and modify
the data_path and sales_path strings to point to the location of data.csv and sales.txt, respectively. The default values assume that you have unzipped the file directly into your M: drive on the
university computers. Note that on Windows, you must use two backslashes in your file paths, so
C:\Documents\Haskell\data.csv must be written as "C:\\Documents\\Haskell\\data.csv". This is
because \ is the escape character in Haskell.
The data. The data contains one-thousand days of price data for ten financial assets. The template
includes a function get_series :: Int -> [Float] that takes an integer between zero and nine, and

returns the price series for that asset:

ghci> get_series 0
[38.36,38.4,37.8,36.84,37.52,38.64,36.48,36.72,37.64,37.52,37.88,38.08,41.0,40.24,...



This indicates that the price for asset zero on day one was 38.36, the price on day two was 38.4, and
so on.
Some questions use data from the combined price series, which contains information about all ten
series. The template includes the function get_data :: [[Float]] which returns a single list-of-lists
containing data for all ten series. The outer list has one-thousand elements representing the prices on

each day, while the inner list gives the price for each asset. For example:
ghci> head (get_data)
[38.36,616.0,251.1,5424.0,598.14,325.0,4.6056,16454.0,193.2,1006.0]

ghci> last (get_data)
[36.0,617.6,157.1,3876.0,532.8,310.2,5.1444,15842.0,199.7,1631.2]

This indicates that the price for asset one on day one is 616.0, while the price for asset one on day
one-thousand is 617.6.
For convenience when testing, functions giving shorter data series have been provided. The function
get_short_series :: Int -> [Float] takes an integer, and returns the first ten days of the price
series for that asset, while short_data :: [[Float]] returns the first ten days of the combined price
series.
The assignment. The assignment is to implement various functions that process the financial data,
with a focus on applying higher-order programming techniques. In part A, you will implement functions
using map and filter. In part B, you will implement functions using foldl and scanl. If a function in
part A or part B tells you to use a function, then will need to use that function in order to obtain full
marks.

Parts A and B combined are worth 65% of the marks for the assignment, which is equivalent to a
2:1 mark. Part C should be attempted by ambitious students who want to push for 100%. There are no
restrictions at all for the code that you write in part C. Use whatever technique you see fit.
Marking. Your code will be marked by a combination of automated marking and human assessment.
Each function that you write will be tested by an automated tester on a number of test cases. Generally,
if your code passes all test cases, you will be awarded full marks for that question. While some test cases
are given for each question, these may not be the same test cases used by the automated marker.
If you are not able to fully implement a function, you may still get marks from the human marker
for demonstrating understanding. For this reason, make sure to extensively comment your code, so that
anyone reading can get an idea of what you are trying to do.

Submission. You should complete the assignment by filling out the template "assignment2.hs".
Submit this file to the assessment task submission system:
https://sam.csc.liv.ac.uk/COMP/Submissions.pl
You will need to log in with your Computer Science username and password (not your main university
credentials.)
Since your functions will be called from the automated marker, please make sure that you follow
these guidelines:
• Your code should compile and load into ghci without errors. (Warnings are fine).
• Your submitted file should be named exactly "assignment2.hs", with correct capitalization.
• You should not alter the type signatures in the template file in any way.
• You should leave the stub error-message implementation in the template file if you have not answered a question. If you remove this implementation, and then later decide to comment out your
code because it does not compile, then please reinstate the original stub implementation.
There will be a 5% penalty for any submission that does not follow these guidelines. If your code
produces no errors on the lab machines, then you are guaranteed to not get a penalty for failing to
compile. If you have some code that does not compile, but you would like the marker to see it, then
comment out the code, and explain in another comment what the code is supposed to do.


lagiarism. The work that you submit for this assessment must be your own. The University takes
plagiarism very seriously, so you should not collude with another student, or copy anyone else’s work.
Deadline.

The deadline for this task is:
Wednesday the 22nd of November 2017 at 12:00 (midday).

The standard university late penalty will be applied: 5% of the total marks available for the assessment
shall be deducted from the assessment mark for each 24 hour period after the submission deadline. Late
submissions will no longer be accepted after five calendar days have passed.

# Part A (worth 30%)
In part A we will build some simple tools for manipulating price series using map and filter.

## Question 1.
To convert a price from one currency to another, we multiply the price by an exchange
rate. So if the price is 2.0 in currency A, and the exchange rate between currency A and currency B is
1.31, then the price in currency B is 2.0 * 1.31 = 2.62.
Write a function convert_single :: [Float] -> Float -> [Float] that converts a price series
into another currency. The first argument is a price series, and the second argument is the exchange
rate. For example:

ghci> convert_single (get_short_series 0) 2.0
[76.72,76.8,75.6,73.68,75.04,77.28,72.96,73.44,75.28,75.04]

Your implementation should use the map function.

## Question 2.
 Write a function convert_all :: [[Float]] -> Float -> [[Float]] that converts
the combined price series (the series returned by get_data into another currency. The first argument is
the combined price series, and the second argument is the exchange rate. For example:

ghci> convert_all get_data 2.0
[[76.72,1232.0,502.2,10848.0,1196.28,650.0,9.2112,32908.0,386.4,2012.0],
[76.8,1248.8,505.2,11250.0,1220.94,655.6,9.2268,32120.0,395.6,2100.0],

Your implementation should use a nested map.

## Question 3. 

Write a function days_above :: [Float] -> Float -> Int that takes a price series
and a price, and returns the number of days for which the price series is greater than or equal to the
given price. For example:

ghci> get_short_series 0
[38.36,38.4,37.8,36.84,37.52,38.64,36.48,36.72,37.64,37.52]

ghci> days_above (get_short_series 0) 37
Your implementation should use the filter function.

## Question 4. 
Write a function days_between :: [Float] -> Float -> Float -> Int that takes a
price series, a low price, and a high price, and returns the number of days for which the price series is
strictly between the low price and the high price. For example:

ghci> days_between (get_short_series 0) 37 38
4
Your implementation should use the filter function.


# Part B (worth 35%)
In part B we will implement a simple trading strategy using foldl and scanl. The idea behind the
strategy is to buy low and sell high. The strategy is parameterized by two prices: the buy price and
the sell price. Every day, the strategy will compare the current price to the buy and sell prices. If the
current price is less than or equal to the buy price, then the strategy will buy one unit. If the current
price is greater than or equal to the sell price, and if the strategy is holding at least one unit, then the
strategy will sell one unit.

For example, the first ten days of price series zero are:
[38.36, 38.4, 37.8, 36.84, 37.52, 38.64, 36.48, 36.72, 37.64, 37.52]

If we apply the strategy with the buy price as 37 and the sell price as 38, then we get the following
sequence of positions:

[0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.0, 1.0, 2.0, 2.0, 2.0]

The strategy starts with a position of zero on day one. The strategy buys on day four, seven, and eight,
because the price is below 37 on those days. Note that the position does not change until the day after.
The strategy sells on day six, because the price is above 38. It does not sell on days one or two, because
although the price is above 38, the strategy has no units to sell on those days.

## Question 5.
 Write a function modify_position :: Float -> Float -> Float -> Float -> Float
that takes the buy price, the sell price, the strategies’ current position, and today’s price, and returns
the new position for the strategy. For example:
ghci> modify_position 37 38 1.0 36.5
2.0
ghci> modify_position 37 38 2.0 38.5
1.0
ghci> modify_position 37 38 0.0 38.5
0.0
In the first example, the position is increased by one because the current price is below the buy price.
In the second example, the position is decreased by one because the current price is above the sell price.
In the final example, the position is left unchanged, because although the price is above the sell price,
the current position is zero.

Question 6. Write a function final_position :: Float -> Float -> [Float] -> Float that takes
the buy price, the sell price, and a price series, and returns the final position of the strategy at the end
of the price series. This is the total number of units that the strategy is holding at the start of the final
day. For example:
ghci> final_position 37 38 (get_short_series 0)
2.0
Your implementation should use foldl. Hint: the modify_position function will be useful here.

Question 7. Write a function daily_position :: Float -> Float -> [Float] -> [Float] that
takes the buy price, the sell price, and a price series, and returns a list containing the daily positions of
the strategy, up to the start of the final day. You should report the position before trades are made for
the day. So, the first element of the list should always be zero, the second element should be the position
at the end of day one, and so on. For example:
ghci> daily_position 37 38 (get_short_series 0)
[0.0,0.0,0.0,0.0,1.0,1.0,0.0,1.0,2.0,2.0,2.0]
Your implementation should use scanl.
4

Question 8. The daily holding values of the strategy is the amount of money that we would get if we
sold all of our positions. So, if the strategy is holding two units, and today’s price is 37.52, the holding
value is 2 * 37.52 = 75.04.
Write a function daily_holding_values :: Float -> Float -> [Float] -> [Float] that takes
the buy price, the sell price, and a price series, and returns a list of the daily holding values for the
strategy. For each day, you should use the position before trades are executed, and the current price, so
the first element of the list will always be zero. For example:
ghci> daily_holding_values 37 38 (get_short_series 0)
[0.0,0.0,0.0,0.0,37.52,38.64,0.0,36.72,75.28,75.04]
Hint: you can use daily_position to get the list of daily positions, so you just need to multiply that
list with the price series to get the answer.

Part C (worth 35%)
In part C, we will build a portfolio value tracker. Look at the file sales.txt. It contains a list of trades
in the following format:
[Action] [Units] [Series] [Day]
The [Action] is either "BUY" or "SELL", the number of units is an integer indicating how much to buy
or sell, the series is an integer between zero and nine specifying the series to trade, and the day specifies
the which day the trade took place. So
BUY 100 4 2
specifies that one-hundred units of series four were bought on day two. The get_sales :: [String]
function will read the contents of sales.txt, and break into into a list of strings, with one entry for
each line in sales.txt. You may assume:
• The trades are given in chronological order, meaning that later trades appear later in the list.
• There is at most one trade each day. There may be some days with no trades.
• Every line of sales.txt contains exactly one trade.
• There is exactly one space between each of the parameters on each line of sales.txt. There are
no spaces before the action parameter, or after the day parameter.
• All unit numbers are positive floats. Every series number is an integer between 0 and 9. Every day
number is an integer between 1 and 1000.

Question 9. Write a function sales_final_position :: [String] -> [Float] that takes the list
of sales returned by get_sales, and returns a ten-element list containing the final positions for each of
the ten series. For example, if sales.txt contains the following lines:
BUY 100 0 1
BUY 100 4 2
SELL 50 4 4
BUY 10 3 6
SELL 10 3 9
then:
ghci> sales_final_position get_sales
[100.0,0.0,0.0,0.0,50.0,0.0,0.0,0.0,0.0,0.0]
because one-hundred units of series zero were bought, one-hundred units of series four were bought, and
then fifty units were later sold, and the transactions on series three cancelled each other out. If a trade
is listed that is not possible (eg. trying to sell one-hundred units of series nine when we currently have
no units of series nine) then that trade should be ignored. Hints:
5

• You are given a list of strings, so the first thing you will need to do is to parse this into a more useful
format. One reasonable format might be a list containing tuples of (Bool, Float, Int, Int),
where the parameters correspond to buy/sell, units, series, and day, respectively.
• One way of computing the final positions would be to use foldl. But the accumulator will be more
complex (not just a single number), and the folded function will need to modify that accumulator.

Question 10. Write a function sales_holding_value :: [String] -> [[Float]] -> [Float] that
takes the list of sales (returned by get_sales, the prices for all ten series (returned by get_data), and
returns a list containing the daily holding values for the positions specified by sales.txt.
Recall that the daily holding value is the amount of money that we would get by selling our positions
on that day. So, if on day two we are holding 10 units of series one and 20 units of series five, and the
price for series one is 2.0 and the price for series five is 3.0, then the holding value for day two is 10
* 2.0 + 20 * 3.0 = 80.0. You should calculate the holding value before executing the trades for the
day. The number of elements in the list returned by sales_holding_value should be the same as the
number of elements in the price series.
For example, using the example sales data given in Question 9:
ghci> sales_holding_value get_sales short_data
[0.0,3840.0002,63270.004,63039.0,33204.5,32803.5,89587.5,89284.5,90224.0,33137.0]
Note that the first element is 0.0, even though we buy on day one. This is because we calculate the
holding value before executing the trades for the day. Hints:
• If you solved Question 9 using foldl, then scanl will give a list-of-lists of partial positions (one
for each line in sales.txt).
• But remember, some days have no trades, so you will need to modify the output of scanl to deal
with this.
• Once you know the positions on each day, you can then multiply those positions by the prices to
get the final answer.

6


