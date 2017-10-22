package main

import "fmt"
import "os"
import "strconv"

type ChessBoard struct {
	columns []bool        // Store available column moves/attacks
	diagonal_up []bool    // Store available diagonal moves/attacks
	diagonal_down []bool
	column_j int          // Stores column to place the next queen in
	placements uint64     // Tracks total number queen placements
	solutions uint64      // Tracks number of solutions
}

func initialize_board(n_size int) *ChessBoard {
	diagonal_size := 2*n_size - 1
	board := &ChessBoard{
		columns: make([]bool, n_size, n_size),
		diagonal_up: make([]bool, diagonal_size, diagonal_size),
		diagonal_down: make([]bool, diagonal_size, diagonal_size),
		column_j: 0,
		placements: 0,
		solutions: 0,
	}
	for i := 0; i < n_size; i++ {
		board.columns[i] = true
	}
	for i := 0; i < (2*n_size - 1); i++ {
		board.diagonal_up[i] = true
	}
	copy(board.diagonal_down, board.diagonal_up)

	return board
}

func place_next_queen(board *ChessBoard) {
	for row_i := 0; row_i < len(board.columns); row_i++ {
		if board.columns[row_i] && board.diagonal_up[len(board.columns)-1+board.column_j-row_i] && board.diagonal_down[board.column_j+row_i] {
			board.columns[row_i] = false
			board.diagonal_up[len(board.columns)-1+board.column_j-row_i] = false
			board.diagonal_down[board.column_j+row_i] = false
			board.column_j++
			board.placements++

			if board.column_j == len(board.columns) {
				// Chess board is full
				board.solutions++
			} else {
				// Recursive call to find next queen placement on the chess board
				place_next_queen(board)
			}
			// Removes a queen from the chess board in the given column to backtrack
			board.column_j--
			board.diagonal_down[board.column_j+row_i] = true
			board.diagonal_up[len(board.columns)-1+board.column_j-row_i] = true
			board.columns[row_i] = true
		}
	}
}

func main() {
	var n_size int = 4
	if len(os.Args) != 1 {
		user_input, err := strconv.Atoi(os.Args[1])
		if err == nil {
			n_size = user_input
		}
	}
	board := initialize_board(n_size)
	place_next_queen(board)
	const template string = "The %d-Queens problem required %d queen placements to find all %d solutions"
	fmt.Printf(template, n_size, board.placements, board.solutions)
}
