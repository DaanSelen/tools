#!/bin/bash

printf "Land (NL): "
read -r land

printf "Provincie: "
read -r prov

printf "Stad/dorp: "
read -r city

printf "Bedrijf: "
read -r comp

printf "Afdeling (optional): "
read -r orgu

printf "CN (domeinnaam): "
read -r raw_name
name="${raw_name//\*/wildcard}"

curr_year=$(date +%Y)

openssl req -new -newkey \
    rsa:4096 -nodes -keyout \
    ${name}_${curr_year}.key -out \
    ${name}_${curr_year}.csr \
    -subj "/C=${land}/ST=${prov}/L=${city}/O=${comp}/OU=${orgu}/CN=${raw_name}"
