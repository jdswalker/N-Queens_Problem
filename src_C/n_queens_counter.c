// N-Queens Placement and Solutions Counter
// Author: James Walker
// Copyrighted 2017 under the MIT license:
//   http://www.opensource.org/licenses/mit-license.php
//
// Purpose: 
//   The N-Queens Counter finds follows the same algorithm as the N-Queens 
//   Solver, except it does not return any of the solutions. Instead, the 
//   program counts the number of solutions for a given N-Queens problem as 
//   well as the number of times a queen is placed during the program's
//   execution.
// Compilation, Execution, and Partial Output:
//   $ gcc -std=c99 -O2 n_queens_counter.c -o n_queens_counter
//   $ ./n_queens_counter.exe 12
//   The 12-Queens problem required 856188 queen placements to find all 14200
//   solutions
//
// This implementation is based off the algorithm provided at the bottom of this
// webpage: www.cs.utexas.edu/users/EWD/transcriptions/EWD03xx/EWD316.9.html

#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct chess_board {
  // Chess board variables
  uint32_t n_size;            // Number of queens on the NxN chess board
  uint32_t *queen_positions;  // Store queen positions on the board
  uint32_t *column;           // Store available column moves/attacks
  uint32_t *diagonal_up;      // Store available diagonal moves/attacks
  uint32_t *diagonal_down;
  uint32_t column_j;          // Store current column to examine on the board
  uint64_t placements;        // Tracks total number queen placements
  uint32_t solutions;         // Tracks number of solutions
};

struct chess_board *initialize_board(const int n_queens) {
  if (n_queens < 1) {
    fprintf(stderr, "The number of queens must be greater than 0.\n");
    exit(EXIT_FAILURE);
  }

  // Dynamically allocate memory for chessboard
  struct chess_board *board = malloc(sizeof(struct chess_board));
  if (board == NULL) {
    fprintf(stderr, "Memory allocation failed for chess board.\n");
    exit(EXIT_FAILURE);
  }

  // Dynamically allocate memory for chessboard arrays that track positions
  const int diagonal_size = 2 * n_queens - 1;
  const int total_size = 2 * (n_queens + diagonal_size);
  board->queen_positions = malloc(sizeof(uint32_t) * total_size);
  if(board->queen_positions == NULL) {
    fprintf(stderr, "Memory allocation failed for the chess board arrays.\n");
    exit(EXIT_FAILURE);
  }
  board->column = &board->queen_positions[n_queens];
  board->diagonal_up = &board->column[n_queens];
  board->diagonal_down = &board->diagonal_up[diagonal_size];

  // Initialize the chess board variables
  board->n_size = n_queens;
  for(int i = 0; i < n_queens; ++i) {
    board->queen_positions[i] = 0;
  }
  for(int i = n_queens; i < total_size; ++i) {
    // Initializes values for column, diagonal_up, and diagonal_down
    board->queen_positions[i] = 1;
  }
  board->column_j = 0;
  board->placements = 0;
  board->solutions = 0;

  return board;
}

// Frees the dynamically allocated memory for the chess board structure
void smash_board(struct chess_board *board) {
  free(board->queen_positions);
  free(board);
}

// Check if a queen can be placed in column 'i', at row 'j'
int square_is_free(const struct chess_board *board, const int row_i) {
  return board->column[row_i] &
         board->diagonal_up[(board->n_size - 1) + (board->column_j - row_i)] &
         board->diagonal_down[board->column_j + row_i];
}

// Place a queen on the chess board
void set_queen(struct chess_board *board, const int row_i) {
  board->queen_positions[board->column_j] = row_i;
  board->column[row_i] = 0;
  board->diagonal_up[(board->n_size - 1) + (board->column_j - row_i)] = 0;
  board->diagonal_down[board->column_j + row_i] = 0;
  ++board->column_j;
  ++board->placements;
}

// Removes a queen from the NxN chess board in the given column to backtrack
void remove_queen(struct chess_board *board, const int row_i) {
  --board->column_j;
  board->diagonal_down[board->column_j + row_i] = 1;
  board->diagonal_up[(board->n_size - 1) + (board->column_j - row_i)] = 1;
  board->column[row_i] = 1;
}

// Prints the number of queen placements and solutions for the NxN chess board
void print_counts(const struct chess_board *board) {
  const char *output = "The %d-Queens problem required "
                       "%"PRIu64" queen placements to find all %d solutions\n";
  fprintf(stdout, output, board->n_size, board->placements, board->solutions);
}

// Recursive function for finding valid queen placements on the chess board
void place_next_queen(struct chess_board *board) {
  for (uint32_t row_i = 0; row_i < board->n_size; ++row_i) {
    if (square_is_free(board, row_i)) {
      set_queen(board, row_i);
      if (board->column_j == board->n_size) {
        // Chess board has NxN queens set
        ++board->solutions;
      } else {
        place_next_queen(board);
      }
      remove_queen(board, row_i);
    }
  }
}

int main(int argc, char *argv[]) {
  struct chess_board *board;
	if (argc == 1) {
	  // Defaults to the 4-queens problem if no input is provided
    board = initialize_board(4);
	} else {
    board = initialize_board(atoi(argv[1]));
  }

  place_next_queen(board);  // Start solver algorithm
  print_counts(board);
  smash_board(board);  // Free dynamically allocated memory

  return EXIT_SUCCESS;
}
