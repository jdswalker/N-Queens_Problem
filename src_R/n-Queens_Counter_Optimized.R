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
##   syntax from the original implementation increased the execution speed by
##   approximately 60% to 70%. The bytecode compiler and optimization increased
##   the execution speed by an additional 330% to 350%. Thus, the optimized
##   counter program runs 7 to 8 times faster. 
## Example Usage:
##   > setwd('C:/Users/SomeUser/Desktop')
##   > source('n-Queens_Solver.R')
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
PlaceNextQueen <- function(chess.board, n.queens, scope) {
  for (col.index in 1:n.queens) {
    # Check if a queen can be placed on the current square
    if (chess.board[[3]][col.index] &
        chess.board[[4]][n.queens + chess.board[[2]] + 1 - col.index] &
        chess.board[[5]][chess.board[[2]] + col.index]) {
      # Places a queen on the n x n chess board in the given column
      chess.board[[3]][col.index] <- FALSE
      chess.board[[5]][chess.board[[2]] + col.index] <- FALSE
      chess.board[[2]] <- chess.board[[2]] + 1
      chess.board[[4]][n.queens + chess.board[[2]] - col.index] <- FALSE
      chess.board[[1]][chess.board[[2]]] <- col.index
      # Increments each time a queen is placed
      assign('placements', get('placements', envir = scope) + 1, envir = scope)
      if (chess.board[[2]] == n.queens) {
        # Increments each time a solution is found
        assign('solutions', get('solutions', envir = scope) + 1, envir = scope)
      } else {
        # Recursive call to find next queen placement on the chess board
        PlaceNextQueen(chess.board, n.queens, scope)
        # Removes a queen from the n x n chess board in the given column to
        # backtrack
        chess.board[[3]][col.index] <- TRUE
        chess.board[[4]][n.queens + chess.board[[2]] - col.index] <- TRUE
        chess.board[[2]] <- chess.board[[2]] - 1
        chess.board[[5]][chess.board[[2]] + col.index] <- TRUE
      }
    }
  }
}

# Starting point for the optimized n-Queens counter
CountNQueens <- function(n.queens) {
  if(n.queens > 0) {
    solver.env <- new.env()  # Defines scope to access placements and solutions
    solver.env$placements <- 0  # Total queens placed during execution
    solver.env$solutions <- 0  # Total number of solutions found
    # Initializes the n x n chess board
    chess.board <- vector("list", 5)
    chess.board[[1]] <- vector(mode = "integer", length = n.queens) # queens
    chess.board[[2]] <- 0 # row index
    chess.board[[3]] <- rep(TRUE, n.queens)  # free column positions
    chess.board[[4]] <- rep(TRUE, 2 * n.queens - 1)  # free upward diagonals
    chess.board[[5]] <- rep(TRUE, 2 * n.queens - 1)  # free downward diagonals
    # Begin counting n-queens placements and solutions
    PlaceNextQueen(chess.board, n.queens, solver.env)
    # Returns a string with the counted results
    return(paste("The ", n.queens, "-Queens problem required ", 
                 solver.env$placements, " queen placements to find all ",
                 solver.env$solutions, " solutions", collapse = "", sep = ""), sep = "\n")
  }
}
