#include <stdio.h>

extern int border(char* source, char* dest);

int main()
{
	char* source = "Science guy.bmp";
	char* dest = "guyModified.bmp";
	border(source, dest);
	//Should create borders around the image
	return 0;
}
