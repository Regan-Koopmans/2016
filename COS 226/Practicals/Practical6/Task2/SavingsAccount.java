/*
  Class       : Preference Condition Variable Savings Account

  Author      : Regan Koopmans, 15043143

  Description : Defines a class which guarantees
  that a savings account is never smaller than 0.
  Additionally, some tasks may be prioritised over
  others, in which these are guaranteed to be
  processed first.

 */

import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.ReentrantLock;
import java.util.concurrent.atomic.AtomicInteger;

public class SavingsAccount extends Account
{
  final ReentrantLock locker = new ReentrantLock();
  final Condition isSufficientFunds = locker.newCondition();
  final Condition isNotPreferred = locker.newCondition();

    // This atomic integer keeps track of the number of
    // pending preferred requests to process.

    AtomicInteger numPreferred = new AtomicInteger(0);

  public SavingsAccount(IReporter reporter, double initialAmount)
  {
    super(reporter, initialAmount);
  }


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
        {
            if (preferred)
            {

                /*
                  A preferred thread increments the numPreferred
                  variable, indicating its request in the system.
                 */

                numPreferred.getAndIncrement();
                isSufficientFunds.await();
                numPreferred.getAndDecrement();
            }
            else
            {
                /*
                  If there is at least one preferred request in
                  the system, a non-prefered request will wait
                  until it has been communicated to that no preferred
                  threads exist.

                 */
                isSufficientFunds.await();
                while (numPreferred.get() > 0)
                {
                    isNotPreferred.await();
                }
            }
        }
        changeAmount(-amount);
    }
    catch (Exception e)
    {
        System.out.println(e.toString());
    }
    finally
    {
        /*

          If a preferred thread discovers that they were
          the last preferred thread (that numPreferred is
          now 0), they will indicate to the waiting non-preferrred
          threads that they may now attempt to process.

         */

        if (numPreferred.get() == 0)
            isNotPreferred.signalAll();

        locker.unlock();
    }
  }
}
