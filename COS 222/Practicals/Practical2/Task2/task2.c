# include <pthread.h>
# include <unistd.h>
# include <stdio.h>
# include <sys/wait.h>
# include <stdlib.h>

void printAndIncrement();

int globalCounter = 0;
int childComplete = 0;
int status;

int main()
{

  printAndIncrement();
  return 0;
}


void printAndIncrement()
{

  pid_t pid = fork();
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
    if (wait(&status) == pid)
    printf("\n");
    printf("Global counter : %d\n",globalCounter);
  }
}
