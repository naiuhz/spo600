# list all binaries in this next line
BINARIES = vol1 vol2 vol3
CCOPTS = -g -O3

all:	${BINARIES}

vol1:	vol1.c vol.h
	gcc ${CCOPTS} vol1.c -o vol1

vol2:	vol2.c vol.h
	gcc ${CCOPTS} vol2.c -o vol2

vol3:
	gcc ${CCOPTS} vol3.c -o vol3

test1:	vol1
	bash -c "time ./vol1"

test2:	vol2
	bash -c "time ./vol2"

test3:	vol3
	bash -c "time ./vol3"

# target to test all binaries
test:	test1 test2 test3

gdb1:	vol1
	gdb vol1

gdb2:	vol2
	gdb vol2

gdb3:	vol3
	gdb vol3

clean:	
	rm ${BINARIES} || true


