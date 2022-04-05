#!/bin/bash

echo "yaya"

poulet="cotcot"
export $poulet

bash needParam.sh<needParamcall.sh

echo $poulet>>sortie.txt