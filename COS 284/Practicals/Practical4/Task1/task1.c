#include <stdio.h>
#include <stdlib.h>

extern int pseudoRC(int one, int two, int three);

int main(int argc, char *argv[])
{
	int p1 = atoi(argv[1]);
	int p2 = atoi(argv[2]);
	int p3 = atoi(argv[3]);
	
	int result = pseudoRC(p1,p2,p3);
	
	if (result == 0)
		printf("%d/%d does not have a remainder of %d\n",p1,p2,p3);
	else
		printf("%d/%d does have a remainder of %d\n",p1,p2,p3);
	
	return 0;
}
