#!/bin/bash
TIMEFORMAT='%R'
time clisp hello.lisp | grep [0-9]
