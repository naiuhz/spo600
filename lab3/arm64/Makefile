BINARY=loop

all:    ${BINARY}
AS_ARGS=-g


loop:      loop.s
	as      ${AS_ARGS}      -o loop.o          loop.s
	ld                      -o loop            loop.o

clean:  
	rm ${BINARY} *.o || true

