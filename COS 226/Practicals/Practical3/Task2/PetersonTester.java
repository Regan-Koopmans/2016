
public class PetersonTester
{
    public static void main(String [] args)
    {
        Thread [] threadPool = new Thread[4];
        PetersonTree pt = new PetersonTree(4);

        for (int x = 0; x < threadPool.length; x++)
            threadPool[x] = new Thread(new Task(pt));

        for (int x = 0; x < threadPool.length; x++)
            threadPool[x].start();


    }
}
