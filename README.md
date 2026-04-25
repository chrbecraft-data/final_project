# Contents of Repository
This repository includes:
- The raw data in a .data file
- A code folder containing 4 files that clean the data, make a table one, generate confusion matrix figure, and render the report
- An output folder that stores the cleaned data, table one, and figure objects
- A Makefile that builds the report
- A markdown file to generate the report
- renv lockfile
- Dockerfile to build image to compile report in container

# How to generate final report
- Synchronize package library (see instructions below)
- Run make command
- Report contains an introduction to the data background, and descriptions of the table and figure

# How to synchronize package library
- Navigate to project directory
- Run make install

# How to build Docker image
- Run docker pull chrbecraft/final-project

# How to generate report with Docker 
- Once in Docker container, run make
