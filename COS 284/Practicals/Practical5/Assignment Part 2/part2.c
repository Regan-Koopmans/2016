# include <stdio.h>
# include <sys/mman.h>

extern int crop(char* source, char* dest, int width, int height);

int main()
{
	char* source = "flowers.bmp";
	char* dest = "flowersModified.bmp";
	int width = 199;
	int height = 133;
	crop(source, dest, width, height);
	return 0;
}
