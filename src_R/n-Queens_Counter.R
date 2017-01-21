## n-Queens Queen Placement and Solutions Counter
## Author: James Walker
## Copyrighted 2017 under the MIT license:
##   http://www.opensource.org/licenses/mit-license.php
##
## Purpose: The n-Queens Counter finds follows the same algorithm as the
##   n-Queens Solver, except it does not return any of the solutions. Instead,
##   the program counts the number of solutions for a given n-Queens problem as
##   well as the number of times a queen is placed during the program's
##   execution.
## Example Usage:
##   > setwd('C:/Users/SomeUser/Desktop')
##   > source('n-Queens_Counter.R')
##   > # Outputting solutions and placements for three of the n-queens problems:
##   > for (n in 5:7) {
##   +   writeLines(CountNQueens(n))
##   + }
##   The 5-Queens problem required 53 queen placements to find all 10 solutions
##   The 6-Queens problem required 152 queen placements to find all 4 solutions
##   The 7-Queens problem required 551 queen placements to find all 40 solutions
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
  return(chess.board$column[col.index] &
         chess.board$diagonal.up[n.queens + chess.board$row.index + 1
                                 - col.index] &
         chess.board$diagonal.down[chess.board$row.index + col.index])
}

# Places a queen on the n x n chess board in the given column
SetQueen <- function(chess.board, n.queens, col.index) {
  chess.board$column[col.index] <- FALSE
  chess.board$diagonal.down[chess.board$row.index + col.index] <- FALSE
  chess.board$row.index <- chess.board$row.index + 1
  chess.board$diagonal.up[n.queens + chess.board$row.index - col.index] <- FALSE
  chess.board$queens[chess.board$row.index] <- col.index
  return(chess.board)
}

# Removes a queen from the n x n chess board in the given column to backtrack
RemoveQueen <- function(chess.board, n.queens, col.index) {
  chess.board$column[col.index] <- TRUE
  chess.board$diagonal.up[n.queens + chess.board$row.index - col.index] <- TRUE
  chess.board$row.index <- chess.board$row.index - 1
  chess.board$diagonal.down[chess.board$row.index + col.index] <- TRUE
  return(chess.board)
}

# Recursive function for finding valid queen placements on the chess board
PlaceNextQueen <- function(chess.board, n.queens, scope) {
  for (col.index in 1:n.queens) {
    if (SquareIsFree(chess.board, n.queens, col.index)) {
      chess.board <- SetQueen(chess.board, n.queens, col.index)
      # Increments each time a queen is placed
      assign('placements', get('placements', envir = scope) + 1, envir = scope)
      if (chess.board$row.index == n.queens) {
        # Increments each time a solution is found
        assign('solutions', get('solutions', envir = scope) + 1, envir = scope)
      } else {
        # Recursive call to find next queen placement on the chess board
        PlaceNextQueen(chess.board, n.queens, scope)
        chess.board <- RemoveQueen(chess.board, n.queens, col.index)
      }
    }
  }
}

# Starting point for the n-Queens counter
CountNQueens <- function(n.queens) {
  if(n.queens > 0) {
    solver.env <- new.env()  # Defines scope to access placements and solutions
    solver.env$placements <- 0  # Total queens placed during execution
    solver.env$solutions <- 0  # Total number of solutions found
    # Begin counting n-queens placements and solutions
    PlaceNextQueen(InitializeBoard(n.queens), n.queens, solver.env)
    # Returns a string with the counted results
    return(paste("The ", n.queens, "-Queens problem required ",
                 solver.env$placements, " queen placements to find all ",
                 solver.env$solutions, " solutions", collapse = "", sep = ""))
  }
}
