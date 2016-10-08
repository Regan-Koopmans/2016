# include <stdlib.h>
# include <stdio.h>
# include <fcntl.h>
# include <unistd.h>
# include <ctype.h>

# include <sys/mman.h>

void usage();

int main(int argc, char * argv[])
{
  if (argc != 2) usage();


  // Counter for the number of printable characters.

  int printable = 0;

  // Counter for the number of whitespaces

  int whitespace = 0;

  FILE * fd = fopen(argv[1],"r");
  fseek(fd, 0L, SEEK_END);
  int size = ftell(fd);
  fclose(fd);

  int file_handle = open(argv[1],O_RDONLY);

  char * mapping = (char *)mmap(NULL,size,PROT_READ,MAP_SHARED,file_handle,0);

  if (mapping == MAP_FAILED)
  {
    printf("\n\e[31m\e[1mERROR!\e[0m : Failed to map file to memory.\n\n");
    exit(1);
  }
  int x = 0;
  while (x < size)
  {
    if (isprint(mapping[x]))
      ++printable;
    if (isspace(mapping[x]))
      ++whitespace;
    ++x;
  }

  close(file_handle);
  printf("\n%d printable characters out read.\n",printable);
  printf("%d whitespace characters out read.\n\n",whitespace);

  close(file_handle);
  munmap(mapping,size);

  return 0;
}

void usage()
{
  printf("\n\e[1mUsage\e[0m : program file \n\n");
  exit(0);
}
