/**
 * Created by regan on 2016/08/30.
 */

public class Sorter implements Runnable
{
    int [] a;
    int begin,end;
    public Sorter(int [] a, int begin, int end)
    {
        this.a      = a;
        this.begin  = begin;
        this.end    = end;
    }

    public void run()
    {
        QuickSort.quickSort(a,begin,end);
    }
}
