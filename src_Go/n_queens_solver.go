package main

import "fmt"
import "os"
import "strconv"

// ChessBoard is an abstract representation of an NxN chess board that is used
// to tracking open positions
type ChessBoard struct {
	queens        []int  // Store queen positions on the board
	columns       []bool // Store available column moves/attacks
	diagonal_up   []bool // Store available diagonal moves/attacks
	diagonal_down []bool
	column_j      int // Stores column to place the next queen in
}

// InitializeBoard creates an n_size by n_size ChessBoard struct pointer and
// sets initial values for the struct
func InitializeBoard(n_size int) *ChessBoard {
	diagonal_size := 2*n_size - 1
	board := &ChessBoard{
		queens:        make([]int, n_size, n_size),
		columns:       make([]bool, n_size, n_size),
		diagonal_up:   make([]bool, diagonal_size, diagonal_size),
		diagonal_down: make([]bool, diagonal_size, diagonal_size),
		column_j:      0,
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

// Checks if a queen can be placed in at row 'i' of the current column
func (board *ChessBoard) SquareIsFree(row_i int) bool {
	return board.columns[row_i] &&
		board.diagonal_up[cap(board.columns)-1+board.column_j-row_i] &&
		board.diagonal_down[board.column_j+row_i]
}

// Places a queen on the chess board at row 'i' of the current column
func (board *ChessBoard) SetQueen(row_i int) {
	board.queens[board.column_j] = row_i + 1
	board.columns[row_i] = false
	board.diagonal_up[cap(board.columns)-1+board.column_j-row_i] = false
	board.diagonal_down[board.column_j+row_i] = false
	board.column_j++
}

// Removes a queen from the NxN chess board in the given column to backtrack
func (board *ChessBoard) RemoveQueen(row_i int) {
	board.column_j--
	board.diagonal_down[board.column_j+row_i] = true
	board.diagonal_up[cap(board.columns)-1+board.column_j-row_i] = true
	board.columns[row_i] = true
}

// Recursive function for finding valid queen placements on the chess board
func (board *ChessBoard) PlaceNextQueen() {
	for row_i := 0; row_i < cap(board.columns); row_i++ {
		if board.SquareIsFree(row_i) {
			board.SetQueen(row_i)
			if board.column_j == cap(board.columns) {
				// Chess board is full
				for row := 0; row < cap(board.columns); row++ {
					fmt.Printf("%d ", board.queens[row])
				}
				fmt.Printf("\n")
			} else {
				board.PlaceNextQueen()
			}
			board.RemoveQueen(row_i)
		}
	}
}

// Parses command-line input, if any, and outputs solutions for an N-Queens
// problem to stdout.
func main() {
	var n_size int = 4
	if len(os.Args) != 1 {
		user_input, err := strconv.Atoi(os.Args[1])
		if err == nil {
			n_size = user_input
		}
	}
	board := InitializeBoard(n_size)
	board.PlaceNextQueen()
}
