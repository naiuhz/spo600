BINARIES = vol_inline vol_intrinsics add vol1
CCOPTS = -g -O3 
CC=gcc

all:		${BINARIES}

vol_inline:	vol_inline.c vol.h
		${CC} ${CCOPTS} vol_inline.c -o vol_inline

vol_intrinsics:	vol_intrinsics.c vol.h
		${CC} ${CCOPTS} vol_intrinsics.c -o vol_intrinsics

vol1:		vol1.c vol.h
		${CC} ${CCOPTS} vol1.c -o vol1

add:		add.c
		${CC} ${CCOPTS} add.c -o add

fopt:		vol1.c vol.h
		${CC} ${CCOPTS} -fopt-info-vec-all vol1.c vol.h

volnew:		volnew.c vol.h
		${CC} ${CCOPTS} -fopt-info-vec-all volnew.c -o volnew

clean:	
		rm ${BINARIES} || true


