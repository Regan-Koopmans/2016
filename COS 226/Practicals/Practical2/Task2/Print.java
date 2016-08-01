import java.lang.Thread;

public class Print extends Thread
{
  private Counter C;
  int getValue;
  public Print(Counter inputCounter)
  {
    C = inputCounter;
  }

  public void run()
  {
    for (int x = 0; x < 1; x++)
    {
      try
      {
        getValue = C.getAndIncrement();
      } catch (Exception E) { System.out.println(E); }
    }
  }
}
