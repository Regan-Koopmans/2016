import java.util.concurrent.ConcurrentLinkedQueue;

public class PeekConsensus extends ConsensusProtocol<Integer>	{
  public PeekConsensus(int threadCount)	{
    super(threadCount);
  }
  private ConcurrentLinkedQueue<Integer> queue = new ConcurrentLinkedQueue<>();

  public Integer decide(Integer value)	{
    queue.add(value);
    return queue.peek();
  }
}
