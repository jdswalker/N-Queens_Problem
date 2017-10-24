package main

import "fmt"

// solverBoard is an abstract representation of an NxN chess board that is used
// to tracking open positions
type solverBoard struct {
	queens       []int  // Store queen positions on the board
	columns      []bool // Store available column moves/attacks
	diagonalUp   []bool // Store available diagonal moves/attacks
	diagonalDown []bool
	columnJ      int // Stores column to place the next queen in
}

// InitializeBoard creates an nSize by nSize solverBoard struct pointer and
// sets initial values for the struct
func InitializeSolver(nSize int) *solverBoard {
	diagonalLength := 2*nSize - 1
	board := &solverBoard{
		queens:       make([]int, nSize, nSize),
		columns:      make([]bool, nSize, nSize),
		diagonalUp:   make([]bool, diagonalLength, diagonalLength),
		diagonalDown: make([]bool, diagonalLength, diagonalLength),
		columnJ:      0,
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
func (board *solverBoard) squareIsFree(rowI int) bool {
	return board.columns[rowI] &&
		board.diagonalUp[cap(board.columns)-1+board.columnJ-rowI] &&
		board.diagonalDown[board.columnJ+rowI]
}

// Places a queen on the chess board at row 'i' of the current column
func (board *solverBoard) setQueen(rowI int) {
	board.queens[board.columnJ] = rowI + 1
	board.columns[rowI] = false
	board.diagonalUp[cap(board.columns)-1+board.columnJ-rowI] = false
	board.diagonalDown[board.columnJ+rowI] = false
	board.columnJ++
}

// Removes a queen from the NxN chess board in the given column to backtrack
func (board *solverBoard) removeQueen(rowI int) {
	board.columnJ--
	board.diagonalDown[board.columnJ+rowI] = true
	board.diagonalUp[cap(board.columns)-1+board.columnJ-rowI] = true
	board.columns[rowI] = true
}

// Recursive function for finding valid queen placements on the chess board
func (board *solverBoard) PlaceNextQueen() {
	for rowI := 0; rowI < cap(board.columns); rowI++ {
		if board.squareIsFree(rowI) {
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

// Parses command-line input, if any, and outputs solutions for an N-Queens
// problem to stdout.
// func main() {
// var nSize int = 4
// if len(os.Args) != 1 {
// user_input, err := strconv.Atoi(os.Args[1])
// if err == nil {
// nSize = user_input
// }
// }
// board := InitializeSolver(nSize)
// board.PlaceNextQueen()
// }
