# _n_-Queens Problem  
Author: James Walker  
©2017 under the [MIT license]  

## _n_-Queens Solvers Implemented in the C Programming Language  
Using the constrained DFS algorithm, a solver for the 8-queens problem was implemented using the C programming language. Following this, the 8-Queens Solver was used as a template to generalize the algorithm and write the _n_-Queens Solver, first in the R programming language, and later in the C programming language as well.  

When executed, the 8-Queens Solver outputs all of the valid solutions for the 8-queens problem. Each solution will consist of 8 integers corresponding to the columns from A to H on the chess board, with each integer representing the row of the queen in the given column. In the example shown below, the numbers in the 8-queens solution `1 5 8 6 3 7 2 4` correspond to queen positions at `A1`, `B5`, `C8`, `D6`, `E3`, `F7`, `G2`, and `H4` on the chess board.  

<img src="./../img/8-Queens_Example.png" title="One Solution to the 8-Queens Problem" alt="8-Queens Solution Example" height="413" width="413"/>  

While the 8-Queens Solver does not use dynamic allocation for any variables, the _n_-Queens Solver dynamically allocates a chess board struct containing multiple dynamically allocated integer arrays which enables it to solve _n_-queens problems using different values of _n_. The _n_-Queens Solver outputs the same style of output, but will do so far any positive integer value of _n_ passed into the program. If no value is passed, the program defaults to solving the 4-queens problem. Examples of both behaviours are provided below.  

**Required Tools:**  
- C99 compiler such as [gcc] or eqivalent  

**8-Queens Solver Compilation, Execution and Partial Output:**  
<pre>$ gcc eight_queens_solver.c -o eight_queens_solver  
$ ./eight_queens_solver.exe  
1 5 8 6 3 7 2 4  
1 6 8 3 7 4 2 5  
...  
...  
8 3 1 6 2 5 7 4  
8 4 1 3 6 2 7 5</pre>  

**_n_-Queens Solver Compilation, Execution and Example Output:**  
<pre>$ $ gcc -std=c99 n_queens_solver.c -o n_queens_solver
$ ./n_queens_solver.exe
2 4 1 3
3 1 4 2
$ ./n_queens_solver.exe 6
2 4 6 1 3 5
3 6 2 5 1 4
4 1 5 2 6 3
5 3 1 6 4 2</pre>  

[MIT license]: http://www.opensource.org/licenses/mit-license.php  
[gcc]: http://gcc.gnu.org/  
