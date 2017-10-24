package main

import "fmt"

// counterBoard is an abstract representation of an NxN chess board that is
// used to tracking the number of queens placed on the board and the number of
// solutions for the given N-Queens problem
type counterBoard struct {
	chessboard        // An abstract chessboard for tracking open positions
	placements uint64 // Tracks total number queen placements
	solutions  uint64 // Tracks number of solutions
}

// InitializeCounter creates an nSize by nSize counterBoard struct pointer and
// sets initial values for the struct
func InitializeCounter(nSize int) *counterBoard {
	diagonalLength := 2*nSize - 1
	board := &counterBoard{
		chessboard: chessboard{
			columns:      make([]bool, nSize, nSize),
			diagonalUp:   make([]bool, diagonalLength, diagonalLength),
			diagonalDown: make([]bool, diagonalLength, diagonalLength),
			columnJ:      0,
		},
		placements: 0,
		solutions:  0,
	}
	board.initialize()

	return board
}

// PlaceNextQueen performs a depth-first search of the chessboard to find all
// valid queen placements on the chessboard
func (board *counterBoard) PlaceNextQueen() {
	for rowI := 0; rowI < cap(board.columns); rowI++ {
		if board.squareIsFree(rowI) {
			board.setQueen(rowI)
			board.placements++
			if board.columnJ == cap(board.columns) {
				board.solutions++
			} else {
				board.PlaceNextQueen()
			}
			board.removeQueen(rowI)
		}
	}
}

// Prints the number of queen placements and solutions for the NxN chess board
func (board *counterBoard) OutputResult() {
	const template string = "The %d-Queens problem " +
		"required %d queen placements " +
		"to find all %d solutions"
	fmt.Printf(template, cap(board.columns), board.placements, board.solutions)
}
