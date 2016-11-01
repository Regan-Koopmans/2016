/*
  Class       : Condition Variable Savings Account

  Author      : Regan Koopmans, 15043143

  Description : Defines a class which guarantees
  that a savings account is never smaller than 0.
 */

import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.ReentrantLock;

public class SavingsAccount extends Account
{
  final ReentrantLock locker = new ReentrantLock();
  final Condition isSufficientFunds = locker.newCondition();
  final Condition isNotPreferred = locker.newCondition();

  public SavingsAccount(IReporter reporter, double initialAmount)
  {
    super(reporter, initialAmount);
  }

    /*
                         [Why do we need a lock?]

      Even though we want these functions to happen in parallel, we
      still need a lock. We have to use a lock because the condition
      variable will be modified by multiple threads at multiple times,
      and we would like the Condition variable to exhibit consistency.
      Therefore the lock exists purely to maintain the Condition
      variable.

                     [Where do I need to call the lock?]

      Since the isSufficientFunds Condition variable could be modified
      in either of the functions:

            - deposit
            - withdraw

      I need to call the lock in both of these functions. The cost of
      this is however considerable. By doing this we have remove the
      chance of any of these transactions happening in parrallel, even
      if a deposit does not strictly have much to do with a withdrawal.
      By introducing these locks I have lost all true parrallelism by
      introducing a bottleneck for the system.

     */


  public void deposit(double amount)
  {
    locker.lock();
    try
    {
        changeAmount(amount);

        // Value is now perhaps large enough to
        // accomodate withdrawals. So signal all.

        isSufficientFunds.signalAll();
    }
    finally
    {
        locker.unlock();
    }
  }

  public void withdraw(double amount, boolean preferred)
  {
    locker.lock();
    try
    {
        while (getAmount() - amount < 0)
            isSufficientFunds.await();
        changeAmount(-amoun);
    }
    catch (Exception e)
    {
        System.out.println(e.toString());
    }
    finally
    {
        locker.unlock();
    }
  }
}
