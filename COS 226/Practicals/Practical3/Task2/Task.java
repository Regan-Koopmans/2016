/**
 * Created by regan on 2016/08/19.
 */
public class Task implements Runnable
{
    PetersonTree pt;
    public Task(PetersonTree pt)
    {
        this.pt = pt;
    }

    public void run()
    {
        while (true)
        {
            try {
                Thread.sleep(0);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            System.out.println(ThreadID.get() + " is trying to print");
            pt.PTreeLock();
            try
            {
                System.out.println("\t\t" + ThreadID.get() + " prints.");
            }
            finally
            {
                pt.PTreeUnlock();
            }
        }
    }
}
