while read line; do
    arr=($line); net=${arr[0]}; i1=${arr[1]}; i2=${arr[2]}
    echo "r$i1:eth$i2@10.0.$net.$i1/24 r$i2:eth$i1@10.0.$net.$i2/24"
done
