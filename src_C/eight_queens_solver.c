// 8-Queens Solver
// Author: James Walker
// Copyrighted 2017 under the MIT license:
//   http://www.opensource.org/licenses/mit-license.php
//
// Purpose: 
//   The 8-Queens Solver finds solutions for the 8-Queens problem. That
//   is, how many ways are there to place 8 chess queens on an regular 8 x 8
//   chess board such that none of the queens can attack each other.
// Compilation, Execution and Partial Output:
//   $ gcc eight_queens_solver.c -o eight_queens_solver
//   $ ./eight_queens_solver.exe
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

// Recursive function for finding valid queen placements on the chess board
void place_next_queen(int queens[8], int col_index, int column[8],
                      int diagonal_up[15], int diagonal_down[15]) {
  for (int row_index = 0; row_index < 8; ++row_index) {
    // Check if a queen can be placed on the current square
    if (column[row_index] &
        diagonal_up[7 + col_index - row_index] &
        diagonal_down[col_index + row_index]) {

      // Place a queen on the chess board
      queens[col_index] = row_index;
      column[row_index] = 0;
      diagonal_up[7 + col_index - row_index] = 0;
      diagonal_down[col_index + row_index] = 0;
      ++col_index;

      if (col_index == 8) {
        // Chess board is full
        for (int row = 0; row < 8; ++row) {
          printf("%d ", queens[row] + 1);
        }
        printf("\n");
      } else {
        // Recursive call to find next queen placement on the chess board
        place_next_queen(queens, col_index, column, diagonal_up, diagonal_down);
        // Removes a queen from the chess board in the given column to backtrack
      }
      --col_index;
      diagonal_down[col_index + row_index] = 1;
      diagonal_up[7 + col_index - row_index] = 1;
      column[row_index] = 1;
    }
  
}

int main() {
  // Parameters for solver
  int queens[8] = {0};
  int col_index = 0;
  int column[8];
  int diagonal_up[15];
  int diagonal_down[15];
  
  // Initialize chess board
  for(int index = 0; index < 8; ++index) {
    column[index] = 1;
    diagonal_up[index] = 1;
    diagonal_down[index] = 1;
  }
  
  for(int index = 8; index < 15; ++index) {
    diagonal_up[index] = 1;
    diagonal_down[index] = 1;
  }

  // Start solver algorithm
  place_next_queen(queens, col_index, column, diagonal_up, diagonal_down);

  return 0;
}
