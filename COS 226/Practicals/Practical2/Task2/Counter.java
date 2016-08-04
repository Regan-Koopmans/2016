import java.lang.Thread;

public class Counter
{

  Filter lock;
  public Counter(int threads)
  {
    lock = new Filter(threads);
  }
  private int counter = 0;
  public int getAndIncrement()
  {
    lock.lock();
    try
    {
      //try{Thread.currentThread().sleep(1);}catch(Exception e) {};
      System.out.println(counter+1);
      return counter++;
    }
    finally { lock.unlock(); }
  }
}
