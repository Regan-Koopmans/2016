# define _GNU_SOURCE
# include <linux/sched.h>

# include <unistd.h>
# include <stdio.h>
# include <stdlib.h>
# include <sys/wait.h>
# include <sys/types.h>
# include <stdlib.h>

#define SIZESTACK ( 1024 * 1024)

void  printAndIncrement();
int globalCounter = 0;

int main()
{
  char * stack;
  char * stackhead;
  int status;
  stack = (char *) malloc(SIZESTACK);
  stackhead = stack + SIZESTACK - 1;

  pid_t pid;
  pid = clone(printAndIncrement, stackhead,CLONE_FILES|CLONE_VM|SIGCHLD, NULL);

  for (int y = 0; y < 20; y++)
  {
    write(STDOUT_FILENO,"p",2);
    ++globalCounter;
    fflush(0);
    usleep(250000);
  }
  waitpid(pid,&status,0);
  fflush(0);

  //printf("Child is all done?");

  printf("\n");
  printf("Global counter : %d\n",globalCounter);
  return 0;
}

void  printAndIncrement()
{
    for (int x = 0; x < 20; x++)
    {
      write(STDOUT_FILENO,"c",2);
      ++globalCounter;
      fflush(0);
      usleep(250000);
    }
}
