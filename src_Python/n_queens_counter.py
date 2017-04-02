#!/usr/bin/env python

"""
N-Queens Placement and Solutions Counter
Author: James Walker
Copyrighted 2017 under the MIT license:
  http://www.opensource.org/licenses/mit-license.php

Purpose:
  The N-Queens Counter finds follows the same algorithm as the N-Queens
  Solver, except it does not return any of the solutions. Instead, the
  program counts the number of solutions for a given N-Queens problem as well
  as the number of times a queen is placed during the program's execution.
Example Usage:
  $ python ./nqueens_counter.py 12
  The 12-Queens problem required 856188 queen placements to find all 14200
  solutions

This implementation is based off the algorithm provided at the bottom of this
webpage: www.cs.utexas.edu/users/EWD/transcriptions/EWD03xx/EWD316.9.html
"""

# Imported Modules
from sys import argv


class ChessBoard(object):
    def __init__(self, number_of_queens):
        """Initializes starting values for the NxN chess board"""
        self.n_size = number_of_queens
        self.queen_positions = [0] * number_of_queens
        self.column_j = 0
        self.column = [True] * number_of_queens
        diagonal_attack_lines_on_board = (2 * number_of_queens) - 1
        self.diagonal_up = [True] * diagonal_attack_lines_on_board
        self.diagonal_down = [True] * diagonal_attack_lines_on_board
        self.queen_placements = 0
        self.n_queens_solutions = 0

    def index_of_diagonal_up_attack(self, row_i):
        """Calculates the index for an upward diagonal attack move for the
        given row in the current column"""
        return (self.n_size - 1 + self.column_j - row_i)

    def index_of_diagonal_down_attack(self, row_i):
        """Calculates the index for an downward diagonal attack move for the
        given row in the current column"""
        return (self.column_j + row_i)

    def square_is_free(self, row_i):
        """Check if a queen can be placed on the chess board at the given row
        in the current column"""
        return (self.column[row_i] and
                self.diagonal_up[self.index_of_diagonal_up_attack(row_i)] and
                self.diagonal_down[self.index_of_diagonal_down_attack(row_i)])

    def set_queen(self, row_i):
        """Recursive function for finding valid queen placements on the chess
        board. When the NxN board has N queens placed on it, the solutions
        counter is incremented."""
        self.queen_positions[self.column_j] = row_i
        self.column[row_i] = False
        self.diagonal_up[self.index_of_diagonal_up_attack(row_i)] = False
        self.diagonal_down[self.index_of_diagonal_down_attack(row_i)] = False
        self.column_j += 1
        self.queen_placements += 1

    def remove_queen(self, row_i):
        """Removes a queen from the chess board at the given row in the
        current column"""
        self.column_j -= 1
        self.column[row_i] = True
        self.diagonal_up[self.index_of_diagonal_up_attack(row_i)] = True
        self.diagonal_down[self.index_of_diagonal_down_attack(row_i)] = True

    def place_next_queen(self):
        """Recursive function for finding valid queen placements on the chess
        board. When the NxN board has N queens placed on it, the solutions
        counter is incremented."""
        for row_i in range(0, self.n_size):
            if self.square_is_free(row_i):
                self.set_queen(row_i)
                if self.column_j == self.n_size:
                    self.n_queens_solutions += 1
                else:
                    self.place_next_queen()
                self.remove_queen(row_i)

    def output_count_of_n_queens_solutions(self):
        """Starts the N-Queens solution finding algorithm and prints the final
        result"""
        self.place_next_queen()
        result_string = "The %d-Queens problem required %d queen placements " \
                        "to find all %d solutions"
        print (result_string) % (self.n_size, self.queen_placements,
                                 self.n_queens_solutions)


def main(argv):
    """Parses the command-line for an N-Queens value. If an invalid number is
    provided, the program defaults to the 4-Queens problem. The chess board is
    initialized and the N-Queens solver algorithm is executed. A string is
    printed to the command-line with the counts for the number of queen
    placements and N-Queens solutions"""
    number_of_queens = 4
    if len(argv) != 0 and int(argv[0]) > 0:
        number_of_queens = int(argv[0])
    ChessBoard(number_of_queens).output_count_of_n_queens_solutions()


if __name__ == '__main__':
    main(argv[1:])
