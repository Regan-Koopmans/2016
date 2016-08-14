//implement the filter lock here

import java.util.concurrent.locks.Lock;
import java.lang.Thread;

public class Filter
{
	int level[];
	int victim[];
	public Filter(int n)
	{
		level 	= new int[n];
		victim 	= new int[n];
		for (int x = 0; x < n; x++)
		{
			level[x] = 0;
		}
	}

	public void lock()
	{
		// Derives a unique number based on the thread name, since ThreadID is not
		// consistent with the number of user threads (java spawns its own).

		int i = Integer.parseInt(Thread.currentThread().getName().substring(Thread.currentThread().getName().indexOf('-')+1));
		boolean someKExists = true;
		for (int x = 1; x < level.length; x++)
		{
			level[i] = x;
			victim[x] = i;
			while (someYExists(i)){}
		}
	}

	// Function checks whether there exists some y on a greater than or equal
	// level than i (the curret thread)

	public Boolean someYExists(int i)
	{
		for (int y = 0; y < level.length; y++)
		{
			if ((y != i && level[y] >= level[i] && victim[level[i]] == i))
				return true;
		}
		return false;
	}

	public void unlock()
	{
		int i = Integer.parseInt(Thread.currentThread().getName().substring(Thread.currentThread().getName().indexOf('-')+1));
		level[i] = 0;
	}
}
