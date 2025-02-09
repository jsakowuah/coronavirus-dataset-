#!/bin/bash

echo "Updating the total dataset"

quarto render ./data_pipelines/covid19_cases.qmd --to html
quarto render ./data_pipelines/vaccine_data.qmd --to html
cp ./data_pipelines/covid19_cases.html ./docs/data_pipelines/
cp ./data_pipelines/vaccine_data.html ./docs/data_pipelines/

rm -rf ./docs/data_pipelines/covid19_cases_files/
cp -R ./data_pipelines/covid19_cases_files/ ./docs/data_pipelines/covid19_cases_files/

rm -rf ./docs/data_pipelines/vaccine_data_files/
cp -R ./data_pipelines/vaccine_data_files/ ./docs/data_pipelines/vaccine_data_files


if [[ "$(git status --porcelain)" != "" ]]; then
    git config --global user.name 'RamiKrispin'
    git config --global user.email 'ramkrisp@umich.edu'
    git add csv/*.csv
    git add data/*.rda
    git add data_pipelines/*.*
    git add docs/data_pipelines/*.html
    git commit -m "Auto update coronavirus data"
    git push
fi
