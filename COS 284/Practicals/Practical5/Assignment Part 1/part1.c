#include <stdio.h>

extern int border(char* source, char* dest);

int main()
{
	char* source = "flowers.bmp";
	char* dest = "flowersModified.bmp";
	border(source, dest);
	//Should create borders around the image
	return 0;
}
