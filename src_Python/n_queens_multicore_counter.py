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
  $ python ./n_queens_multicore_counter.py 12
  The 12-Queens problem required 428094 queen placements to find all 14200
  solutions

This implementation is based off the algorithm provided at the bottom of this
webpage: www.cs.utexas.edu/users/EWD/transcriptions/EWD03xx/EWD316.9.html
"""

# Imported Modules
from sys import argv
from multiprocessing import Pool


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
        """Places a queen on the chess board at the given row in the current
        column. Each time a queen is placed, the counter for queen placements
        is incremented"""
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

    def middle_row_contains_first_queen_placement(self):
        """Returns whether the chess board has an odd number of rows and, if
        so, whether the first queen that was placed is in the middle row"""
        queen_in_middle_row = False
        chess_board_has_odd_number_of_rows = bool(self.n_size & 1)
        if chess_board_has_odd_number_of_rows:
            middle_row_index = self.n_size >> 1
            queen_in_middle_row = self.queen_positions[0] == middle_row_index
        return (queen_in_middle_row)


def initialize_chess_boards(chess_board_size):
    """A list of chess boards is created with the first queen already placed.
    For a given chess board size, N, the returned list will be of size N/2
    (which is rounded up if N is an odd number)."""
    chess_board_list = []
    middle_of_chess_board = (chess_board_size >> 1) + (chess_board_size & 1)
    for row_i in range(0, middle_of_chess_board):
        chess_board = ChessBoard(chess_board_size)
        chess_board.set_queen(row_i)
        chess_board_list.append(chess_board)
    return (chess_board_list)


def get_partial_counts_for_n_queens_solutions(chess_board):
    """Counts all of the valid N-queens solutions on a chess board when the
    placement of the first queen is fixed (i.e., starting from a given row in
    the first column)"""
    chess_board.place_next_queen()
    partial_queen_placements = chess_board.queen_placements
    partial_n_queens_solutions = chess_board.n_queens_solutions
    if not chess_board.middle_row_contains_first_queen_placement():
        partial_n_queens_solutions += chess_board.n_queens_solutions
    return (partial_queen_placements, partial_n_queens_solutions)


def get_counts_for_n_queens_solutions(number_of_queens):
    """Calculates the number of queens that are placed on the chessboard while
    finding all of the valid solutions for a given number of queens. The number
    of queen placements and solutions is then returned."""
    chess_board_list = initialize_chess_boards(number_of_queens)
    process_pool = Pool()
    list_of_counts = process_pool.map(
        get_partial_counts_for_n_queens_solutions, chess_board_list
    )
    process_pool.close()
    process_pool.join()
    total_queen_placements = sum(first for first, __ in list_of_counts)
    total_n_queens_solutions = sum(second for __, second in list_of_counts)
    if number_of_queens == 1:
      total_n_queens_solutions = 1
    return (total_queen_placements, total_n_queens_solutions)


def main(argv):
    """Parses the command-line for an N-Queens value. If an invalid number is
    provided, the program defaults to the 4-Queens problem. The chess board is
    initialized and the N-Queens solver algorithm is executed. A string is
    printed to the command-line with the counts for the number of queen
    placements and N-Queens solutions"""
    number_of_queens = 4
    if len(argv) != 0 and int(argv[0]) > 0:
        number_of_queens = int(argv[0])
    queen_placements, n_queens_solutions = \
        get_counts_for_n_queens_solutions(number_of_queens)
    result_string = "\nThe %d-Queens problem required %d queen placements " \
                    "to find all %d solutions"
    print (result_string) % (number_of_queens, queen_placements,
                             n_queens_solutions)


if __name__ == '__main__':
    main(argv[1:])
