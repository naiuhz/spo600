BINARY=loop

all:    ${BINARY}
AS_ARGS=-g


loop:      loop.s
	as      ${AS_ARGS}      -o loop.o          loop.s
	ld                      -o loop            loop.o

loop3:      loop3.s
	as      ${AS_ARGS}      -o loop3.o          loop3.s
	ld                      -o loop3            loop3.o

clean:  
	rm ${BINARY} *.o || true

