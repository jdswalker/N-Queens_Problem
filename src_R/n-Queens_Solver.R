## n-Queens Solver
## Author: James Walker
## Copyrighted 2017 under the MIT license:
##   http://www.opensource.org/licenses/mit-license.php
##
## Based off the algorithm provided at the bottom of this webpage:
##   https://www.cs.utexas.edu/users/EWD/transcriptions/EWD03xx/EWD316.9.html

# Initializes starting values for the chess board
initialize_board <- function(n_queens) {
  chess_board <- vector("list", 0)
  chess_board$queens <- vector(mode = "integer", length = n_queens)
  chess_board$row_index <- 0
  chess_board$column <- rep(TRUE, n_queens) 
  chess_board$diagonal_up <- rep(TRUE, 2 * n_queens - 1)
  chess_board$diagonal_down <- rep(TRUE, 2 * n_queens - 1)

  return(chess_board)
}

# Check if a queen can be placed on the current square
square_is_free <- function(chess_board, n_queens, col_index) {

  return(chess_board$column[col_index + 1] &
         chess_board$diagonal_up[n_queens + chess_board$row_index - col_index] &
         chess_board$diagonal_down[chess_board$row_index + col_index + 1])
}


set_queen <- function(chess_board, n_queens, col_index) {
  
  chess_board$queens[chess_board$row_index + 1] <- col_index + 1
  chess_board$column[col_index + 1] <- FALSE
  chess_board$diagonal_up[n_queens + chess_board$row_index - col_index] <- FALSE
  chess_board$diagonal_down[chess_board$row_index + col_index + 1] <- FALSE
  chess_board$row_index <- chess_board$row_index + 1

  return(chess_board)
}

# Removes a queen from the n x n chess board in the given column to backtrack
remove_queen <- function(chess_board, n_queens, col_index) {
  
  chess_board$row_index <- chess_board$row_index - 1
  chess_board$column[col_index + 1] <- TRUE
  chess_board$diagonal_up[n_queens + chess_board$row_index - col_index] <- TRUE
  chess_board$diagonal_down[chess_board$row_index + col_index + 1] <- TRUE
  
  return(chess_board)
}

# Recursive function for finding valid queen placements on the chess board
place_next_queen <- function(chess_board, n_queens, scope) {

  for (col_index in 0:(n_queens-1)) {
    if (square_is_free(chess_board, n_queens, col_index)) {
      chess_board <- set_queen(chess_board, n_queens, col_index)
      
      if (chess_board$row_index == n_queens) {
        solved_list <- get('solutions', envir = scope)
        solved_list[length(solved_list) + 1] <- paste(chess_board$queens,
                                                      collapse = " ", sep = "")
        assign('solutions', solved_list, envir = scope)
      } else {
        place_next_queen(chess_board, n_queens, scope)
        chess_board <- remove_queen(chess_board, n_queens, col_index)
      }
    }
  }
}

# Formats the output of the solutions
output_solutions <- function(solutions, n_queens, filename) {

  if(length(solutions) == 0) {
    cat(paste("No solutions were found for the ", n_queens, "-Queens problem\n",
              collapse = "", sep = ""))
  } else {
    cat(paste("The solver found ", length(solutions), " solutions for the ",
              n_queens, "-Queens problem\n", collapse = "", sep = ""),
        file = filename, append = FALSE)
    solutions <- paste("Solution ", seq(1, length(solutions)), ":\t", solutions,
                       collapse = NULL, sep = "")
    cat(solutions, file = filename, sep = "\n", append = TRUE)
  }
}

# Starting point for the n-Queens solver
solve_n_queens <- function(n_queens, filename = "") {
  if(n_queens > 0) {
    solver.env <- new.env()
    solver.env$solutions <- character(0)
    place_next_queen(initialize_board(n_queens), n_queens, solver.env)
    output_solutions(solver.env$solutions, n_queens, filename)
  }
}
