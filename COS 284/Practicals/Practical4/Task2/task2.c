#include <stdlib.h>
#include <stdio.h>
#include <math.h>

extern void dotProduct(float x1,float x2,float xNorm, float y1, float y2, float yNorm);

int main(int argc, char *argv[])
{
	float x1 = atof(argv[1]);
	float x2 = atof(argv[2]);
	float y1 = atof(argv[3]);
	float y2 = atof(argv[4]);
	
	dotProduct(x1,x2,sqrtf(x1*x1+x2*x2), y1,y2,sqrtf(y1*y1+y2*y2));
	
	return 0;
}
