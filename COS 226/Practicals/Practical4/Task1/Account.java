import java.util.concurrent.atomic.AtomicLong;

public class Account {

	private AtomicLong balance;

	public Account()
	{
        balance = new AtomicLong(0);
	}
	public long getBalance()
	{
		return balance.get();
	}
	public void setBalance(long balance)
	{
        this.balance.set(balance);
        System.out.println("Setting to " + this.balance.get());
	}

	public void addAmount(long amount)
	{
        this.balance.addAndGet(amount);
        System.out.println("Added to " + balance.get());
	}
	public void subtractAmount(long amount)
	{
        this.balance.addAndGet(-1*amount);
        System.out.println("Decrementing to " + balance.get());
	}
}
