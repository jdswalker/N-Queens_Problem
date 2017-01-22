# _n_-Queens Problem  
Author: James Walker  
©2017 under the [MIT license]  

## _n_-Queens Solver and _n_-Queens Counter in R  
After generalizing the algorithm used to solve the 8-queens problem, a solver for _n_-queens problems was implemented using the R programming language. There are two _n_-queens-related implementations, a solver and a counter. The _n_-Queens Solver, given a positive integer _n_, will output all of the valid solutions for the _n_-queens problem. Alternatively, the solutions can be saved to a plain-text file instead if a filename is also provided (execution details are provided below).  

Similar to the 8-queens solver in the `src_C` folder, each solution will consist of _n_ integers corresponding to the _n_ columns on the chess board, with each integer representing the row of the queen in the given column. In the example shown below, the numbers in the 8-queens solution `1 5 8 6 3 7 2 4` are sequentially ordered by column from A to H. Thus, queens are positioned on the chess board at `A1`, `B5`, `C8`, `D6`, `E3`, `F7`, `G2`, and `H4`.  

<img src="./../img/8-Queens_Example.png" title="One Solution to the 8-Queens Problem" alt="8-Queens Solution Example" height="413" width="413"/>  

The _n_-Queens Counter uses the same generalized algorithm as the solver, but it does not store or output solutions. Instead, the counter program merely tracks the total number of valid solutions during execution of the algorithm. Additionally, the number of times a queen is placed on the board is also tracked by the program to provide an indication of the algorithm's efficiency. When the program finishes executing, both of these numbers are output. The optimized _n_-Queens Counter program functions identically, but executes approximately 8 times faster than the original program.  

**Required Tools:**  
- [R version 3.0] or equivalent  

**Executing the _n_-Queens Solver Program:**  
<pre>> setwd('C:/Users/SomeUser/Desktop')  
> source('n-Queens_Solver.R')  
> # Outputting solutions to the 4-queens problem standard out  
> SolveNQueens(4)  
The solver found 2 solutions for the 4-Queens problem:  
Solution 1:     2 4 1 3  
Solution 2:     3 1 4 2  
> # Saving solutions to the 4-queens problem in a plain-text file  
> SolveNQueens(4, 'FourQueensSolutions.txt')</pre>  

**Executing the _n_-Queens Counter Program:**  
<pre>> setwd('C:/Users/SomeUser/Desktop')  
> source('n-Queens_Counter.R')  
> # Outputting solutions and placements for three of the n-queens problems  
> for (n in 5:7) {  
+   writeLines(CountNQueens(n))  
+ }  
The 5-Queens problem required 53 queen placements to find all 10 solutions  
The 6-Queens problem required 152 queen placements to find all 4 solutions  
The 7-Queens problem required 551 queen placements to find all 40 solutions</pre>  

[MIT license]: http://www.opensource.org/licenses/mit-license.php  
[R version 3.0]: http://www.r-project.org/  
