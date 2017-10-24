package main

import "testing"

func BenchmarkPlaceNextQueen04(b *testing.B) {
	const n_size int = 4
	board := InitializeBoard(n_size)
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		board.PlaceNextQueen()
	}
}

func BenchmarkPlaceNextQueen05(b *testing.B) {
	const n_size int = 5
	board := InitializeBoard(n_size)
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		board.PlaceNextQueen()
	}
}

func BenchmarkPlaceNextQueen06(b *testing.B) {
	const n_size int = 6
	board := InitializeBoard(n_size)
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		board.PlaceNextQueen()
	}
}

func BenchmarkPlaceNextQueen07(b *testing.B) {
	const n_size int = 7
	board := InitializeBoard(n_size)
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		board.PlaceNextQueen()
	}
}

func BenchmarkPlaceNextQueen08(b *testing.B) {
	const n_size int = 8
	board := InitializeBoard(n_size)
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		board.PlaceNextQueen()
	}
}

func BenchmarkPlaceNextQueen09(b *testing.B) {
	const n_size int = 9
	board := InitializeBoard(n_size)
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		board.PlaceNextQueen()
	}
}

func BenchmarkPlaceNextQueen10(b *testing.B) {
	const n_size int = 10
	board := InitializeBoard(n_size)
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		board.PlaceNextQueen()
	}
}

func BenchmarkPlaceNextQueen11(b *testing.B) {
	const n_size int = 11
	board := InitializeBoard(n_size)
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		board.PlaceNextQueen()
	}
}

func BenchmarkPlaceNextQueen12(b *testing.B) {
	const n_size int = 12
	board := InitializeBoard(n_size)
	b.ResetTimer()
	for i := 0; i < b.N; i++ {
		board.PlaceNextQueen()
	}
}
