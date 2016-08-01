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
		int i = Math.round(Thread.currentThread().getId()) - 9;
		boolean someKExists = true;
		for (int x = 1; x < level.length; x++)
		{
			level[i] = x;
			victim[x] = i;
			while (someYExists(i)){}
		}
	}

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
		int i = Math.round(Thread.currentThread().getId())-9;
		level[i] = 0;
	}
}
