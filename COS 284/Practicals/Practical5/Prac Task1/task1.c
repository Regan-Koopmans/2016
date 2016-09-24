#include <stdio.h>

extern int encode(char* input);

int main()
{
	char* input = "wwwwaaadexxxxxx";
	encode(input);
	//Should output "w4a3d1e1x6"
	return 0;
}
