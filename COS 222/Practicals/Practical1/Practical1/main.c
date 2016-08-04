# include <stdio.h>
# include <unistd.h>
# include <stdlib.h>
# include <ctype.h>
# include <string.h>
# include <sys/wait.h>

int main(int argc,char * argv[])
{
  pid_t pid;
  int   fd[2];
  char  reader_buff[256];
  char  parent_buff[256] = "";
  char  child_buff[256];
  int debug, i;
  if (argc >= 2)
    debug = !strcmp(argv[1],"debug");
  else
    debug = 0;

  if ((pipe(fd)) == -1)
  {
    perror("Failed to open pipe.");
    exit(1);
  }

  pid = fork();
  if (pid == 0)
  {
    read(fd[0],child_buff,sizeof(child_buff));
    if (debug)
    {
      printf("\033[0;32mChild :\033[0;37m Received\033[0;32m \"%s\" \033[0;37m\n",child_buff);
    }

    i = 0;
    while (child_buff[i])
    {
      child_buff[i] = toupper(child_buff[i]);
      i++;
    }
    write(fd[1],child_buff,sizeof(child_buff));
    if (debug)
    {
      printf("\033[0;32mChild :\033[0;37m Sending\033[0;32m \"%s\" \033[0;37mto parent \n",child_buff);
    }
  }
  else
  {
    while (fgets(reader_buff,255,stdin))
      strcat(parent_buff,reader_buff);


    if (debug)
    {
        printf("\033[0;32mParent :\033[0;37m Sending\033[0;32m \"%s\" \033[0;37mto child \n",parent_buff);
    }
    write(fd[1],parent_buff,sizeof(parent_buff));
    wait(NULL);
    read(fd[0],parent_buff,sizeof(parent_buff));
    if (debug)
    {
        printf("\033[0;32mParent :\033[0;37m Received\033[0;32m \"%s\" \033[0;37m\n",parent_buff);
    }
    else
    {
      printf("\033[0;32m%s\033[0;37m\n",parent_buff);
    }
  }
  return(0);
}
