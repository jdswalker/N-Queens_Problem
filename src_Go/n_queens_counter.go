package main

import "fmt"

// counterBoard is an abstract representation of an NxN chess board that is used
// to tracking open positions
type counterBoard struct {
	columns       []bool // Store available column moves/attacks
	diagonalUp   []bool // Store available diagonal moves/attacks
	diagonalDown []bool
	columnJ      int    // Stores column to place the next queen in
	placements    uint64 // Tracks total number queen placements
	solutions     uint64 // Tracks number of solutions
}

// InitializeCounter creates an nSize by nSize counterBoard struct pointer and
// sets initial values for the struct
func InitializeCounter(nSize int) *counterBoard {
	diagonalLength := 2*nSize - 1
	board := &counterBoard{
		columns:       make([]bool, nSize, nSize),
		diagonalUp:   make([]bool, diagonalLength, diagonalLength),
		diagonalDown: make([]bool, diagonalLength, diagonalLength),
		columnJ:      0,
		placements:    0,
		solutions:     0,
	}
	for i := 0; i < nSize; i++ {
		board.columns[i] = true
	}
	for i := 0; i < (2*nSize - 1); i++ {
		board.diagonalUp[i] = true
	}
	copy(board.diagonalDown, board.diagonalUp)

	return board
}

// Checks if a queen can be placed in at row 'i' of the current column
func (board *counterBoard) squareIsFree(rowI int) bool {
	return board.columns[rowI] &&
		board.diagonalUp[cap(board.columns)-1+board.columnJ-rowI] &&
		board.diagonalDown[board.columnJ+rowI]
}

// Places a queen on the chess board at row 'i' of the current column
func (board *counterBoard) setQueen(rowI int) {
	board.columns[rowI] = false
	board.diagonalUp[cap(board.columns)-1+board.columnJ-rowI] = false
	board.diagonalDown[board.columnJ+rowI] = false
	board.columnJ++
	board.placements++
}

// Removes a queen from the NxN chess board in the given column to backtrack
func (board *counterBoard) removeQueen(rowI int) {
	board.columnJ--
	board.diagonalDown[board.columnJ+rowI] = true
	board.diagonalUp[cap(board.columns)-1+board.columnJ-rowI] = true
	board.columns[rowI] = true
}

// Recursive function for finding valid queen placements on the chess board
func (board *counterBoard) PlaceNextQueen() {
	for rowI := 0; rowI < cap(board.columns); rowI++ {
		if board.squareIsFree(rowI) {
			board.setQueen(rowI)
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
