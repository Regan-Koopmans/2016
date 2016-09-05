# define _GNU_SOURCE
# include <sched.h>

# include <unistd.h>
# include <stdio.h>
# include <stdlib.h>
# include <sys/wait.h>
# include <sys/types.h>
# include <stdlib.h>

#define SIZESTACK ( 1024 * 1024)

void * printAndIncrement();
int globalCounter = 0;

int main()
{
  char * stack;
  char * stackhead;
  int status;
  stack = (char *) malloc(SIZESTACK);
  stackhead = stack + SIZESTACK - 1;

  pid_t pid;
  pid = clone(&printAndIncrement, stackhead, CLONE_VM|SIGCHLD, NULL);

  for (int y = 0; y < 20; y++)
  {
    printf("p");
    ++globalCounter;
    //fflush(0);
    usleep(250000);
  }
  waitpid(pid,&status,0);
  fflush(0);

  //printf("Child is all done?");

  printf("\n");
  printf("Global counter : %d\n",globalCounter);
  return 0;
}

void * printAndIncrement()
{
    for (int x = 0; x < 20; x++)
    {
      printf("c");
      ++globalCounter;
      fflush(0);
      usleep(250000);
    }
    //printf("child done!");
    return 0;
}
