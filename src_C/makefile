## Authors: James Walker
## Copyrighted 2017 under the MIT license:
##   http://www.opensource.org/licenses/mit-license.php

## Targets
EIGHTQ_SOLVER = eight_queens_solver
NQ_SOLVER = n_queens_solver
NQ_COUNTER = n_queens_counter
PROGRAMS = $(EIGHTQ_SOLVER) $(NQ_SOLVER) $(NQ_COUNTER)

## Compilers, linkers, utilities, and flags
CC = gcc
STD = -std=c99
CFLAGS = -pedantic -Wall -Werror -Wextra
OPTLVL = -O2

## Create executables for all target programs
all: $(PROGRAMS)

## 8-Queens Solver
$(EIGHTQ_SOLVER): $(EIGHTQ_SOLVER).c
	$(CC) $(STD) $(CFLAGS) $(EIGHTQ_SOLVER).c -o $(EIGHTQ_SOLVER)

## n-Queens Solver
$(NQ_SOLVER): $(NQ_SOLVER).c
	$(CC) $(STD) $(CFLAGS) $(NQ_SOLVER).c -o $(NQ_SOLVER)

## n-Queens Counter
$(NQ_COUNTER): $(NQ_COUNTER).c
	$(CC) $(STD) $(OPTLVL) $(CFLAGS) $(NQ_COUNTER).c -o $(NQ_COUNTER)

## Prevents makefile from trying to compile or handle any file named clean
.PHONY: clean

clean:
	rm -f $(EIGHTQ_SOLVER) $(NQ_SOLVER) $(NQ_COUNTER)
