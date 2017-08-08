#!/bin/bash -e

# N-Queens Solution and Queen Placement Counter
# Author: James Walker
# Copyrighted 2017 under the MIT license:
#   http://www.opensource.org/licenses/mit-license.php
#
# Purpose: 
#   The N-Queens Counter finds valid solutions to the N-Queens problem and
#   outputs a count of the number of solutions found for a given N as well as
#   the number of times a queen was placed on the chess board during the
#   program's execution.
# Execution and Example Output:
#   $ bash ./n_queens_counter.sh 6
#   The 6-Queens problem required 152 queen placements
#   to find all 4 solutions
#
# This implementation was adapted from the algorithm provided at the bottom of
# this webpage:
#   www.cs.utexas.edu/users/EWD/transcriptions/EWD03xx/EWD316.9.html

# An abstract representation of an NxN chess board to tracking open positions
# Arguments from Parent Function:
#   N_SIZE          Size of the chess board
#   COLUMNS         Positions not threatened by a vertical attack move
#   DIAGONAL_UP     Positions not threatened by a diagonal attack move
#   DIAGONAL_DOWN
#   COLUMN_J        Index of the column currently being searched
#   PLACEMENTS      Total number of times that queens have been placed
#   SOLUTIONS       Number solutions found for the given N-Queens problem
# Returns:
#   None
n_queens::initialize_board() {
  # Positions not threatened by a vertical attack move
  for (( i = 0; i < N_SIZE; i += 1 )); do
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

# Recursive function for finding valid queen placements on the chess board
# Arguments from Parent Function:
#   N_SIZE          Size of the chess board
#   COLUMNS         Positions not threatened by a vertical attack move
#   DIAGONAL_UP     Positions not threatened by a diagonal attack move
#   DIAGONAL_DOWN
#   COLUMN_J        Index of the column currently being searched
#   SOLUTIONS       Number solutions found for the given N-Queens problem
# Returns:
#   None
n_queens::place_next_queen() {
  local row_i
  for (( row_i = 0; row_i < N_SIZE; row_i += 1 )); do
    local diagonal_up_index=$(( $(( N_SIZE - 1 )) + $(( COLUMN_J - row_i )) ))
    local diagonal_down_index=$(( COLUMN_J + row_i ))
    # Check if square is safe from attacks by other queens
    if (( ${COLUMNS[row_i]} == 0
        && ${DIAGONAL_UP[diagonal_up_index]} == 0
        && ${DIAGONAL_DOWN[diagonal_down_index]} == 0 )); then
      # Place the queen on the chess board
      COLUMNS[row_i]=1
      DIAGONAL_UP[diagonal_up_index]=1
      DIAGONAL_DOWN[diagonal_down_index]=1
      COLUMN_J=$(( COLUMN_J + 1 ))
      PLACEMENTS=$(( PLACEMENTS + 1 ))
      # If all columns have a queen in them, a valid solution has been found
      if (( COLUMN_J == N_SIZE )); then
        SOLUTIONS=$(( SOLUTIONS + 1 ))
      else
        n_queens::place_next_queen
      fi
      # Remove the queen from the chess board
      COLUMNS[row_i]=0
      DIAGONAL_UP[diagonal_up_index]=0
      DIAGONAL_DOWN[diagonal_down_index]=0
      COLUMN_J=$(( COLUMN_J - 1 ))
    fi
  done
}

# Prints the number of queen placements and solutions for the NxN chess board
# Arguments from Parent Function:
#   N_SIZE          Size of the chess board
#   PLACEMENTS      Total number of times that queens have been placed
#   SOLUTIONS       Number solutions found for the given N-Queens problem
# Returns:
#   None
n_queens::print_counts() {
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
