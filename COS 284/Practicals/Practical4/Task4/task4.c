#include <stdio.h>
#include <stdlib.h>

extern int findLargest(int a, int b, int c, int d, int e,int f, int g, int h, int i, int j,
		int k, int l, int m, int n, int o, int p, int q, int r, int s, int t);

int main(int argc, char *argv[])
{
	int p1 = atoi(argv[1]);
	int p2 = atoi(argv[2]);
	int p3 = atoi(argv[3]);
	int p4 = atoi(argv[4]);
	int p5 = atoi(argv[5]);
	int p6 = atoi(argv[6]);
	int p7 = atoi(argv[7]);
	int p8 = atoi(argv[8]);
	int p9 = atoi(argv[9]);
	int p10 = atoi(argv[10]);
	int p11 = atoi(argv[11]);
	int p12 = atoi(argv[12]);
	int p13 = atoi(argv[13]);
	int p14 = atoi(argv[14]);
	int p15 = atoi(argv[15]);
	int p16 = atoi(argv[16]);
	int p17 = atoi(argv[17]);
	int p18 = atoi(argv[18]);
	int p19 = atoi(argv[19]);
	int p20 = atoi(argv[20]);
	
	int result = findLargest(p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15,p16,p17,p18,p19,p20);
	
	printf("The largest integer was %d\n",result);
	
	return 0;
}
