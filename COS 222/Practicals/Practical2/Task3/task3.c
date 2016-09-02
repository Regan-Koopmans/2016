# include <unistd.h>
# include <stdio.h>
# include <sys/wait.h>
# include <stdlib.h>

void printAndIncrement(pid_t pid);
int globalCounter = 0;

int main()
{
  void * stack;
  stack = malloc(FIBER_STACK);
  pid_t pid = clone(&printAndIncrement, (char *)stack + FIBER_STACK, CLONE_VM, 0);
  printAndIncrement(pid);
  printf("\n");
  printf("Global counter : %d\n",globalCounter);
  return 0;
}


void printAndIncrement(pid_t pid)
{
  if (pid == 0)
  {
    for (int x = 0; x < 20; x++)
    {
      printf("c");
      globalCounter++;
      fflush(0);
      usleep(250000);
    }
    exit(0);
  }
  else
  {
    for (int x = 0; x < 20; x++)
    {
      printf("p");
      globalCounter++;
      fflush(0);
      usleep(250000);
    }
  }
}
