import java.util.Vector;

public abstract class ConsensusProtocol<T> implements Consensus<T>
{
  protected Vector<T> proposed;

  public ConsensusProtocol(int threadCount)	{
    proposed = new Vector<T>(threadCount);
    proposed.setSize(threadCount);
  }

  void propose(T value)	{
    proposed.set(ThreadID.get(), value);
  }

  abstract public T decide(T value);
}
