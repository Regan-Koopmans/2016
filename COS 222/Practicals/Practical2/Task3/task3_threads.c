# define _GNU_SOURCE
# include <sched.h>

# include <unistd.h>
# include <stdio.h>
# include <stdlib.h>
# include <sys/wait.h>
# include <sys/types.h>
# include <stdlib.h>

#define SIZESTACK ( 1024 * 1024)

void printAndIncrement(pid_t pid);
int globalCounter = 0;

int main()
{
  char * stack;
  char * stackhead;
  int status;
  stack = (char *) malloc(SIZESTACK);
  stackhead = stack + SIZESTACK - 1;

  pid_t pid;
  pid = clone(printAndIncrement, stackhead, CLONE_VM|SIGCHLD, pid);
  printAndIncrement(pid);
  waitpid(pid,&status,0);

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
      ++globalCounter;
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
      ++globalCounter;
      fflush(0);
      usleep(250000);
    }
  }
}
