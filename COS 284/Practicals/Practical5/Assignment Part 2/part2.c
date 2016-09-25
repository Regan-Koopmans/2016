#include <stdio.h>

extern int crop(char* source, char* dest, int width, int height);

int main()
{
	char* source = "flowers.bmp";
	char* dest = "flowersModified.bmp";
	int width = 20;
	int height = 20;
	crop(source, dest, width, height);
	//Should crop image down to 20x20
	return 0;
}
