#!/bin/bash

mbids=`cat $1 | jq '.[].track_metadata.mbid_mapping.recording_mbid' | sed -e 's/"//g'`

len=$((`echo -e ${mbids} | wc -w`))

test_len=$(expr $((len)) / 10)
valid_len=$((test_len))
train_len=$(expr $((len)) - $((test_len)) - $((valid_len)))

i=0

while read  mbid
do
    if [[ $((i)) -lt $((train_len)) ]]; then 
        echo -ne "${mbid} " >> train.txt


        if [[ $(($i%20)) -eq 0 ]]; then 
            echo  >> train.txt
        fi
    fi    

    if [[ $((i)) -ge $((train_len))  && $i -lt $(expr $((train_len)) + $((test_len))) ]]; then
        echo -ne "${mbid} " >> test.txt
        if [[ $(($i%20)) -eq 0 ]]; then 
            echo >> test.txt
        fi

    fi

    if [[ $((i)) -ge $(expr $((train_len))+$((test_len))) &&  $((i)) -lt $((len)) ]]; then
        echo -ne "${mbid} " >> valid.txt
        if [[ $(($i%20)) -eq 0 ]]; then 
            echo  >> valid.txt
        fi
    fi
    
    i=$((i+1))
done <<< "${mbids}"

sed -i 's/null //g' train.txt
sed -i 's/null //g' test.txt
sed -i 's/null //g' valid.txt

fairseq-preprocess \
    --only-source \
    --trainpref train.txt \
    --validpref valid.txt \
    --testpref test.txt \
    --destdir data-bin/brainz \
    --workers 20
