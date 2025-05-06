#!/bin/bash

#
# The following is written in the Dutch language, but rougly translates to:
# Land = Country
# Provincie = Province/State
# Stad/Dorp = City or Town
# Bedrijf = Company
# Afdeling = Department
# CN Domeinnaam = Common Name (Domain Name)
#

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

sub_comp="${comp// /_}"
sub_comp="${sub_comp,,}"
if [[ ! -d ./${sub_comp} ]]; then
    mkdir ./"${sub_comp}" 
fi

if [[ ! -d ./${sub_comp}/${curr_year} ]]; then
    mkdir ./"${sub_comp}"/"${curr_year}"
fi

openssl req -new -newkey \
    rsa:4096 -nodes -keyout \
    ./"${sub_comp}"/"${curr_year}"/"${name}"_"${curr_year}".key -out \
    ./"${sub_comp}"/"${curr_year}"/"${name}"_"${curr_year}".csr \
    -subj "/C=${land}/ST=${prov}/L=${city}/O=${comp}/OU=${orgu}/CN=${raw_name}"