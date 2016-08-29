import java.util.*;   


public class QuickSort {


    private static int globalThreadCount;


    public static Runnable parallelQuickSort(int[] a, int threadCount) {

        globalThreadCount = threadCount;
        return null;
    }

    public static void quickSort(int[] a)
    {
        quickSort(a,0,a.length-1);
    }

	public static void quickSort(int[] a, int begin, int end)
	{
        if (a.length > 2) {
            int largest = begin;
            int low = begin+1;
            int pivot = begin;
            int high = end;
            int temp;
            for (int x = begin; x < end; x++)
                if (a[largest] < a[x])
                    largest = x;

            temp = a[largest];
            a[largest] = a[a.length - 1];
            a[a.length - 1] = temp;

            printlist(a);

            while (low <= high) {

                if (a[low] < a[pivot]) {
                    low++;
                }

                if (a[high] > a[pivot]) {
                    high--;
                }

                if (a[low] > a[pivot] && a[high] < pivot) {
                    temp = a[low];
                    a[low] = a[high];
                    a[high] = temp;
                }
            }

            temp = a[low];
            a[low] = a[pivot];
            a[pivot] = temp;

            printlist(a);

            Thread sorter1 = new Thread(new Runnable() {
                public void run()
                {

                    quickSort(a,end/2+1,end);
                }
            });

            Thread sorter2 = new Thread(new Runnable() {
                public void run()
                {
                    quickSort(a,begin,end/2);
                }
            });
            sorter1.start();
            sorter2.start();
        }
        else if (end-begin == 2)
        {
            if (a[begin] > a[end])
            {
                int temp = a[end];
                a[end] = a[begin];
                a[begin] = temp;
            }
        }
	}

    static private void printlist(int [] a)
    {
        System.out.print("{");
        for (int x = 0; x < a.length; x++)
            System.out.print(a[x] + " ");
        System.out.println("}");
    }
}
