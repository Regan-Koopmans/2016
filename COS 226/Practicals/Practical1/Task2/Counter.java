//Practical assignment 1
//Shared counter object

class Counter {

	int value;

	Counter(int c) {
		value = c;
	}

	synchronized int getAndIncrement() {
		return value++;
	}
}
