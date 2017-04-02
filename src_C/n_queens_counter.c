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
  int n_size;             // Number of queens on the n x n chess board
  int *queen_positions;   // Store queen positions on the board
  int *column;            // Store available column moves/attacks
  int *diagonal_up;       // Store available diagonal moves/attacks
  int *diagonal_down;
  int column_j;           // Store current column to examine on the board
  uint64_t placements;    // Tracks total number queen placements
  int solutions;          // Tracks number of solutions
};

void allocation_error(const int error_code) {
  switch (error_code) {
    case 0:
      fprintf(stderr, "The number of queens must be greater than 0.\n");
    case 1:
      fprintf(stderr, "Failed to allocate memory for chess board.\n");
      break;
    case 2:
      fprintf(stderr, "Failed to allocate memory for chess queens.\n");
      break;
    case 3:
      fprintf(stderr, "Failed to allocate memory for column attacks.\n");
      break;
    case 4:
      fprintf(stderr, "Failed to allocate memory for diagonal up attacks.\n");
      break;
    case 5:
      fprintf(stderr, "Failed to allocate memory for diagonal down attacks.\n");
      break;
  }
  exit(EXIT_FAILURE);
}

struct chess_board *initialize_board(const int n_queens) {
  if (n_queens < 1) {
    allocation_error(0);
  }
  // Dynamically allocate memory for chessboard
  struct chess_board *board = malloc(sizeof(struct chess_board));
  if (board == NULL) {
    allocation_error(1);
  }
  // Dynamically allocate memory for chessboard variables
  board->queens = (int *)malloc(sizeof(int) * n_queens);
  if(board->queens == NULL) {
    allocation_error(2);
  }
  board->column = (int *)malloc(sizeof(int) * n_queens);
  if(board->column == NULL) {
    allocation_error(3);
  }
  board->diagonal_up = (int *)malloc(sizeof(int) * (2*n_queens - 1));
  if(board->diagonal_up == NULL) {
    allocation_error(4);
  }
  board->diagonal_down = (int *)malloc(sizeof(int) * (2*n_queens - 1));
  if(board->diagonal_down == NULL) {
    allocation_error(5);
  }
  // Initialize the chess board variables
  board->n_size = n_queens;
  board->column_j = 0;
  board->placements = 0;
  board->solutions = 0;
  for(int i = 0; i < n_queens; ++i) {
    board->queens[i] = 0;
    board->column[i] = 1;
    board->diagonal_up[i] = 1;
    board->diagonal_down[i] = 1;
  }
  // Initialize remaining array indices
  for(int i = n_queens; i < (2*n_queens - 1); ++i) {
    board->diagonal_up[i] = 1;
    board->diagonal_down[i] = 1;
  }
  return board;
}

// Frees the dynamically allocated memory for the chess board structure
void smash_board(struct chess_board *board) {
  free(board->queens);
  free(board->column);
  free(board->diagonal_up);
  free(board->diagonal_down);
  free(board);
}

// Check if a queen can be placed in column 'i', at row 'j'
int square_is_free(const struct chess_board *board, const int row_i) {
  return board->column[row_i] &
         board->diagonal_up[(board->n_size - 1) + (board->column_j - row_i)] &
         board->diagonal_down[(board->column_j + row_i)];
}

// Place a queen on the chess board
void set_queen(struct chess_board *board, const int row_i) {
  board->queens[board->column_j] = row_i;
  board->column[row_i] = 0;
  board->diagonal_up[(board->n_size - 1) + (board->column_j - row_i)] = 0;
  board->diagonal_down[(board->column_j + row_i)] = 0;
  ++board->column_j;
  ++board->placements;
}

// Removes a queen from the n x n chess board in the given column to backtrack
void remove_queen(struct chess_board *board, const int row_i) {
  --board->column_j;
  board->diagonal_down[(board->column_j + row_i)] = 1;
  board->diagonal_up[(board->n_size - 1) + (board->column_j - row_i)] = 1;
  board->column[row_i] = 1;
}

// Prints the number of queen placements and solutions for the n x n chess board
void print_counts(const struct chess_board *board) {
  fprintf(stdout, "The %d-Queens problem "
                  "required %"PRIu64" queen placements "
                  "to find all %d solutions\n",
                  board->n_size, board->placements, board->solutions);
}

// Recursive function for finding valid queen placements on the chess board
void place_next_queen(struct chess_board *board) {
  for (int row_i = 0; row_i < board->n_size; ++row_i) {
    if (square_is_free(board, row_i)) {
      set_queen(board, row_i);
      if (board->column_j == board->n_size) {
        // Chess board has n x n queens set
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
  // Start solver algorithm
  place_next_queen(board);
  print_counts(board);
  // Free dynamically allocated memory
  smash_board(board);
  return EXIT_SUCCESS;
}
