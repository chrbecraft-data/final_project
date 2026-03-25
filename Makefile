report.html: code/03_render_report.R final_project_becraft.rmd data_clean.rds output/table1.rds output/figure.rds 
	RScript code/03_render_report.R

data_clean.rds: code/00_clean_data.R drug_consumption.data
	RScript code/00_clean_data.R 

output/table1.rds: code/01_make_table1.R output/data_clean.rds
	RScript code/01_make_table1.R

output/figure.rds: code/02_make_figure.R output/data_clean.rds
	RScript code/02_make_figure.R

.PHONY: clean
clean:
	rm output/*.rds && rm *.html