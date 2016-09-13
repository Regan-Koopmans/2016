import java.util.ConcurrentModificationException;

public class ConsensusThread
  extends Thread
{
	private Consensus<Integer> ConsensusObject;
	private Integer InputValue;
	private int Delay;

	public ConsensusThread(Consensus<Integer> consensusObject, int inputValue, int delay)	{
		ConsensusObject = consensusObject;
		InputValue = inputValue;
		Delay = delay;
	}

	public void run()	{

		System.out.println(ThreadID.get() + " : proposing " + InputValue + " " + "(Sleeping for " + Delay + ")");
		try {
			Thread.sleep(Delay);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		Integer decideValue = ConsensusObject.decide(InputValue);
		System.out.println(ThreadID.get() + " : decided on " + decideValue);
	}
}
