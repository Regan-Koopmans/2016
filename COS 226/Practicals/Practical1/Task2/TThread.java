//Practical assignment 1
//Thread created by extending the Thread class

import java.lang.Thread;

class TThread extends Thread
{
	int getValue;
	private Counter C;
	public void run()
	{
		for (int x = 0; x < 4; x++)
		{
			try { sleep(400); } catch (Exception E) { System.out.println(E); }
			getValue = C.getAndIncrement();
			System.out.println(getName() + " " + getValue);
		}
	}

	public TThread(){}

	public TThread(Counter inputCounter)
	{
		C = inputCounter;
	}
}
