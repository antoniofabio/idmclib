#include <stdio.h>
#include <stdlib.h>

int loadFile(FILE *f, char** buffer) {
	int buflen;
	char *ans;
	fseek(f, 0L, SEEK_END);
	buflen = ftell(f);
	rewind(f);
	ans = malloc(buflen * sizeof(char));
	fread(ans, buflen, sizeof(char), f);
	*buffer = ans;
	return buflen;
}
