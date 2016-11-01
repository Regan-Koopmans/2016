
public abstract class Account
{
  private IReporter Reporter;
  private double Amount;

    // This is a constructor that

  public Account(IReporter reporter, double initialAmount)	{
    Reporter = reporter;
    Amount = initialAmount;
  }

  protected double getAmount()	{	return Amount;	}

  protected void changeAmount(double amount) 	{
    Reporter.recordAction("Thread " + ThreadID.get() + " : " + 
      Double.toString(Amount) + "," + Double.toString(amount));
    Amount += amount;
  }
  public abstract void deposit(double amount);
  public abstract void withdraw(double amount, boolean preferred);
}
