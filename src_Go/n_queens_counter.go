package main

import "fmt"
import "os"
import "strconv"

func place_next_queen(columns []bool, diagonal_up []bool, diagonal_down []bool, column_j int, placements *int, solutions *int) {
	for row_i := 0; row_i < len(columns); row_i++ {
		if columns[row_i] && diagonal_up[len(columns)-1+column_j-row_i] && diagonal_down[column_j+row_i] {
			columns[row_i] = false
			diagonal_up[len(columns)-1+column_j-row_i] = false
			diagonal_down[column_j+row_i] = false
			column_j++
			*placements++

			if column_j == len(columns) {
				// Chess board is full
				*solutions++
			} else {
				// Recursive call to find next queen placement on the chess board
				place_next_queen(columns, diagonal_up, diagonal_down, column_j, placements, solutions)
			}
			// Removes a queen from the chess board in the given column to backtrack
			column_j--
			diagonal_down[column_j+row_i] = true
			diagonal_up[len(columns)-1+column_j-row_i] = true
			columns[row_i] = true
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

	diagonal_size := 2*n_size + 1
    // Attacks along a column
	columns := make([]bool, n_size, n_size)
    // Attacks along diagonals
	diagonal_up := make([]bool, diagonal_size, diagonal_size)
	diagonal_down := make([]bool, diagonal_size, diagonal_size)
	column_j := 0
	placements := 0
	solutions := 0

	for i := 0; i < n_size; i++ {
		columns[i] = true
	}
	for i := 0; i < (2*n_size + 1); i++ {
		diagonal_up[i] = true
	}
	copy(diagonal_down, diagonal_up)

	place_next_queen(columns, diagonal_up, diagonal_down, column_j, &placements, &solutions)
	const template string = "The %d-Queens problem required %d queen placements to find all %d solutions"
	fmt.Printf(template, n_size, placements, solutions)
}
