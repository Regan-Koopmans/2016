#include <stdio.h>

extern int intensity(char* source, char* dest, int intense);

int main()
{
	char* source = "flowers.bmp";
	char* dest = "flowersModified.bmp";
	int intense = 1;
	intensity(source, dest, intense);
	//Should maximize the intensity of green in the image
	return 0;
}
