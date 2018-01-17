for s in $@; do
    if [ -z "$net" ]; then
        net=$1
        pref=10.0.$1
        str=
    else
        str="$str r$s:eth$net@$pref.$s/24"
    fi
done
echo $str
