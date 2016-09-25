import java.util.concurrent.ConcurrentLinkedQueue;

public class PeekConsensus extends ConsensusProtocol<Integer>	{

  public PeekConsensus(int threadCount)	{
    super(threadCount);
  }
  private ConcurrentLinkedQueue<Integer> queue = new ConcurrentLinkedQueue<Integer>();

  public Integer decide(Integer value)	{
      System.out.println("\t" + ThreadID.get() + " : is adding " + value + " to queue." );
      propose(value);
      queue.add(ThreadID.get());
      int returnValue;
      if (queue.peek().equals(ThreadID.get()))
          returnValue = proposed.get(ThreadID.get());
      else returnValue = proposed.get(queue.peek());
      System.out.println("\t" + ThreadID.get() + " : read " + returnValue + " from peek().");
      return returnValue;

  }
}
