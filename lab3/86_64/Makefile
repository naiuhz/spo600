BINARY=loop loop2

all:    ${BINARY}
AS_ARGS=-g


loop:      loop.s
	as      ${AS_ARGS}      -o loop.o          loop.s
	ld                      -o loop            loop.o

loop2:     loop2.s
	as      ${AS_ARGS}      -o loop2.o          loop2.s
	ld                      -o loop2            loop2.o


clean:
	rm ${BINARY} *.o || true                       
