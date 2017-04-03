# _N_-Queens Problem  
Author: James Walker  
©2017 under the [MIT license]  

## _N_-Queens Counter in Python  
The Python implementations for the _N_-Queens Counter uses an improved version of the generalized _N_-queens solver algorithm that was implemented in the C and R programs. As with the C and R implementations, the counter program tracks the number of times a queen is placed on the chess board and the total number of valid solutions during execution of the algorithm. When the program finishes executing, both of these numbers are output. If no value is passed to the program when execution begins, both the _N_-Queens Counter programs default to solving the 4-queens problem. Examples of these behaviours are provided below.    

The improvement to the constrained DFS algorithm involved taking the symmetry of the chess board in to account. Particularly, the number of solutions to the _N_-queens problem when the placement of the first queen is fixed at the _k_<sup>th<sup/> row in the first column is always equal to the number of solutions when the placement of the first queen is fixed at the (_N_-_k_+1)<sup>th<sup/> row in the first column for 1 ≤ _k_ ≤ _N_. Thus, queens only need to be placed in the first _N_/2 rows of the first column to calculate the number of solutions for all N rows. A minor modification is needed for the middle row with odd numbers of _N_, but otherwise the principle remains the same.  

The _N_-Queens Multi-core Counter executes this improved algorithm as a set of parallel processes. Each process calculates a partial count for one of the first _N_/2 rows in the first column, and the resulting counts are then combined and doubled.

**Required Tools:**  
- A [Python 2.7] interpreter  

**Executing the _N_-Queens Counter Program:**  
```
$ python ./n_queens_counter.py  
The 4-Queens problem required 16 queen placements to find all 2 solutions  
$ python ./n_queens_counter.py 12
The 12-Queens problem required 428094 queen placements to find all 14200 solutions  
```  

[MIT license]: http://www.opensource.org/licenses/mit-license.php  
[Python 2.7]: http://www.python.org/download/releases/2.7/
