<!-- $theme: gaia
template:gaia-->

COS 222 : Operating Systems
===

---

<!-- template: default -->

## What Is an Operating System?

An operating system is a program/software that controls the execution of **application programs** and acts as an **interface** between applications and hardware. It has the following broad objectives:

- <span style="color:cadetblue">**Convenience**
- <span style="color:cadetblue">**Efficiency**
- <span style="color:cadetblue">**Flexibility**

---

### Why are Operating Systems Useful?

Operating Systems provide the following:

- Program Development
- Program Execution
- Access to I/O devices
- Controlled Access To Files
- System Acces
- Error detection and rectification...and many more

---

# I/O

There are three broad ways that the CPU can perform IO:

- Programmed I/O
- Interrupt-driven I/O
- Direct Memory Access

---


# Direct Memory Access

Direct Memory Access (DMA) is a technology that allows transfers between I/O modules and main memory to occur without the intervention of the CPU.

This would be handled by the **DMA module** on the CPU or on the IO module.

This dramatically increases performance because managing data transfers is **not an efficient use of the CPU's time**.

---

# Interrupts

- This is a mechanism by which **hardware or software** my halt the typical CPU cycle to **demand attention**.

---

## Interrupt Handlers

An interrupt handler, or an Interrupt Service Soutine (ISR), is a **callback function**  in micro-controller firmware, operating system or device driver, where execution i triggered or **invoked by an interrupt**.

---

# Processes

A process is an entity that consists of a number of elements, two of the most essential being **program code**  and a set of **associated data**.

---

### Process Control Block

The Process Control Block (PCB) is a data structure that contains all the relevant information pertaining to a single process present in the system.

---

<div align="center">

| Process Control Block |
|        ---            | 
|     Identifier        |
|       State           |
|      Priority         |
|   Program Counter     |
|   Memory Pointers     |
|    Context Data       |
|   IO Status Info      | 
|   Accouting Info      |
|        ...            | 
</div>


---

# Threads

A thread (or *lightweight process*)

Similarly to a process, a thread also has a **Thread Control Block** (TCB)

---

# Chapter 5 : Concurrency
##### Mutual Exclusion and Synchronisation

---
 
# Manifestations of Concurrency

Concurrency  arises in three broad contexts.

- **Multiple appications** - Juggling many programs
- **Structured Applications** - Program using threads
- **Operating System Structure**

---

# Semaphore

This is a variable that has an integer value upon which only three operations are defined:

- May be **initialized** to a non-negative integer value.
- The **semWait** operation **decrements** the value.
- The **semSignal** operation **increments** the value.

---

# Monitors

These are programming constructs that provide similar functionality to a semaphore but are easier to control.

