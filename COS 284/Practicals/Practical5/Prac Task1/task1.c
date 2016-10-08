# include <stdio.h>
# include <string.h>
# include <stdlib.h>
# include <assert.h>

extern int encode(char* input);

char * encodeExample(char *src)
{
  int rLen;
  char count[50];
  int len = strlen(src);

  /* If all characters in the source string are different, 
    then size of destination string would be twice of input string.
    For example if the src is "abcd", then dest would be "a1b1c1d1"
    For other inputs, size would be less than twice.  */
  char *dest = (char *)malloc(sizeof(char)*(len*2 + 1));

  int i, j = 0, k;

  /* traverse the input string one by one */
  for(i = 0; i < len; i++)
  {

    /* Copy the first occurrence of the new character */
    dest[j++] = src[i];

    /* Count the number of occurrences of the new character */
    rLen = 1;
    while(i + 1 < len && src[i] == src[i+1])
    {
      rLen++;
      i++;
    }

    /* Store rLen in a character array count[] */
    sprintf(count, "%d", rLen);

    /* Copy the count[] to destination */
    for(k = 0; *(count+k); k++, j++)
    {
      dest[j] = count[k];
    }
  }

  /*terminate the destination string */
  dest[j] = '\0';
  return dest;
}

int main()
{
  char * test1 = "wwwwaaadexxxxxxxn";
  char * test2 = "aaaabbbbcccccccccccdddddddddddddd";
  char * test3 = "ttttttt";
  char * test4 = "";

  char * output1 = encodeExample(test1);
  printf("%s\n",output1);
  encode(test1);
  printf("\n");

  char * output2 = encodeExample(test2);
  printf("%s\n",output2);
  encode(test2);
  printf("\n");

  char * output3 = encodeExample(test3);
  printf("%s\n",output3);
  encode(test3);
  printf("\n");

  char * output4 = encodeExample(test4);
  printf("%s\n",output4);
  encode(test4);
  //printf("\n");
  return 0;
}

