# _N_-Queens Problem  
Author: James Walker  
©2017 under the [MIT license]  

## _N_-Queens Solvers Implemented in the C Programming Language  
Using the constrained DFS algorithm, a solver for the 8-queens problem was implemented using the C programming language. Following this, the 8-Queens Solver was used as a template to generalize the algorithm and write the _N_-Queens Solver, first in the R programming language, and later in the C programming language as well. The _N_-Queens Counter is a slightly modified version of the solver program which does not output solutions, but instead counts the total number of solutions for a given n-queens problem and the total number of queens placed on the board during the execution of the program.  

When executed, the 8-Queens Solver outputs all of the valid solutions for the 8-queens problem. Each solution will consist of 8 integers corresponding to the columns from A to H on the chess board, with each integer representing the row of the queen in the given column. In the example shown below, the numbers in the 8-queens solution `1 5 8 6 3 7 2 4` correspond to queen positions at `A1`, `B5`, `C8`, `D6`, `E3`, `F7`, `G2`, and `H4` on the chess board.  

<img src="./../img/8-Queens_Example.png" title="One Solution to the 8-Queens Problem" alt="8-Queens Solution Example" height="413" width="413"/>  

While the 8-Queens Solver does not use dynamic allocation for any variables, the _N_-Queens Solver and _N_-Queens Counter programs dynamically allocate a chess board struct containing multiple dynamically allocated integer arrays which enables it to solve _N_-queens problems using different values of _N_. The _N_-Queens Solver outputs the same style of output as the 8-Queens Solver, but will do so for any positive integer value of _N_ passed into the program. If no value is passed to the program when execution begins, both the _N_-Queens Solver and _N_-Queens Counter programs default to solving the 4-queens problem. Examples of these behaviours are provided below.  

**Required Tools:**  
- make  
- C99 compiler such as [gcc] or eqivalent  

**8-Queens Solver Compilation, Execution and Partial Output:**  
```
$ make eight_queens_solver  
gcc -std=c99 -Wall -Werror eight_queens_solver.c -o eight_queens_solver  
$ ./eight_queens_solver.exe  
1 5 8 6 3 7 2 4  
1 6 8 3 7 4 2 5  
...  
...  
8 3 1 6 2 5 7 4  
8 4 1 3 6 2 7 5  
```  

**_N_-Queens Solver Compilation, Execution and Example Output:**  
```
$ make n_queens_solver  
gcc -std=c99 -Wall -Werror nqueens_solver.c -o n_queens_solver  
$ ./n_queens_solver.exe  
2 4 1 3  
3 1 4 2  
$ ./n_queens_solver.exe 6  
2 4 6 1 3 5  
3 6 2 5 1 4  
4 1 5 2 6 3  
5 3 1 6 4 2  
```  

**_N_-Queens Counter Compilation, Execution and Example Output:**  
```
$ make n_queens_counter  
gcc -std=c99 -O2 -Wall -Werror n_queens_counter.c -o n_queens_counter  
$ ./n_queens_counter.exe  
The 4-Queens problem required 16 queen placements to find all 2 solutions  
$ ./n_queens_counter.exe 12  
The 12-Queens problem required 856188 queen placements to find all 14200 solutions  
```  

[MIT license]: http://www.opensource.org/licenses/mit-license.php  
[gcc]: http://gcc.gnu.org/  
