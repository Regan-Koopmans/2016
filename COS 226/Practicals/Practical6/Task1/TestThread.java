
public class TestThread extends Thread
{
	private IReporter Reporter;
	private Account TargetAccount;
	private User Type;
	private double Amount;
	private int RunCount;

	public TestThread(IReporter reporter, Account target_account, User type, double amount, int run_count)
	{
		Reporter = reporter;
		TargetAccount = target_account;
		Type = type;
		Amount = amount;
		RunCount = run_count;
	}

	public void run()
	{
		String description = "";

		switch (Type)
		{
			case DEPOSITOR:
			  description = "DEPOSITOR";
			break;

			case ORDINARY_WITHDRAWER:
			  description = "ORDINARY";
			break;

			case PREFERRED_WITHDRAWER:
			  description = "PREFERRED";

			default:
			break;
		}

		Reporter.recordAction("Thread " + ThreadID.get() + " : " + description);

	  for (int i = 0; i < RunCount; i++)
	  {
		  switch (Type)
		  {
		  	case DEPOSITOR:
		  	  TargetAccount.deposit(Amount);
		  	break;

		  	case ORDINARY_WITHDRAWER:
		  	  TargetAccount.withdraw(Amount, false);
		  	break;

		  	case PREFERRED_WITHDRAWER:
		  	  TargetAccount.withdraw(Amount, true);
		  	break;

		  	default:
		  	break;
		  }
		}
	}
}
