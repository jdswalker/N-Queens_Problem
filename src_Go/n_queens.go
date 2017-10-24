package main

// Go Standard Library Imports
import "flag"
import "fmt"

// A common set of commands called by the counter and solver
type chessboardMoves interface {
	initialize(nSize int)
	squareIsFree(rowI int) bool
	setQueen(rowI int)
	removeQueen(rowI int)
	PlaceNextQueen()
}

// chessboard is an abstract representation of an NxN chess board that is used
// to track open positions for placing the next queen
type chessboard struct {
	columns      []bool // Store available column moves/attacks
	diagonalUp   []bool // Store available upward diagonal moves/attacks
	diagonalDown []bool // Store available downward diagonal moves/attacks
	columnJ      int    // Stores column to place the next queen in
}

// initialize sets the position tracking arrays to indicate all spots are
// available for a queen to be placed
func (board *chessboard) initialize() {
	for i := 0; i < cap(board.columns); i++ {
		board.columns[i] = true
	}
	for i := 0; i < cap(board.diagonalUp); i++ {
		board.diagonalUp[i] = true
	}
	copy(board.diagonalDown, board.diagonalUp)
}

// Checks if a queen can be placed in at row 'i' of the current column
func (board *chessboard) squareIsFree(rowI int) bool {
	return board.columns[rowI] &&
		board.diagonalUp[cap(board.columns)-1+board.columnJ-rowI] &&
		board.diagonalDown[board.columnJ+rowI]
}

// Places a queen on the chess board at row 'i' of the current column
func (board *chessboard) setQueen(rowI int) {
	board.columns[rowI] = false
	board.diagonalUp[cap(board.columns)-1+board.columnJ-rowI] = false
	board.diagonalDown[board.columnJ+rowI] = false
	board.columnJ++
}

// Removes a queen from the NxN chess board in the given column to backtrack
func (board *chessboard) removeQueen(rowI int) {
	board.columnJ--
	board.diagonalDown[board.columnJ+rowI] = true
	board.diagonalUp[cap(board.columns)-1+board.columnJ-rowI] = true
	board.columns[rowI] = true
}

// Handles defining command-line flags and returning their values or defaults
func getCmdLineArgs() (int, string) {
	var nSize int
	flag.IntVar(&nSize, "N", 4, "The N-Queens problem to count solutions")
	var nQueensType string
	flag.StringVar(&nQueensType, "type", "counter", "Options: counter, solver")
	flag.Parse()
	return nSize, nQueensType
}

// Parses command-line input, if any, and calculates solutions and placements
// for an N-Queens problem. The result is printed to stdout.
func main() {
	nSize, nQueensType := getCmdLineArgs()
	if nSize <= 0 {
		fmt.Printf("Error: N must be a positive value for N-Queens problems")
	} else if nQueensType == "solver" {
		board := InitializeSolver(nSize)
		board.PlaceNextQueen()
	} else {
		board := InitializeCounter(nSize)
		board.PlaceNextQueen()
		board.OutputResult()
	}
}
