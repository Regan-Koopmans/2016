public class Main
{
  public static void main(String[] args)
  {
    int THREADS = 20;

    Print[] pool = new Print[THREADS];
    Counter C = new Counter(THREADS);
    for (int x = 0; x  < THREADS; x++)
    {
      pool[x] = new Print(C);
      pool[x].start();
    }

  }
}
