# _n_-Queens Problem  
Author: James Walker  
©2017 under the [MIT license](www.opensource.org/licenses/mit-license.php)  

## Overview  
The _n_-queens problem is a generalization of the [8-queens puzzle](wikipedia.org/wiki/Eight_queens_puzzle) involving how to place eight non-attacking queens on a regular [chess board](wikipedia.org/wiki/Chessboard). The _n_-queens problem asks, given a positive integer _n_,  how many ways are there to place _n_ chess queens on an _n_ × _n_ chess board such that none of the queens can attack each other.  

The programs in this repository implement a constrainted depth-first search (DFS) algorithm to find solutions to the _n_-queens problem. Descriptions of the programs in the `src_C` and `src_R` folders are provided below, followed by some general results from running these programs. Lastly, the full constrainted DFS algorithm for solving the 8-queens problem is outlined and sourced.  
  
### 8-Queens Solver in C  
Following the constrained DFS algorithm, a solver for the 8-queens problem was implemented using the C programming language. When executed, the 8-Queens Solver outputs all of the valid solutions for the 8-queens problem. Each solution consists of 8 integers corresponding to the columns on the chess board from A to H. Each integer represents the row of the queen in the given column. For example, the solution `1 5 8 6 3 7 2 4` is represented by the following chess board:  

<img src="./img/8-Queens_Example.png" title="One Solution to the 8-Queens Problem" alt="8-Queens Solution Example" height="413" width="413"/>  
  
**Required Tools:**  
- [gcc version 5.4](gcc.gnu.org/) or newer  

**Program Compilation, Execution and Partial Output:**  
<pre>$ gcc eight_queens_solver.c -o eight_queens_solver  
$ ./eight_queens_solver.exe  
1 5 8 6 3 7 2 4  
1 6 8 3 7 4 2 5  
...  
...  
8 3 1 6 2 5 7 4  
8 4 1 3 6 2 7 5</pre>  
  
### _n_-Queens Solver and _n_-Queens Counter in R  
After generalizing the algorithm used to solve the 8-queens problem, a solver for _n_-queens problems was implemented using the R programming language. There are two _n_-queens-related implementations, a solver and a counter. The _n_-Queens Solver, given a positive integer _n_, will output all of the valid solutions for the _n_-queens problem like the 8-Queens Solver above. Alternatively, the solutions can be saved to a plain-text file instead if a filename is also provided. As before, each solution will consist of _n_ integers corresponding to the _n_ columns on the chess board, with each integer representing the row of the queen in the given column.  

The _n_-Queens Counter uses the same generalized algorithm as the solver, but it does not store or output solutions. Instead, the counter program merely tracks the total number of valid solutions during execution of the algorithm. Additionally, the number of times a queen is placed on the board is also tracked by the program to provide an indication of the algorithm's efficiency. When the program finishes executing, both of these numbers are output.  

**Required Tools:**  
- [R version 3.0](www.r-project.org/) or newer  

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
  
### Number Solutions for _n_-Queens Problems  
The _n_-Queens Counter program has been used to find the number of queen placements and the number of _n_-queens solutions for values of _n_ between 1 and 14, with results summarized below. Since the program took close to an hour to execute for _n_ = 14, higher values of _n_ have not been attempted with this implementation. From the results determined so far, it is obvious that the constrained DFS algorithm significantly reduces the search-space of the problem compared to the _n_!/(_n_ − 1)! placements that would be made by most naïve combinatorial algorithm.  

| <div style="text-align: center;"><em>n</em></div> | <div style="text-align: center;">Number of</div><div style="text-align: center;">Queens Placed</div><div style="text-align: center;">(<em>Naïve</em>)</div> | <div style="text-align: center;">Number of</div><div style="text-align: center;">Queens Placed</div><div style="text-align: center;">(<em>Constrained</em>)</div> | <div style="text-align: center;">Number of</div><div style="text-align: center;">Solutions</div> |  
|---:|------------------------:|-----------:|----------:|  
|  1 |                       1 |          1 |         1 |  
|  2 |                      12 |          2 |         0 |  
|  3 |                     504 |          5 |         0 |  
|  4 |                  43,680 |         16 |         2 |  
|  5 |               6,375,600 |         53 |        10 |  
|  6 |  1.402 × 10<sup>9</sup> |        152 |         4 |  
|  7 | 4.329 × 10<sup>11</sup> |        551 |        40 |  
|  8 | 1.785 × 10<sup>14</sup> |      2,056 |        92 |  
|  9 | 9.467 × 10<sup>16</sup> |      8,393 |       352 |  
| 10 | 6.282 × 10<sup>19</sup> |     35,538 |       724 |  
| 11 | 5.096 × 10<sup>22</sup> |    166,925 |     2,680 |  
| 12 | 4.963 × 10<sup>25</sup> |    856,188 |    14,200 |  
| 13 | 5.714 × 10<sup>28</sup> |  4,674,889 |    73,712 |  
| 14 | 7.676 × 10<sup>31</sup> | 27,358,552 |   365,596 |  
| 15 | 1.190 × 10<sup>35</sup> |        ??? | 2,279,184 |  

According to the [On-Line Encyclopedia of Integer Sequences](oeis.org) (OEIS sequence: [A000170](oeis.org/A000170)), the number of solutions for the _n_-queens problem have been determined every value of _n_ up to 27.  

### Constrained DFS Algorithm Details  
The algorithm implemented to solve the 8-queens problem was obtained online from the bottom of the webpage for [A Short Introduction to the Art of Programming](www.cs.utexas.edu/users/EWD/transcriptions/EWD03xx/EWD316.9.html) by [Dr. Edsger W. Dijkstra](https://en.wikipedia.org/wiki/Edsger_W._Dijkstra). The 8-queens solver algorithm, shown below, has been adapted and reformatted from the one provided in the link above.  

<pre>begin ALGORITHM  
  integer n  
  integer h  
  integer k  
  integer array x[0:7]  
  boolean array col[0:7]  
  boolean array up[-7:+7]  
  boolean array down[0:14]  
  procedure PLACE NEXT QUEEN:  
    h := 0  
    repeat until h = 8:  
      if SQUARE H FREE (col[h] = true AND up[n-h] = true AND down[n+h] = true):  
        begin SET QUEEN ON SQUARE H:  
          x[n] := h  
          col[h] := false  
          up[n-h] := false  
          down[n+h] := false  
          n := n + 1  
        end SET QUEEN ON SQUARE H  
        if BOARD FULL (n = 8):  
          begin PRINT QUEEN POSITIONS:  
            k := 0  
            repeat until k = 8  
              print(x[k])  
              k := k + 1  
            end repeat  
            print(newline)  
          end PRINT QUEEN POSITIONS  
        else BOARD NOT FULL:  
          PLACE NEXT QUEEN  
          begin REMOVE QUEEN FROM SQUARE H:  
            n := n - 1  
            down[n+h] := true  
            up[n-h] := true  
            col[h] := true  
          end REMOVE QUEEN FROM SQUARE H  
        end if BOARD FULL  
      end if SQUARE H FREE  
      h := h + 1  
    end repeat  
  end procedure PLACE NEXT QUEEN  
  begin INITIALIZE EMPTY BOARD:  
    n := 0  
    k := 0  
    repeat until k = 8  
      col[k] := true  
      k := k + 1  
    end repeat  
    k := 0  
    repeat until k = 15  
      up[k-7] := true  
      down[k] := true  
      k := k + 1  
    end repeat  
  end INITIALIZE EMPTY BOARD
  PLACE NEXT QUEEN  
end ALGORITHM</pre>   
