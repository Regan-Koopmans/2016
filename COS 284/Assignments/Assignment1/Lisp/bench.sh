#!/bin/bash
for i in {1..100}
do
  echo $(perf stat -r 1000 clisp hello.lisp 2>&1 >/dev/null | tail -n 2 | sed 's/ \+//' | sed 's/ /,/' | sed 's/[^0-9.]//g')
done
