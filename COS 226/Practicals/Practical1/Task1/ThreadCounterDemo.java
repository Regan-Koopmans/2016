//Practical assignment 1
//Two threads can access a shared Counter

class ThreadCounterDemo {
	
	public static void main (String args[]) {
		
		Counter C = new Counter(1);
		TThread t1 = new TThread(C);
		t1.start();
		
		TThread t2 = new TThread(C);
		t2.start();
	}
}