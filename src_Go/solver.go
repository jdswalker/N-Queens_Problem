package main

import "fmt"

// solverBoard is an abstract representation of an NxN chess board that is used
// to tracking queen positions to output solutions
type solverBoard struct {
	chessboard       // An abstract chessboard for tracking open positions
	queens     []int // Store queen positions on the board
}

// initialize creates an nSize by nSize solverBoard struct pointer and
// sets initial values for the struct
func InitializeSolver(nSize int) *solverBoard {
	diagonalLength := 2*nSize - 1
	board := &solverBoard{
		chessboard: chessboard{
			columns:      make([]bool, nSize, nSize),
			diagonalUp:   make([]bool, diagonalLength, diagonalLength),
			diagonalDown: make([]bool, diagonalLength, diagonalLength),
			columnJ:      0,
		},
		queens: make([]int, nSize, nSize),
	}
	board.initialize()

	return board
}

// PlaceNextQueen performs a depth-first search of the chessboard to find all
// valid queen placements on the chessboard
func (board *solverBoard) PlaceNextQueen() {
	for rowI := 0; rowI < cap(board.columns); rowI++ {
		if board.squareIsFree(rowI) {
			board.queens[board.columnJ] = rowI + 1
			board.setQueen(rowI)
			if board.columnJ == cap(board.columns) {
				// Chess board is full
				for row := 0; row < cap(board.columns); row++ {
					fmt.Printf("%d ", board.queens[row])
				}
				fmt.Printf("\n")
			} else {
				board.PlaceNextQueen()
			}
			board.removeQueen(rowI)
		}
	}
}
