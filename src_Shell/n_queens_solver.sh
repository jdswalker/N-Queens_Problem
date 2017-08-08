#!/bin/bash -e

# N-Queens Problem Solver
# Author: James Walker
# Copyrighted 2017 under the MIT license:
#   http://www.opensource.org/licenses/mit-license.php
#
# Purpose: 
#   The N-Queens Solver searches the chess board for valid solutions to the
#   N-Queens problem and outputs them as they are found. Once complete, the
#   program also outputs the total number of solutions found for the N-Queens
#   problem as well as the number of times a queen was placed on the chess
#   board during the program's execution.
# Execution and Example Output:
#   $ bash ./n_queens_solver.sh 6
#   Solution 1:     2 4 6 1 3 5
#   Solution 2:     3 6 2 5 1 4
#   Solution 3:     4 1 5 2 6 3
#   Solution 4:     5 3 1 6 4 2
#                   
#   The 6-Queens problem required 152 queen placements
#   to find all 4 solutions
#
# This implementation was adapted from the algorithm provided at the bottom of
# this webpage:
#   www.cs.utexas.edu/users/EWD/transcriptions/EWD03xx/EWD316.9.html

# An abstract representation of an NxN chess board to tracking open positions
# Arguments from Parent Function:
#   N_SIZE              Size of the chess board
#   QUEEN_POSITIONS     Row positions of the queen on chess board by column
#   COLUMNS             Positions not threatened by a vertical attack move
#   DIAGONAL_UP         Positions not threatened by a diagonal attack move
#   DIAGONAL_DOWN
#   COLUMN_J            Index of the column currently being searched
#   PLACEMENTS          Total number of times that queens have been placed
#   SOLUTIONS           Number solutions found for the given N-Queens problem
# Returns:
#   None
n_queens::initialize_board() {
  # Queen positions and positions not threatened by a vertical attack move
  for (( i = 0; i < N_SIZE; i += 1 )); do
    QUEEN_POSITIONS[i]=0
    COLUMNS[i]=0
  done

  # Positions not threatened of a diagonal attack move
  local diagonal_array_size=$(( $(( 2 * N_SIZE )) - 1 ))
  for (( i = 0; i < diagonal_array_size; i += 1 )); do
    DIAGONAL_UP[i]=0
    DIAGONAL_DOWN[i]=0
  done

  COLUMN_J=0  # Current column index
  PLACEMENTS=0  # Number of queens placed on the board
  SOLUTIONS=0  # Number of N-Queens solutions found
}

# Check if a queen can be placed in at the given row in the current column
# Arguments from Parent Function:
#   N_SIZE              Size of the chess board
#   COLUMNS             Positions not threatened by a vertical attack move
#   DIAGONAL_UP         Positions not threatened by a diagonal attack move
#   DIAGONAL_DOWN
#   COLUMN_J            Index of the column currently being searched
# Returns:
#   A boolean value to indicate if the position on the board is unoccupied
n_queens::square_is_free() {
  echo $(( ${COLUMNS[row_i]} == 0
    && ${DIAGONAL_UP[diagonal_up_index]} == 0
    && ${DIAGONAL_DOWN[diagonal_down_index]} == 0 ))
}

# Places a queen on the chess board at the given row of the current column
# Arguments from Parent Function:
#   QUEEN_POSITIONS     Row positions of the queen on chess board by column
#   COLUMNS             Positions not threatened by a vertical attack move
#   DIAGONAL_UP         Positions not threatened by a diagonal attack move
#   DIAGONAL_DOWN
#   COLUMN_J            Index of the column currently being searched
#   PLACEMENTS      Total number of times that queens have been placed
#   row_i               Index of the row where the queen will be removed
#   diagonal_up_index   Index of the upward diagonal attack for the queen
#   diagonal_down_index Index of the downward diagonal attack for the queen
# Returns:
#   None
n_queens::set_queen() {
  QUEEN_POSITIONS[COLUMN_J]=$(( row_i + 1 ))
  COLUMNS[row_i]=1
  DIAGONAL_UP[diagonal_up_index]=1
  DIAGONAL_DOWN[diagonal_down_index]=1
  COLUMN_J=$(( COLUMN_J + 1 ))
  PLACEMENTS=$(( PLACEMENTS + 1 ))
}

# Removes a queen on the chess board at the given row of the current column
# Arguments from Parent Function:
#   COLUMNS             Positions not threatened by a vertical attack move
#   DIAGONAL_UP         Positions not threatened by a diagonal attack move
#   DIAGONAL_DOWN
#   COLUMN_J            Index of the column currently being searched
#   row_i               Index of the row where the queen will be removed
#   diagonal_up_index   Index of the upward diagonal attack for the queen
#   diagonal_down_index Index of the downward diagonal attack for the queen
# Returns:
#   None
n_queens::remove_queen() {
  COLUMNS[row_i]=0
  DIAGONAL_UP[diagonal_up_index]=0
  DIAGONAL_DOWN[diagonal_down_index]=0
  COLUMN_J=$(( COLUMN_J - 1 ))
}

# Recursive function for finding valid queen placements on the chess board
# Arguments from Parent Function:
#   N_SIZE              Size of the chess board
#   QUEEN_POSITIONS     Row positions of the queen on chess board by column
#   COLUMNS             Positions not threatened by a vertical attack move
#   DIAGONAL_UP         Positions not threatened by a diagonal attack move
#   DIAGONAL_DOWN
#   COLUMN_J            Index of the column currently being searched
#   SOLUTIONS           Number solutions found for the given N-Queens problem
# Returns:
#   None
n_queens::place_next_queen() {
  local row_i
  for (( row_i = 0; row_i < N_SIZE; row_i += 1 )); do
    local diagonal_up_index=$(( $(( N_SIZE - 1 )) + $(( COLUMN_J - row_i )) ))
    local diagonal_down_index=$(( COLUMN_J + row_i ))
    if (( $(n_queens::square_is_free) == 1 )); then
      n_queens::set_queen "${row_i}"
      if (( COLUMN_J == N_SIZE )); then
        SOLUTIONS=$(( SOLUTIONS + 1 ))
        echo -e "Solution ${SOLUTIONS}:\t${QUEEN_POSITIONS[@]}"
      else
        n_queens::place_next_queen
      fi
      n_queens::remove_queen "${row_i}"
    fi
  done
}

# Prints the number of queen placements and solutions for the NxN chess board
# Arguments from Parent Function:
#   N_SIZE              Size of the chess board
#   PLACEMENTS          Total number of times that queens have been placed
#   SOLUTIONS           Number solutions found for the given N-Queens problem
# Returns:
#   None
n_queens::print_counts() {
  echo
  echo "The ${N_SIZE}-Queens problem required ${PLACEMENTS} queen placements"
  echo "to find all ${SOLUTIONS} solutions"
}

main() {
  # Get number of queens (and size of chess board)
  local N_SIZE
  if (( $# != 0 )) && (( $1 > 0 )); then
    N_SIZE=$1
  else
    N_SIZE=4
  fi

  readonly N_SIZE       # Size of the chess board
  local QUEEN_POSITIONS # Row positions of the queen on chess board by column
  local COLUMNS         # Positions not threatened by a vertical attack move
  local DIAGONAL_UP     # Positions not threatened by a diagonal attack move
  local DIAGONAL_DOWN
  local COLUMN_J        # Index of the column currently being searched
  local PLACEMENTS      # Total number of times that queens have been placed
  local SOLUTIONS       # Number solutions found for the given N-Queens problem
  n_queens::initialize_board
  n_queens::place_next_queen
  n_queens::print_counts
}

main "$@"
