import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;


public class QuickSort {


    private static int globalThreadMax;
    private static AtomicInteger threadsInUse = new AtomicInteger(1);

    public static Runnable parallelQuickSort(int[] a, int threadCount) {

        globalThreadMax = threadCount;
        quickSort(a,0,a.length-1);
        return null;
    }


	public static void quickSort(int[] a, int begin, int end)
	{
	    if (begin >= end) return;

        int largest = begin;
        {
            for (int x = begin; x < end; x++)
            {
                if (a[largest] < a[x])
                {
                    largest = x;                                    // Places largest element at end (avoids
                }                                                   // failing edge case).
            }
        }

        swapElements(a,largest,end);

	    int pivot = a[begin + (end-begin)/2];
        int low=begin,high=end;
        while (low <= high)
        {
            while (a[low] < pivot) { low++; }
            while (a[high] > pivot) { high--; }

            if (low <= high)
            {
                int temp = a[low];
                a[low] = a[high];
                a[high] = temp;
                low++;
                high--;
            }
        }

        if (low < end) { recurse(a, low, end);}

        if (high > begin) { recurse(a,begin,high);}

	}

    static private void printlist(int [] a)
    {
        System.out.print("{");
        for (int x = 0; x < a.length; x++)
            System.out.print(a[x] + " ");
        System.out.println("}");
    }

    static private void recurse(int [] a, int i, int j)
    {
        if (threadsInUse.get() < globalThreadMax)
        {
            threadsInUse.incrementAndGet();
            System.out.println(threadsInUse.get());
            Thread r1 = new Thread(new Sorter(a,i,j));

            r1.start();
            try {
                r1.join();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        else
        {
            quickSort(a,i,j);
        }

    }


    public static void swapElements(int [] a,int i, int j)
    {
        int temp = a[i];
        a[i] = a[j];
        a[j] = temp;
    }
}
