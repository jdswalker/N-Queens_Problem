## Optimized n-Queens Queen Placement and Solutions Counter
## Author: James Walker
## Copyrighted 2017 under the MIT license:
##   http://www.opensource.org/licenses/mit-license.php
##
## Purpose: The optimized n-Queens Counter finds follows the same algorithm as
##   the n-Queens Solver, and produces the same output as the original
##   n-Queens Counter. That is, the program counts the number of solutions for
##   a given n-Queens problem as well as the number of times a queen is placed
##   during the program's execution. Unlike the original n-Queens Counter
##   program, the optimized version was written to increase execution
##   efficiency, not for code readability. Changes to the code structure and
##   syntax from the original implementation decreases the execution time by
##   approximately 100%. The optimization via the bytecode compiler decreases
##   the execution time of the optimized code by an additional 300%. Thus, the
##   optimized counter program runs approximately 8 times faster. 
## Example Usage:
##   > setwd('C:/Users/SomeUser/Desktop')
##   > source('n-Queens_Counter_Optimized.R')
##   > # Outputting solutions and placements for three n-queens problems:  
##   > for (n in 5:7) {
##   +   writeLines(CountNQueens(n))
##   + }
##   The 5-Queens problem required 53 queen placements to find all 10 solutions
##   The 6-Queens problem required 152 queen placements to find all 4 solutions
##   The 7-Queens problem required 551 queen placements to find all 40 solutions
##
## Based off the algorithm provided at the bottom of this webpage:
##   https://www.cs.utexas.edu/users/EWD/transcriptions/EWD03xx/EWD316.9.html

library('compiler')

# The Just-In-Time compiler converts functions into bytecode with level 3 being
# the highest optimization setting for the bytecode
enableJIT(3)

# Recursive function for finding valid queen placements on the chess board
PlaceNextQueen <- function(queens, col.j, moves, solver, n.queens) {
  for (row.i in 1:n.queens) {
    # Check if a queen can be placed on the current square
    if (moves[row.i] &
        moves[n.queens + n.queens + col.j + 1 - row.i] &
        moves[n.queens + n.queens + n.queens + col.j + row.i - 1]) {
      # Places a queen on the n x n chess board in the given column
      col.j <- col.j + 1
      queens[col.j] <- row.i
      moves[row.i] <- FALSE
      moves[n.queens + n.queens + col.j - row.i] <- FALSE
      moves[n.queens + n.queens + n.queens + col.j + row.i - 2] <- FALSE
      # Increments each time a queen is placed
      assign('placements', get('placements', envir = solver) + 1, envir = solver)
      if (col.j == n.queens) {
        # Increments each time a solution is found
        assign('solutions', get('solutions', envir = solver) + 1, envir = solver)
      } else {
        # Recursive call to find next queen placement on the chess board
        PlaceNextQueen(queens, col.j, moves, solver, n.queens)
        # Removes a queen from the n x n chess board in the given column to
        # backtrack
        moves[row.i] <- TRUE
        moves[n.queens + n.queens + col.j - row.i] <- TRUE
        moves[n.queens + n.queens + n.queens + col.j + row.i - 2] <- TRUE
        col.j <- col.j - 1
      }
    }
  }
}

# Starting point for the optimized n-Queens counter
CountNQueens <- function(n.queens) {
  if(n.queens > 0) {
    # Initializes the n x n chess board
    queens <- vector(mode = "integer", length = n.queens)
    col.j <- 0
    moves <- rep(TRUE, 5 * n.queens - 2)
    solver.env <- new.env()  # Defines solver to access placements and solutions
    solver.env$placements <- 0  # Total queens placed during execution
    solver.env$solutions <- 0  # Total number of solutions found
    # Begin counting n-queens placements and solutions
    PlaceNextQueen(queens, col.j, moves, solver.env, n.queens)
    # Returns a string with the counted results
    return(paste("The ", n.queens, "-Queens problem required ", 
                 solver.env$placements, " queen placements to find all ",
                 solver.env$solutions, " solutions", collapse = "", sep = ""))
  }
}
