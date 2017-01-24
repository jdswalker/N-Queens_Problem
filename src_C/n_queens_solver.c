// n-Queens Solver
// Author: James Walker
// Copyrighted 2017 under the MIT license:
//   http://www.opensource.org/licenses/mit-license.php
//
// Purpose: 
//   The n-Queens Solver finds solutions for the n-Queens problem. That is, how
//   many ways are there to place n chess queens on an n x n chess board such
//   that none of the queens can attack each other.
// Compilation, Execution and Partial Output:
//   $ gcc -std=c99 n_queens_solver.c -o n_queens_solver
//   $ ./n_queens_solver.exe 8
//   1 5 8 6 3 7 2 4
//   1 6 8 3 7 4 2 5
//   ...
//   8 3 1 6 2 5 7 4
//   8 4 1 3 6 2 7 5
//
// This implementation is based off the algorithm provided at the bottom of this
// webpage: www.cs.utexas.edu/users/EWD/transcriptions/EWD03xx/EWD316.9.html

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct chess_board {
  // Chess board variables
  int n_size;       // Number of queens on the n x n chess board
  int *queens;        // Store queen positions on the board
  int *column;        // Store available column moves/attacks
  int *diagonal_up;   // Store available diagonal moves/attacks
  int *diagonal_down;
  int col_i;          // Store current column to examine on the board
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
  board->col_i = 0;
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

void smash_board(struct chess_board *board) {
  free(board->queens);
  free(board->column);
  free(board->diagonal_up);
  free(board->diagonal_down);
  free(board);
}

// Check if a queen can be placed in column 'i', at row 'j'
int square_is_free(const struct chess_board *board, const int row_j) {
  return board->column[row_j] &
         board->diagonal_up[(board->n_size - 1) + (board->col_i - row_j)] &
         board->diagonal_down[(board->col_i + row_j)];
}

// Place a queen on the chess board
void set_queen(struct chess_board *board, const int row_j) {
  board->queens[board->col_i] = row_j;
  board->column[row_j] = 0;
  board->diagonal_up[(board->n_size - 1) + (board->col_i - row_j)] = 0;
  board->diagonal_down[(board->col_i + row_j)] = 0;
  board->col_i += 1;
}

void remove_queen(struct chess_board *board, const int row_j) {
  board->col_i -= 1;
  board->diagonal_down[(board->col_i + row_j)] = 1;
  board->diagonal_up[(board->n_size - 1) + (board->col_i - row_j)] = 1;
  board->column[row_j] = 1;
}

void print_solution(const struct chess_board *board) {
  for (int col = 0; col < board->n_size; ++col) {
    fprintf(stdout, "%d ", board->queens[col] + 1);
  }
  fputc('\n', stdout);
}

void place_next_queen(struct chess_board *board) {
  for (int row_j = 0; row_j < board->n_size; ++row_j) {
    if (square_is_free(board, row_j)) {
      set_queen(board, row_j);
      if (board->col_i == board->n_size) {
        // Chess board is full
        print_solution(board);
      } else {
        // Recursive call to find next queen placement on the chess board
        place_next_queen(board);
      }
      // Removes the queen from the chess board at column 'i', at row 'j' to
      // backtrack for the next loop
      remove_queen(board, row_j);
    }
  }
}

int main(int argc, char *argv[]) {
  struct chess_board *board;
	if (argc == 1) {
	  // Defaults to the 4-queens problem if no input is provided
    board = initialize_board(4L);
	} else {
    board = initialize_board(atoi(argv[1]));
  }
  // Start solver algorithm
  place_next_queen(board);
  // Free dynamically allocated memory
  smash_board(board);
  return EXIT_SUCCESS;
}
