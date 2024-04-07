#!/bin/bash

while getopts 'h:' OPTION; do
  case "$OPTION" in
    h)
      echo "Это программа считает дискриминант из переменных A, B, C и по нему говорит, сколько корней в уравнении"
      ;;
    ?)
      echo "Использование скрипта: $(basename \$0) [-h]" >&2
      exit 1
      ;;
  esac
done
shift "$(($OPTIND -1))"

a=$A
b=$B
c=$C

re='^[-]?[0-9]+$'

if [[ -z "$a" ]] || [[ -z "$b" ]] || [[ -z "$c" ]] ; then
    echo "Не все переменные окружения заданы" >&2
    exit 1
fi

if ! ([[ $a =~ $re ]] && [[ $b =~ $re ]] && [[ $c =~ $re ]]) ; then
    echo "A, B и C должны быть целыми числами" >&2
    exit 1
fi

((discriminant=$b*$b-4*$a*$c))

if [[ $discriminant > 0 ]] ; then
    echo "Уравнение имеет 2 корня" | cat > out.txt
elif [[ $discriminant == 0 ]] ; then
    echo "Уравнение имеет один корень" | cat > out.txt
else
    echo "Уравнение не имеет дейсвительных корней" | cat > out.txt
fi