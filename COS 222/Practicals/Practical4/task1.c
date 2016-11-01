# include <stdlib.h>
# include <stdio.h>
# include <fcntl.h>
# include <unistd.h>
# include <ctype.h>
# include <string.h>

void usage();

int main(int argc, char * argv[])
{
  if (argc > 4 || argc < 2) usage();

  int bytesToRead = 1024;

  // Counter for the number of printable characters.

  int printable = 0;

  // Counter for the number of whitespaces

  int whitespace = 0;
  char characters[8192];

  if (argc == 3)
  {
    bytesToRead = atoi(argv[2]);
  }

  if (bytesToRead > 8192)
  {
    printf("\n\e[31m\e[1mERROR!\e[0m : A chuck size over 8KB is not permitted.\n\n");
    exit(1);
  }

  FILE * file_handle = fopen(argv[1],"r");
  int x;
  int readCount;
  int reachedEnd = 0;
  int bytesRead = 0;

  readCount = fread(characters, 1,bytesToRead, file_handle);
  do
  {
    x = 0;
    while(x < readCount)
    {
        if (isprint(characters[x]))
          ++printable;
        if (isspace(characters[x]))
          ++whitespace;
        x++;

        ++bytesRead;
    }
    readCount = fread(characters, 1,bytesToRead, file_handle);
  } while (readCount == bytesToRead);
  for (x = 0; x < readCount; x++)
  {
    if (isprint(characters[x]))
      ++printable;
    if (isspace(characters[x]))
      ++whitespace;

    ++bytesRead;
  }


  fclose(file_handle);

  printf("\n%d printable characters out of %d bytes.\n",printable,bytesRead);
  printf("%d whitespace characters out of %d bytes.\n\n",whitespace,bytesRead);
  return 0;
}

void usage()
{
  printf("\n\e[1mUsage\e[0m : program <file> [optional size specifier] \n\n");
  exit(0);
}
