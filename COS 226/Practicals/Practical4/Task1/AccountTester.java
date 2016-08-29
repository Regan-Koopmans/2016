/**
 * Created by regan on 2016/08/29.
 */
public class AccountTester
{
    public static void main(String [] args)
    {
        Account sharedAccount = new Account();
        Thread company = new Thread(new Company(sharedAccount));
        Thread company2 = new Thread(new Company(sharedAccount));
        Thread bank = new Thread(new Bank(sharedAccount));
        Thread bank2 = new Thread(new Bank(sharedAccount));
        bank.start();
        company.start();
        bank2.start();
        company2.start();
    }
}
