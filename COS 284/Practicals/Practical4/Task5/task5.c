#include <stdio.h>
#include <stdlib.h>

extern int recursive(int x, int y, int z);

int main(int argc, char *argv[])
{
	int p1 = atoi(argv[1]);
	int p2 = atoi(argv[2]);
	int p3 = atoi(argv[3]);
	
	int result = recursive(p1,p2,p3);
	
	printf("The recursive result was %d\n",result);
	
	return 0;
}
