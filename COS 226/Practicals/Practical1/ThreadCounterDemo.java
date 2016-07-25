//Practical assignment 1
//Two threads can access a shared Counter

class ThreadCounterDemo {
	
	public static void main (String args[]) {
		
		Counter C = new Counter(1);
		TThread t1 = new TThread();
		t1.start();
		
		TThread t2 = new TThread();
		t2.start();
	}
}