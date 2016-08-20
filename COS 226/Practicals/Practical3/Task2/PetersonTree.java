import java.util.ArrayList;
import java.util.List;
import java.util.Stack;

public class PetersonTree
{
	Peterson root;
    int threadCount;
    List<Peterson> leaves;
    Stack<Peterson> lockStack;

	public PetersonTree(int threads)
	{
	    if ((threads & -threads) == threads)
        {
            leaves = new ArrayList<Peterson>(threads);
            threadCount = threads;
            PTConstruct();
            System.out.println(threadCount);
            System.out.println(leaves.size());
        }
        else
        {
            System.out.println(threads + " is not a power of 2.");
        }
    }
	
	public void PTreeLock()
    {
        Peterson node = getLeafForThread();
        while (node != null)
        {
            node.lock();
            lockStack.push(node);
            node = node.parent;
        }
    }
	
	public void PTreeUnlock()
    {
        unlock(getLeafForThread());
    }

    public void unlock (Peterson node)
    {
        while (!lockStack.empty())
        {
            lockStack.pop().unlock();
        }
    }

    public Peterson getLeafForThread()
    {
        return leaves.get(threadCount/2);
    }

    public void PTConstruct()
    {
        root = new Peterson(threadCount);
        makeLevel(root,1);
    }

    public void makeLevel(Peterson node, int existingLevels)
    {
        if (Math.pow(2,existingLevels-1) != threadCount)
        {
            node.left = new Peterson(threadCount);
            node.right = new Peterson(threadCount);
            makeLevel(node.left,existingLevels+1);
            makeLevel(node.right,existingLevels+1);
        }
        else
        {
            leaves.add(node);
        }
    }
}
