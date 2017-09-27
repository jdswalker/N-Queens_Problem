# _N_-Queens Problem  
Author: [James Walker](http://github.com/JDSWalker)  
©2017 under the [MIT license]  

## _N_-Queens Solver and _N_-Queens Counter using the Go Programming Language  
There are two _N_-queens-related implementations, a problem solver and a 
solution counter. The _N_-Queens Solver, given a positive integer _N_, will 
output all of the valid solutions for the _N_-queens problem (execution details 
are provided below). The _N_-Queens Counter is similar to the 
_N_-Queens Solver, but instead finds valid solutions to the N-Queens problem 
and outputs a count of the number of solutions found for the given _N_ as well 
as the number of times a queen was placed on the chess board during the program'
s execution. On a side note, the _N_-Queens Counter executes much faster than 
the _N_-Queens Solver due to inlining most of the function calls.  

Similar to the 8-queens solver in the `src_C` folder, each solution will consist of _N_ integers corresponding to the _N_ columns on the chess board, with each integer representing the row of the queen in the given column. In the example shown below, the numbers in the 8-queens solution `1 5 8 6 3 7 2 4` are sequentially ordered by column from A to H. Thus, queens are positioned on the chess board at `A1`, `B5`, `C8`, `D6`, `E3`, `F7`, `G2`, and `H4`.  

<img src="./../img/8-Queens_Example.png" title="One Solution to the 8-Queens Problem" alt="8-Queens Solution Example" height="413" width="413"/>   

**Required Tools:**  
- Go compiler for version 1.9+

**Executing the _N_-Queens Solver Program:**  
```  
$ cd 'C:/Users/SomeUser/Desktop'  
$ go run n_queens_solver.go 6  
2 4 6 1 3 5  
3 6 2 5 1 4  
4 1 5 2 6 3  
5 3 1 6 4 2  
```  

**Executing the _N_-Queens Counter Program:**  
```  
$ cd 'C:/Users/SomeUser/Desktop'  
$ go n_queens_counter.go 6  
The 6-Queens problem required 152 queen placements to find all 4 solutions  
```  

[MIT license]: http://www.opensource.org/licenses/mit-license.php  
