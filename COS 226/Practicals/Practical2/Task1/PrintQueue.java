
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import java.util.Random;
import java.lang.Thread;

public class PrintQueue {

	private final Lock queueLock = new ReentrantLock(true);
	Random gen = new Random();
	Integer waitTime;
	public void printJob(Object document)
	{
		queueLock.lock();
		try
		{
			waitTime = gen.nextInt(5)+1;
			System.out.println(Thread.currentThread().getName() + ": Printing a Job for " + waitTime + " seconds");
			try { Thread.currentThread().sleep(waitTime); }
			catch (Exception e) { System.out.println(e);}
			
		}
		finally
		{
			queueLock.unlock();
		}
	}
}
