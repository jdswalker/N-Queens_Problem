// 8-Queens Solver
// Author: James Walker
// Copyrighted 2017 under the MIT license:
//   http://www.opensource.org/licenses/mit-license.php
// Compilation: gcc eight_queens_solver.c -o eight_queens_solver
//
// Based off the algorithm provided at the bottom of this webpage:
//   https://www.cs.utexas.edu/users/EWD/transcriptions/EWD03xx/EWD316.9.html

#include <stdio.h>
#include <stdlib.h>

// Recursive function for finding valid queen placements on the chess board
void place_next_queen(int queens[8], int row_index, int column[8],
                      int diagonal_up[15], int diagonal_down[15]) {
  
  for (int col_index = 0; col_index < 8; ++col_index) {
    
    // Check if a queen can be placed on the current square
    if (column[col_index] && diagonal_up[7 + row_index - col_index] &&
        diagonal_down[row_index + col_index]) {

      // Place a queen on the chess board
      queens[row_index] = col_index;
      column[col_index] = 0;
      diagonal_up[7 + row_index - col_index] = 0;
      diagonal_down[row_index + col_index] = 0;
      ++row_index;

      if (row_index == 8) {
        // Chess board is full
        for (int row = 0; row < 8; ++row) {
          printf("%d ", queens[row]);
        }
        printf("\n");
      } else {
        // Recursive call to find next queen placement on the chess board
        place_next_queen(queens, row_index, column, diagonal_up, diagonal_down);
      }

      // Removes a queen from the chess board in the given column to backtrack
      --row_index;
      diagonal_down[row_index + col_index] = 1;
      diagonal_up[7 + row_index - col_index] = 1;
      column[col_index] = 1;
    }
  }
}

int main() {
  // Parameters for solver
  int queens[8] = {0};
  int row_index = 0;
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
  place_next_queen(queens, row_index, column, diagonal_up, diagonal_down);

  return 0;
}
