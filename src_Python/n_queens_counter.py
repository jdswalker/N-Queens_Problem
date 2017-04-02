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


class NQueensCounter(object):
    def __init__(self):
        """Initializes counters for tracking the number of times a queen is
        placed on the chess board and the number of N-Queens solutions"""
        self.queen_placements = 0
        self.n_queens_solutions = 0

    def update_placements(self):
        """Increments the counter for the number of queens that have been
        placed on the board"""
        self.queen_placements += 1

    def update_solution_count(self):
        """Increments the counter for the number of N-Queens solutions found"""
        self.n_queens_solutions += 1


def initialize_board(number_of_queens):
    """Initializes starting values for the NxN chess board"""
    queen_positions = [0] * number_of_queens
    column_j = 0
    column = [True] * number_of_queens
    diagonal_up = [True] * ((2 * number_of_queens) - 1)
    diagonal_down = [True] * ((2 * number_of_queens) - 1)
    chess_board = [
        queen_positions,
        column_j, column,
        diagonal_up,
        diagonal_down
    ]
    return (chess_board)


def square_is_free(chess_board, number_of_queens, row_i):
    """Check if a queen can be placed on the current square"""
    diagonal_up_index = number_of_queens - 1 + chess_board[1] - row_i
    diagonal_down_index = chess_board[1] + row_i
    return (chess_board[2][row_i] and chess_board[3][diagonal_up_index] and
            chess_board[4][diagonal_down_index])


def set_queen(chess_board, number_of_queens, row_i, counter):
    """Places a queen on the chess board in the given row"""
    diagonal_up_index = number_of_queens - 1 + chess_board[1] - row_i
    diagonal_down_index = chess_board[1] + row_i
    chess_board[0][chess_board[1]] = row_i + 1
    chess_board[2][row_i] = False
    chess_board[3][diagonal_up_index] = False
    chess_board[4][diagonal_down_index] = False
    chess_board[1] += 1
    counter.update_placements()
    return (chess_board)


def remove_queen(chess_board, number_of_queens, row_i):
    """Removes a queen from the chess board in the current column"""
    chess_board[1] -= 1
    chess_board[2][row_i] = True
    chess_board[3][number_of_queens - 1 + chess_board[1] - row_i] = True
    chess_board[4][chess_board[1] + row_i] = True
    return (chess_board)


def place_next_queen(chess_board, number_of_queens, counter):
    """Recursive function for finding valid queen placements on the chess
    board"""
    for row_i in range(0, number_of_queens):
        if (square_is_free(chess_board, number_of_queens, row_i)):
            chess_board = set_queen(chess_board, number_of_queens, row_i,
                                    counter)
            if (chess_board[1] == number_of_queens):
                counter.update_solution_count()
            else:
                place_next_queen(chess_board, number_of_queens, counter)
            chess_board = remove_queen(chess_board, number_of_queens, row_i)


def main(argv):
    """Parses the command-line for an N-Queens value. If an invalid number is
    provided, the program defaults to the 4-Queens problem. The chess board is
    initialized and the N-Queens solver algorithm is executed. A string is
    printed to the command-line with the counts for the number of queen
    placements and N-Queens solutions"""
    number_of_queens = 4
    if len(argv) != 0 and int(argv[0]) > 0:
        number_of_queens = int(argv[0])
    counter = NQueensCounter()
    chess_board = initialize_board(number_of_queens)
    place_next_queen(chess_board, number_of_queens, counter)
    result_string = "The %d-Queens problem required %d queen placements to " \
                    "find all %d solutions"
    print (result_string) % (number_of_queens, counter.queen_placements,
                             counter.n_queens_solutions)


if __name__ == '__main__':
    main(argv[1:])
