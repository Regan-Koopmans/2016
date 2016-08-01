
public class JobSimulator implements Runnable	{

	private PrintQueue printQueue;

	public JobSimulator(PrintQueue printQueue)	{
		this.printQueue = printQueue;
	}

	@Override
	public void run() {
		System.out.println(Thread.currentThread().getName()+ ": going to print a document");
		printQueue.printJob(new Object());
		System.out.println(Thread.currentThread().getName() + ": has printed a document");
	}
}
