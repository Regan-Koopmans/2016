#include <stdlib.h>
#include <stdio.h>

extern void swapNums(float* one,float* two,float* three);

int main(int argc, char *argv[])
{
	float one = atof(argv[1]);
	float two = atof(argv[2]);
	float three = atof(argv[3]);
	
	swapNums(&one, &two, &three);
	
	printf("The correct order is %.2f,%.2f,%.2f \n", one, two, three);
	
	return 0;
}
