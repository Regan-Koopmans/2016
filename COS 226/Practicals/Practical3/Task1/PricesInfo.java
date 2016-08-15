import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReadWriteLock;
import java.util.concurrent.locks.ReentrantReadWriteLock;


public class PricesInfo {
	private double price1;
	private double price2;
	private ReadWriteLock lock;
	
	public PricesInfo()
	{
		lock = new ReentrantReadWriteLock();
		price1 = 1.0;
		price2 = 2.0;
	}
	
	public double getPrice1()
	{
		return price1;
	}
	
	public double getPrice2()
	{
		lock.readLock();
		try
		{
			lock.readLock().unlock();
			return price2;
		}
		finally {}

	}
	
	public void setPrices(double price1, double price2)
	{
		lock.writeLock().lock();
		try
		{
			this.price1 = price1;
			this.price2 = price2;
		}
		finally
		{
			lock.writeLock().unlock();
		}
	}
}
