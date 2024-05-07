#!/bin/bash

count=`aws s3api list-buckets --query Buckets[].Name | jq 'length' `

for ((i=0; i<${count}; i++)) do
  BUCKET_NAME[i]=`aws s3api list-buckets --query Buckets[].Name | jq -r .[$i]`
  echo ${BUCKET_NAME[$i]}
done

for ((i=0; i<${count}; i++)) do
  aws s3 rm s3://${BUCKET_NAME[$i]} --recursive
  aws s3 rb s3://${BUCKET_NAME[$i]}
done
