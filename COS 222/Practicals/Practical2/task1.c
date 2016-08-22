# include <pthread.h>
# include <stdio.h>

void * printAndIncrement(void * id);

int globalCounter = 0;

pthread_t tid[2];

int main()
{
  pthread_create(&(tid[1]),NULL,printAndIncrement,&tid[1]);
  printAndIncrement(tid[0]);
  pthread_join(tid[1],NULL);
  printf("\n");
  printf("Global counter : %d\n",globalCounter);
  return 0;
}

void * printAndIncrement(void * id)
{
  if (pthread_equal(id,tid[0]))
  {
    for (int x = 0; x < 20; x++)
    {
        printf("p");
        ++globalCounter;
        fflush(0);
    }
  }
  else
  {
    for (int x = 0; x < 20; x++)
    {
      printf("c");
      ++globalCounter;
      fflush(0);
    }
  }

}
