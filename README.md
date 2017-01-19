## n-Queens Problem  
Author: James Walker  
©2017 under the [MIT license](www.opensource.org/licenses/mit-license.php)  

#### Basic Program Overview  
The _n_-queens problem is a generalization of the [8-queens puzzle](wikipedia.org/wiki/Eight_queens_puzzle) involving how to place eight non-attacking queens on a regular [chess board](wikipedia.org/wiki/Chessboard). The _n_-queens problem asks, given a positive integer _n_,  how many ways are there to place _n_ chess queens on an _n_ x _n_ chess board such that none of the queens can attack each other.  

#### 8-Queens Solver in C  
**Required Tools:**  
- [gcc version 5.4](gcc.gnu.org/) or newer  

**Example of Program Compilation, Execution and Partial Output:**  
<pre>$ gcc eight_queens_solver.c -o eight_queens_solver  
$ ./eight_queens_solver.exe  
1 5 8 6 3 7 2 4  
1 6 8 3 7 4 2 5  
...  
...  
8 3 1 6 2 5 7 4  
8 4 1 3 6 2 7 5</pre>  

#### _n_-Queens Solver in R:  
**Required Tools:**  
- [R version 3.0](www.r-project.org/) or newer  

**Examples of Program Execution:**  
<pre>> # Outputting solutions to the 4-queens problem standard out  
> SolveNQueens(4)  
The solver found 2 solutions for the 4-Queens problem:  
Solution 1:     2 4 1 3  
Solution 2:     3 1 4 2  
> # Saving solutions to the 4-queens problem in a plain-text file:  
> SolveNQueens(4, 'FourQueensSolutions.txt')</pre>  

#### Algorithm Details  
The algorithm implemented to solve the _n_-queens problem was obtained online from the bottom of the webpage for [A Short Introduction to the Art of Programming](www.cs.utexas.edu/users/EWD/transcriptions/EWD03xx/EWD316.9.html) by [Dr. Edsger W. Dijkstra](https://en.wikipedia.org/wiki/Edsger_W._Dijkstra). The algorithm shown below has been adapted and reformatted from the one provided in the link above.  

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
