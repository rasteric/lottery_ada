all:
	gnatmake -Plottery.gpr

clean:
	gnatclean -Plottery.gpr

install:
	cp lottery /usr/local/bin/lottery

