while read line; do
    arr=($line); idx=${arr[0]};
    echo "r$idx $idx.$idx.$idx.$idx"
done
