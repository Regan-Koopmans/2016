import java.util.concurrent.locks.ReadWriteLock;
import java.util.concurrent.locks.ReentrantReadWriteLock;

public class PricesInfo
{
	private double price1;
	private double price2;
	private ReadWriteLock lock;
	
	public PricesInfo()
	{
		lock = new ReentrantReadWriteLock(true);
		price1 = 1.0;
		price2 = 2.0;
	}
	
	public double getPrice1()
	{
		lock.readLock().lock();

		try
		{
		}
		finally
		{
			lock.readLock().unlock();
		}
        return price1;

    }
	
	public double getPrice2()
	{
		lock.readLock().lock();
		try
		{

		}
		finally
		{
			lock.readLock().unlock();
		}
        return price2;
	}
	
	public void setPrices(double price1, double price2)
	{
		lock.writeLock().lock();
		try
		{
			System.out.println("Reads have completed");
			System.out.println("Changing price 1");
			this.price1 = price1;
			System.out.println("Changing price 2");
			this.price2 = price2;
		}
		finally
		{
			lock.writeLock().unlock();
		}
	}
}
