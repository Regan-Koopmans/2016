import java.util.Arrays;

/**
 * Created by regan on 2016/08/29.
 */
public class QuickTester
{
    public static void main(String [] args)
    {
        int[] list = new int[1000000];
        for(int i = 0; i < list.length; i++) {
            list[i] = (int)(Math.random()*1000000);
        }
        list = new int[]{97, 45, 12, 6, 42, 7, 12, 2, 8, 50};
        long startTime = System.nanoTime();
        QuickSort.parallelQuickSort(list,100);
        long endTime = System.nanoTime();
        long duration = (endTime - startTime);
        System.out.println(duration);
    }
}
