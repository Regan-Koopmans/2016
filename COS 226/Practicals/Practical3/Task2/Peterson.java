import java.util.Date;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;

public class Peterson implements Lock {
	
	public Peterson()
	{

	}
	
	public void lock()
	{

	}
	
	public void lock(int id)
	{

	}
	
	public void unlock()
	{

	}
	
	public void unlock(int i)
	{

	}
	
	public Condition newCondition()
	{
		return new Condition() {
			@Override
			public void await() throws InterruptedException {

			}

			@Override
			public void awaitUninterruptibly() {

			}

			@Override
			public long awaitNanos(long l) throws InterruptedException {
				return 0;
			}

			@Override
			public boolean await(long l, TimeUnit timeUnit) throws InterruptedException {
				return false;
			}

			@Override
			public boolean awaitUntil(Date date) throws InterruptedException {
				return false;
			}

			@Override
			public void signal() {

			}

			@Override
			public void signalAll() {

			}
		};
	}
	
	public boolean tryLock(long time, TimeUnit unit) throws InterruptedException
	{
		return true;
	}
	
	public boolean tryLock()
	{
		return true;
	}
	
	public void lockInterruptibly() throws InterruptedException
	{

	}
}
