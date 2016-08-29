/**
 * Created by regan on 2016/08/29.
 */
public class QuickTester
{
    public static void main(String [] args)
    {
        int [] list = {5,4,3,2,1,90,10};
        QuickSort.quickSort(list);

        for (int x = 0; x < list.length; x++)
            System.out.println(list[x]);
    }
}
