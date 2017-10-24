package main

// Go Standard Library Imports
import "flag"
import "fmt"

//
type chessboard interface {
	squareIsFree(rowI int) bool
	setQueen(rowI int)
	removeQueen(rowI int)
	PlaceNextQueen()
}

// Parses command-line input, if any, and calculates solutions and placements
// for an N-Queens problem. The result is printed to stdout.
func main() {
	var nSize int
	flag.IntVar(&nSize, "N", 4, "The N-Queens problem to count solutions")
	var nQueensType string
	flag.StringVar(&nQueensType, "type", "counter", "Options: counter, solver")
	flag.Parse()
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
