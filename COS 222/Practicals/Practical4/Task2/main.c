# include <stdlib.h>
# include <stdio.h>
# include <fcntl.h>
# include <unistd.h>
# include <ctype.h>

# include <sys/mman.h>

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
    printf("\n\e[31m\e[1mERROR!\e[0m : A chuck size over 4KB is not permitted.\n\n");
    exit(1);
  }

  int file_handle = open(argv[1],O_RDONLY,0);
  char * mapping = (char *)mmap(NULL,bytesToRead,PROT_READ,MAP_SHARED,file_handle,0);

  if (mapping == MAP_FAILED)
  {
    printf("\n\e[31m\e[1mERROR!\e[0m : Failed to map file to memory.\n\n");
    exit(1);
  }

  for (int x = 0; x < bytesToRead; x++)
  {
    if (isprint(mapping[x]))
      ++printable;
    if (isspace(mapping[x]))
      ++whitespace;
  }

  close(file_handle);
  printf("\n%d printable characters out of %d bytes.\n",printable,bytesToRead);
  printf("%d whitespace characters out of %d bytes.\n\n",whitespace,bytesToRead);

  close(file_handle);
  munmap(mapping,bytesToRead);

  return 0;
}

void usage()
{
  printf("\n\e[1mUsage\e[0m : program <file> [optional size specifier] \n\n");
  exit(0);
}
