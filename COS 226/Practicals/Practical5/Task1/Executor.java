import java.util.LinkedList;
import java.util.ListIterator;
import java.util.Random;

public class Executor
{
	private final int ThreadCount;

	private PeekConsensus ConsensusObject;

  private LinkedList<ConsensusThread> Threads = new LinkedList<ConsensusThread>();

  public Executor(int threadCount)
  {
  	ThreadCount = threadCount;
    ConsensusObject = new PeekConsensus(threadCount);
  }

  public void run()
  {
    // Create the delayed consensus threads
    Random rng = new Random();

    for (int i = 0; i < (ThreadCount - 1); i++)		{
      Threads.add(new ConsensusThread(ConsensusObject, rng.nextInt(), (50 + rng.nextInt(50))));
    }

    // Create the non-delayed consensus thead
    Threads.add(new ConsensusThread(ConsensusObject, rng.nextInt(), 0));

    // Start the consensus threads
    ListIterator<ConsensusThread> iterator = Threads.listIterator();
    
    while (iterator.hasNext())
      iterator.next().start();
    
    // Wait for the consensus threads to finish executing
    while (iterator.hasPrevious())	{
      try	{
        iterator.previous().join();
      }
      catch (InterruptedException exception)	{
        System.out.println("Thread interrupted while waiting for join.");
      }
    }
  }

	public static void main(String[] args)
  {
    Executor executor = new Executor(100);

    executor.run();
  }
}
