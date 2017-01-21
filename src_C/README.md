# _n_-Queens Problem  
Author: James Walker  
©2017 under the [MIT license]  

## 8-Queens Solver in C  
Following the constrained DFS algorithm, a solver for the 8-queens problem was implemented using the C programming language. When executed, the 8-Queens Solver outputs all of the valid solutions for the 8-queens problem. Each solution will consist of 8 integers corresponding to the columns from A to H on the chess board, with each integer representing the row of the queen in the given column. In the example shown below, the numbers in the 8-queens solution `1 5 8 6 3 7 2 4` correspond to queen positions at `A1`, `B5`, `C8`, `D6`, `E3`, `F7`, `G2`, and `H4` on the chess board.  

<img src="./../img/8-Queens_Example.png" title="One Solution to the 8-Queens Problem" alt="8-Queens Solution Example" height="413" width="413"/>  

**Required Tools:**  
- C compiler such as [gcc] or eqivalent  

**Program Compilation, Execution and Partial Output:**  
<pre>$ gcc eight_queens_solver.c -o eight_queens_solver  
$ ./eight_queens_solver.exe  
1 5 8 6 3 7 2 4  
1 6 8 3 7 4 2 5  
...  
...  
8 3 1 6 2 5 7 4  
8 4 1 3 6 2 7 5</pre>  

[MIT license]: http://www.opensource.org/licenses/mit-license.php  
[gcc]: http://gcc.gnu.org/  
