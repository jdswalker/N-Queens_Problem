## n-Queens Solver
## Author: James Walker
## Copyrighted 2017 under the MIT license:
##   http://www.opensource.org/licenses/mit-license.php
## 
## Purpose: The n-Queens Solver finds solutions for the n-Queens problem. That
##   is, how many ways are there to place n chess queens on an n x n chess board
##   such that none of the queens can attack each other.
## Example Usage:
##   > setwd('C:/Users/SomeUser/Desktop')
##   > source('n-Queens_Solver.R')
##   > # Display solutions to the 4-queens problem in standard out:
##   > SolveNQueens(4)
##   The solver found 2 solutions for the 4-Queens problem  
##   Solution 1:     2 4 1 3
##   Solution 2:     3 1 4 2
##   > # Save solutions to the 4-queens problem in a plain-text file:
##   > SolveNQueens(4, 'FourQueensSolutions.txt')
## 
## This implementation is based off the algorithm provided at the bottom of this
## webpage: www.cs.utexas.edu/users/EWD/transcriptions/EWD03xx/EWD316.9.html

# Initializes starting values for the n x n chess board
InitializeBoard <- function(n.queens) {
  chess.board <- vector("list", 0)
  chess.board$queens <- vector(mode = "integer", length = n.queens)
  chess.board$row.index <- 0
  chess.board$column <- rep(TRUE, n.queens)
  chess.board$diagonal.up <- rep(TRUE, 2 * n.queens - 1)
  chess.board$diagonal.down <- rep(TRUE, 2 * n.queens - 1)
  return(chess.board)
}

# Check if a queen can be placed on the current square
SquareIsFree <- function(chess.board, n.queens, col.index) {
  return(chess.board$column[col.index + 1] &
         chess.board$diagonal.up[n.queens + chess.board$row.index - col.index] &
         chess.board$diagonal.down[chess.board$row.index + col.index + 1])
}

# Places a queen on the n x n chess board in the given column
SetQueen <- function(chess.board, n.queens, col.index) {
  chess.board$queens[chess.board$row.index + 1] <- col.index + 1
  chess.board$column[col.index + 1] <- FALSE
  chess.board$diagonal.up[n.queens + chess.board$row.index - col.index] <- FALSE
  chess.board$diagonal.down[chess.board$row.index + col.index + 1] <- FALSE
  chess.board$row.index <- chess.board$row.index + 1
  return(chess.board)
}

# Removes a queen from the n x n chess board in the given column to backtrack
RemoveQueen <- function(chess.board, n.queens, col.index) {
  chess.board$row.index <- chess.board$row.index - 1
  chess.board$column[col.index + 1] <- TRUE
  chess.board$diagonal.up[n.queens + chess.board$row.index - col.index] <- TRUE
  chess.board$diagonal.down[chess.board$row.index + col.index + 1] <- TRUE
  return(chess.board)
}

# Recursive function for finding valid queen placements on the chess board
PlaceNextQueen <- function(chess.board, n.queens, scope) {
  for (col.index in 0:(n.queens-1)) {
    if (SquareIsFree(chess.board, n.queens, col.index)) {
      chess.board <- SetQueen(chess.board, n.queens, col.index)
      if (chess.board$row.index == n.queens) {
        solved.list <- get('solutions', envir = scope)
        solved.list[length(solved.list) + 1] <- paste(chess.board$queens,
                                                      collapse = " ", sep = "")
        assign('solutions', solved.list, envir = scope)
      } else {
        PlaceNextQueen(chess.board, n.queens, scope)
        chess.board <- RemoveQueen(chess.board, n.queens, col.index)
      }
    }
  }
}

# Formats the output of the solutions
OutputSolutions <- function(solutions, n.queens, filename) {
  if (length(solutions) == 0) {
    cat(paste("No solutions were found for the ", n.queens,
              "-Queens problem:\n", collapse = "", sep = ""))
  } else {
    cat(paste("The solver found ", length(solutions), " solutions for the ",
              n.queens, "-Queens problem\n", collapse = "", sep = ""),
        file = filename, append = FALSE)
    solutions <- paste("Solution ", seq(1, length(solutions)), ":\t", solutions,
                       collapse = NULL, sep = "")
    cat(solutions, file = filename, sep = "\n", append = TRUE)
  }
}

# Starting point for the n-Queens solver
SolveNQueens <- function(n.queens, filename = "") {
  if (n.queens > 0) {
    solver.env <- new.env()
    solver.env$solutions <- character(0)
    PlaceNextQueen(InitializeBoard(n.queens), n.queens, solver.env)
    OutputSolutions(solver.env$solutions, n.queens, filename)
  }
}
