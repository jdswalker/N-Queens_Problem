// N-Queens Placement and Solutions Counter
// Author: James Walker
// Copyrighted 2017 under the MIT license:
//   http://www.opensource.org/licenses/mit-license.php
//
// Purpose: 
//   The N-Queens Counter finds follows an improved version of the algorithm
//   used by the N-Queens Solver, except it does not return any of the
//   solutions. Instead, the program counts the number of solutions for a given
//   N-Queens problem as well as the number of times a queen is placed during
//   the program's execution.
// Compilation, Execution, and Partial Output:
//   $ gcc -std=c99 -O2 n_queens_counter.c -o n_queens_counter
//   $ ./n_queens_counter.exe 12
//   The 12-Queens problem required 428094 queen placements to find all 14200
//   solutions
//
// This implementation adapted from the algorithm provided at the bottom of
// this webpage:
//   www.cs.utexas.edu/users/EWD/transcriptions/EWD03xx/EWD316.9.html

#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// An abstract representation of an NxN chess board to tracking open positions
struct chess_board {
  uint32_t n_size;            // Number of queens on the NxN chess board
  uint32_t *queen_positions;  // Store queen positions on the board
  uint32_t *column;           // Store available column moves/attacks
  uint32_t *diagonal_up;      // Store available diagonal moves/attacks
  uint32_t *diagonal_down;
  uint32_t column_j;          // Stores column to place the next queen in
  uint64_t placements;        // Tracks total number queen placements
  uint32_t solutions;         // Tracks number of solutions
};
static struct chess_board *board;

// Handles dynamic memory allocation of the arrays and sets initial values
static void initialize_board(const uint32_t n_queens) {
  if (n_queens < 1) {
    fprintf(stderr, "The number of queens must be greater than 0.\n");
    exit(EXIT_FAILURE);
  }

  // Dynamically allocate memory for chessboard struct
  board = malloc(sizeof(struct chess_board));
  if (board == NULL) {
    fprintf(stderr, "Memory allocation failed for chess board.\n");
    exit(EXIT_FAILURE);
  }

  // Dynamically allocate memory for chessboard arrays that track positions
  const uint32_t diagonal_size = 2 * n_queens - 1;
  const uint32_t total_size = 2 * (n_queens + diagonal_size);
  board->queen_positions = malloc(sizeof(uint32_t) * total_size);
  if(board->queen_positions == NULL) {
    fprintf(stderr, "Memory allocation failed for the chess board arrays.\n");
    exit(EXIT_FAILURE);
  }
  board->column = &board->queen_positions[n_queens];
  board->diagonal_up = &board->column[n_queens];
  board->diagonal_down = &board->diagonal_up[diagonal_size];

  // Initialize the chess board parameters
  board->n_size = n_queens;
  for(uint32_t i = 0; i < n_queens; ++i) {
    board->queen_positions[i] = 0;
  }
  for(uint32_t i = n_queens; i < total_size; ++i) {
    // Initializes values for column, diagonal_up, and diagonal_down
    board->queen_positions[i] = 1;
  }
  board->column_j = 0;
  board->placements = 0;
  board->solutions = 0;
}

// Frees the dynamically allocated memory for the chess board structure
static void smash_board() {
  free(board->queen_positions);
  free(board);
}

// Check if a queen can be placed in at row 'i' of the current column
static uint32_t square_is_free(const uint32_t row_i) {
  return board->column[row_i] &
         board->diagonal_up[(board->n_size - 1) + (board->column_j - row_i)] &
         board->diagonal_down[board->column_j + row_i];
}

// Place a queen on the chess board at row 'i' of the current column
static void set_queen(const uint32_t row_i) {
  board->queen_positions[board->column_j] = row_i;
  board->column[row_i] = 0;
  board->diagonal_up[(board->n_size - 1) + (board->column_j - row_i)] = 0;
  board->diagonal_down[board->column_j + row_i] = 0;
  ++board->column_j;
  ++board->placements;
}

// Removes a queen from the NxN chess board in the given column to backtrack
static void remove_queen(const uint32_t row_i) {
  --board->column_j;
  board->diagonal_down[board->column_j + row_i] = 1;
  board->diagonal_up[(board->n_size - 1) + (board->column_j - row_i)] = 1;
  board->column[row_i] = 1;
}

// Prints the number of queen placements and solutions for the NxN chess board
static void print_counts() {
  // The next line fixes double-counting when solving the 1-queen problem
  const uint32_t solution_count = board->n_size == 1 ? 1 : board->solutions;
  const char const output[] = "The %u-Queens problem required %lu queen "
                              "placements to find all %u solutions\n";
  fprintf(stdout, output, board->n_size, board->placements, solution_count);
}

// Recursive function for finding valid queen placements on the chess board
static void place_next_queen(const uint32_t row_boundary) {
  const uint32_t middle = board->column_j ? board->n_size : board->n_size >> 1;
  for (uint32_t row_i = 0; row_i < row_boundary; ++row_i) {
    if (square_is_free(row_i)) {
      set_queen(row_i);
      if (board->column_j == board->n_size) {
        // Due to 2-fold symmetry of the chess board, accurate counts can be
        // obtained by only searching half the board and double-counting each
        // solution found (the sole exception being the 1-Queen problem)
        board->solutions += 2;
      } else if (board->queen_positions[0] != middle) {
        place_next_queen(board->n_size);
      } else {
        // This branch should only execute once at most, and only for odd
        // numbered N-Queens problems
        place_next_queen(middle);
      }
      remove_queen(row_i);
    }
  }
}

int main(int argc, char *argv[]) {
  static const uint32_t default_n = 4;
  const uint32_t n_queens = (argc != 1) ? (uint32_t)atoi(argv[1]) : default_n;
  initialize_board(n_queens);

  // Determines the index for the middle row to take advantage of board
  // symmetry when searching for solutions
  const uint32_t row_boundary = (n_queens >> 1) + (n_queens & 1);

  place_next_queen(row_boundary);  // Start solver algorithm
  print_counts();
  smash_board();  // Free dynamically allocated memory

  return EXIT_SUCCESS;
}
