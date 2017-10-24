package main

import "flag"
import "fmt"
// import "os"
// import "strconv"

// ChessBoard is an abstract representation of an NxN chess board that is used
// to tracking open positions
type ChessBoard struct {
	columns       []bool // Store available column moves/attacks
	diagonal_up   []bool // Store available diagonal moves/attacks
	diagonal_down []bool
	column_j      int    // Stores column to place the next queen in
	placements    uint64 // Tracks total number queen placements
	solutions     uint64 // Tracks number of solutions
}

// InitializeBoard creates an n_size by n_size ChessBoard struct pointer and
// sets initial values for the struct
func InitializeBoard(n_size int) *ChessBoard {
	diagonal_size := 2*n_size - 1
	board := &ChessBoard{
		columns:       make([]bool, n_size, n_size),
		diagonal_up:   make([]bool, diagonal_size, diagonal_size),
		diagonal_down: make([]bool, diagonal_size, diagonal_size),
		column_j:      0,
		placements:    0,
		solutions:     0,
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
	board.columns[row_i] = false
	board.diagonal_up[cap(board.columns)-1+board.column_j-row_i] = false
	board.diagonal_down[board.column_j+row_i] = false
	board.column_j++
	board.placements++
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
				board.solutions++
			} else {
				board.PlaceNextQueen()
			}
			board.RemoveQueen(row_i)
		}
	}
}

// Prints the number of queen placements and solutions for the NxN chess board
func (board *ChessBoard) OutputResult() {
	const template string = "The %d-Queens problem " +
		"required %d queen placements " +
		"to find all %d solutions"
	fmt.Printf(template, cap(board.columns), board.placements, board.solutions)
}

// Parses command-line input, if any, and calculates solutions and placements
// for an N-Queens problem. The result is printed to stdout.
func main() {
	var n_size int
	const n_size_label string = "The N-Queens problem to count solutions"
	flag.IntVar(&n_size, "N", 4, n_size_label)
	flag.Parse()
	if n_size > 0 {
		board := InitializeBoard(n_size)
		board.PlaceNextQueen()
		board.OutputResult()
	} else {
		fmt.Printf("Error: N must be a positive value for N-Queens problems")
	}
}
