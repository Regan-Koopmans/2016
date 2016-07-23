#!/bin/bash
var=$(./getTime.sh 2>&1)
string="$var"
for i in {1..999}
  do
    var=$(./getTime.sh 2>&1)
    string="$string + $var"
done
echo $(python -c "print ($string)/1000")
