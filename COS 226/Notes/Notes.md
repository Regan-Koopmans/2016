<!-- $theme: gaia 
template:gaia-->

COS 226 : Concurrent Systems
===
---

<!-- $theme: gaia
template : normal -->
# Properties of Concurrent Systems

- <span style=color:cadetblue>**Liveness**</span> - Some property of the system that ensures that something good will happen (eventually).
- <span style=color:cadetblue>**Safety**</span> - Some property of the system that ensures that something bad will *not* happen

---
	
# Mutual Exclusion

This is the concept that no two threads may **not be executing their critical sections at any given instance**. 

If this property is not held up in certain places, it is cause for irregularity and and poor program control.



---

# Starvation

This is a term given to the situation where a **subset of the running threads** are **prevented from receiving processor time**, because another subset of threads is repeatedly occupying the processor.

Starvation is a negative property because it means that the program is not running optimally concurrently &rarr; tending towards sequentialism.

In this situation, only a select few of the threads *make progress*.

---

# Deadlock

This is the name given to the situation where **all threads are waiting on other threads** before they execute. Hence all the threads are waiting for a condition that cannot be met.

This is a negative property because it means that the program has prematurely halted. If a program has deadlock, it effictively means that the program is not logically or structurally sound.

In this case **no threads make any progress**.

---

# The Producer-Consumer Problem

This is a problem that arises when we have two threads that are **mutually depended on the actions of the other** to run.

> We do not want the Producer to produce when the buffer is full.

> We do not want the Consumer to consume when the buffer is empty.

---

# The Readers-Writers Problem

This is a problem where we have some shared memory that allows communication between two or more threads. 

It is possibe that one thread may read from the shared memory as it is being modified by another thread. 

This is likely to cause miscommunication and unanticipated consequences of the system.

---

# Amdahl's Law

Amdahl's Law is a mathematical equation that approximates the speedup of concurrent programs.

Based on the level **parallism** and **number of processors**.

It is unlikely that we can receive more than a 7 times performance increase from making some program concurrent*.

<div align="right">
<sub><sup>*With reasonable exceptions.</sup></sub>
</div>

---


# Locks 

A lock (or 'mutex') is a synchronisation mechanism for enforcing limits  on access to a resource, in an enironment where there are many threads of execution. A good lock:

- <span style="color:cadetblue">**Enforce mutual exclusion**.
- <span style="color:cadetblue">**Deadlock-free**.
- <span style="color:cadetblue">**Starvation-free**.

---

# LockOne

- Thread demonstrates interest in acquiring lock.
- Checks to see if other thread is currently in critical section
	- waits if true, executes if false.

LockOne works sequentially, **not concurrently**.  Since reading and writing to variables simultaniously will cause miscommunication and break mutual exclusion.

Is not deadlock-free.

---

# LockTwo

- When attempting to acquire lock, offer to be **victim**. 
- Wait until you are not the victim and then execute your critical section.

LockTwo works concurrently, **not sequentially**. This is because a thread always needs to be taken out 

LockTwo is also not deadlock-free.

---

# Peterson Lock


The Peterson Lock is a combination of LockOne and LockTwo.

- Current thread indicates interest in acquiring lock.
- Current thread offers to be the victim.

The Peterson Lock is both **deadlock-free** and **starvation-free**. The Peterson Lock **only works for two threads**.

---

## Filter Lock

We have n-1 levels that threads need to traverse before they can be processed. This creates an **implicit ordering** of the threads. A thread will check:

- <span style="color:cadetblue">**Am I the victim?**
- <span style="color:cadetblue">**Is there currently some thread that is on a level greater than or equal to my own?**

If these two conditions are true, then the thread will wait, otherwise the thread is allowed to move up by one level.

---

## Filter Lock is unloved.... :(

Filter Lock is unpopular because:

- It is "unfair".
- It is uneconomical with resources &rarr; fixed number of traversals.
- Number of threads are static (in standard implementations).

---

## Lamport's Bakery Algorithm

This lock is based on the concept of taking a ticket in a shop. You will:
- Receive a number, greater than all numbers previous. 
- Wait until all numbers lower than you have been called.
- Get processed by the shop owner.

---

<!-- template:invert -->
# *But wait!!!*

It is very possible that we will have the case where two or more threads receive the **same number**.

In this situation we would use the thread id to get the relative positions of threads (greater id's waiter for smaller id's).

**This means it is effectively "elders first"**.

---
<!-- template:default -->
## The Bakery Has A Problem...

Unfortunately, the counter of the Bakery algorithm is perpertually increases and thus, at some point much later in the future, it must invariably overflow...

...and then the entire algorithm collapses.


---

# Bounded Timestamps


---