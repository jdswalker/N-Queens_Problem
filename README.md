## n-Queens Problem  
Author: James Walker  
©2017 under the [MIT license](www.opensource.org/licenses/mit-license.php)  

#### Basic Program Overview  
The _n_-queens problem is a generalization of the [8-queens puzzle](https://en.wikipedia.org/wiki/Eight_queens_puzzle) for placing 8 non-attacking queens on a regular chess board. The _n_-queens problem asks, given a positive integer _n_,  how many ways are there to place _n_ chess queens on an _n_x_n_ chess board such that none of the queens can attack each other.  

#### Required Tools for 8-Queens Solver in C:  
- [gcc version 5.4](gcc.gnu.org/)  or newer  

#### C Program Compilation and Execution:  
<pre>$ gcc eight_queens_solver.c -o eight_queens_solver  
$ ./eight_queens_solver.exe</pre>  

#### Required Tools for _n_-Queens Solver in R:  
- [R version 3.0](www.r-project.org/) or newer  

#### Algorithm Details  
The algorithm implemented to solve the n-queens problem was obtained online from the bottom of the webpage for [A Short Introduction to the Art of Programming](www.cs.utexas.edu/users/EWD/transcriptions/EWD03xx/EWD316.9.html) by [Dr. Edsger W. Dijkstra](https://en.wikipedia.org/wiki/Edsger_W._Dijkstra). The algorithm shown below has been adapted and reformatted from the one provided in the link above.  

<pre>begin ALGORITHM  
  integer n  
  integer k  
  integer array x[0:7]  
  boolean array col[0:7]  
  boolean array up[-7:+7]  
  boolean array down[0:14]  
  procedure PLACE NEXT QUEEN:  
    integer h := 0  
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
