//Practical assignment 1
//Shared counter object

import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

class Counter {

	int value;
	Lock myLock = new ReentrantLock();

	Counter(int c) {
		value = c;
	}

	int getAndIncrement() {
		myLock.lock();
		try
		{
			return value++;
		}
		finally {myLock.unlock();}

	}
}
