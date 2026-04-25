FROM rocker/tidyverse

RUN mkdir /project
WORKDIR /project
RUN mkdir code
RUN mkdir output

COPY code code
COPY drug_consumption.data .
COPY Makefile .
COPY final_project_becraft.rmd .

COPY .Rprofile .
COPY renv.lock .
RUN mkdir renv
COPY renv/activate.R renv
COPY renv/settings.json renv

RUN Rscript -e "renv::restore(prompt = FALSE)"

RUN mkdir report

CMD make && mv final_project_becraft.html report