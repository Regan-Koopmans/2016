//Practical assignment 1
//Thread created by extending the Thread class

class TThread extends Thread 
{
	int getValue;
	public void run() 
	{
		Thread.sleep(400);
		getValue = getAndIncrement();
		System.out.println(Thread.getName() + " " + getValue);
	}
}