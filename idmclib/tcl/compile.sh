swig -tcl idmc.i
gcc -shared idmc_wrap.c -o tclidmclib.so -I/usr/include/tcl8.4 \
	`pkg-config idmclib --libs --cflags`
