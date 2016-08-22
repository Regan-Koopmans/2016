
import com.sun.org.apache.xml.internal.utils.ThreadControllerWrapper;
import com.sun.xml.internal.ws.api.message.ExceptionHasMessage;

import java.util.Date;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;

public class Peterson implements Lock
{
	private boolean flag [];
    private AtomicInteger victim = new AtomicInteger();
    private int thread_0, thread_1;

    public Peterson left = null;
    public Peterson right = null;
    public Peterson parent = null;

    public Peterson(int threadCount)
    {
        this(null,threadCount);
    }

	public Peterson(Peterson parent, int threadCount)
    {
        this.parent = parent;
        flag = new boolean[threadCount];
    }


	public void lock()
	{
        victim.set(ThreadID.get());
        flag[ThreadID.get()] = true;
        while (anotherThreadInterested(ThreadID.get()) && isVictim(ThreadID.get())) {}
	}
	
	public void lock(int id)
	{
        flag[id] = true;
        victim.set(id);
        while (anotherThreadInterested(id) && isVictim(id)) {}
	}

	public void unlock()
	{
        flag[ThreadID.get()] = false;
	}
	
	public void unlock(int i)
	{
        flag[i] = false;
	}

	public boolean isVictim(int i)
    {
        return victim.get()==i;
    }

    public boolean anotherThreadInterested(int i)
    {
        for (int x = 0; x < flag.length; x++)
        {
            if (flag[x] && x != i)
                return true;
        }
        return false;
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
