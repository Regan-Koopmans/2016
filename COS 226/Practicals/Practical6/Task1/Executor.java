
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.LinkedList;
import java.util.ListIterator;

public class Executor
  implements IReporter
{
  private ConcurrentLinkedQueue<String> OutputBuffer = new ConcurrentLinkedQueue<String>();

  public Executor()
  {
  }

  private void testAmount()
  {
    int WITHDRAWERS = 10;

    recordAction("BEGIN: testAmount");

    Account account = new SavingsAccount(this, 100.00);

    LinkedList<TestThread> withdrawers = new LinkedList<TestThread>();

    for (int i = 0; i < WITHDRAWERS; i++)
      withdrawers.add(new TestThread(this, account, User.ORDINARY_WITHDRAWER, 1.00, 11));

    ListIterator<TestThread> iterator = withdrawers.listIterator();
    while (iterator.hasNext())
      iterator.next().start();

    try
    {
      Thread.sleep(500);
    }
    catch (InterruptedException exception)
    {
      System.out.println("Thread interrupted while sleeping.");
    }

    TestThread depositor = new TestThread(this, account, User.DEPOSITOR, 25.00, 2);
    depositor.start();

    // Wait for all of the threads to finish executing
    iterator = withdrawers.listIterator();
    boolean threads_live = true;

    while (threads_live)
    {
      threads_live = false;

      // Check the status of the withdrawer threads
      while (iterator.hasNext())
      {
        if (iterator.next().isAlive())
          threads_live = true;
      }

      // Check the status of the depositor thread
      if (depositor.isAlive())
        threads_live = true;

      // Print all pending output lines
      flushOutput();

      // Reset the iterator
      iterator = withdrawers.listIterator();
    }

    recordAction("END");
  }

  private void testWithdrawal()
  {
    recordAction("BEGIN: testWithdrawal");

    Account account = new SavingsAccount(this, 100.0);

    TestThread withdrawer1 = new TestThread(this, account, User.ORDINARY_WITHDRAWER, 750.00, 1);
    TestThread withdrawer2 = new TestThread(this, account, User.ORDINARY_WITHDRAWER, 500.00, 1);
    TestThread withdrawer3 = new TestThread(this, account, User.PREFERRED_WITHDRAWER, 1000.00, 1);

    withdrawer1.start();
    withdrawer2.start();
    withdrawer3.start();

    TestThread depositor = new TestThread(this, account, User.DEPOSITOR, 50.00, 43);

    depositor.start();

    // Wait for all of the threads to finish executing
    boolean threads_live = true;

    while (threads_live)
    {
      threads_live = false;

      // Check the status of the withdrawer threads
      if (withdrawer1.isAlive() || withdrawer2.isAlive() || withdrawer3.isAlive())
        threads_live = true;

      // Check the status of the depositor thread
      if (depositor.isAlive())
        threads_live = true;

      // Print all pending output lines
      flushOutput();
    }

    recordAction("END");
  }

  public void run()
  {
    testAmount();
  }

  public void recordAction(String action)
  {
    printOutput(action);
  }

  private void printOutput(String line)
  {
    OutputBuffer.add(line);
  }

  private void flushOutput()
  {
    String line = OutputBuffer.poll();

    while (line != null)
    {
      System.out.println(line);

      line = OutputBuffer.poll();
    }
  }

	public static void main(String[] args)
  {
    Executor executor = new Executor();

    executor.run();
  }
}
