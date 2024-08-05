# Bridging the Technological Gap - R and RStudio

This repository contains the code for a 1.5 hour "hands on" session I taught at the 2024 "Briding the Technological Gap" workshop at MPI EVA.  If you attended the workshop, you'll know where to get the data files necessary to run all this code (they're not in this repository because they are gross binary Excel files).

## Overview

The repository contains 4 R scripts and one R Markdown documents:

### 0_convert_excel_to_csv.R

This script expects a file named `data.xlsx` to exist inside the `data/` directory.  You should save the file provided via the workshop's NextCloud share here.  All the script does is save the two worksheets of that excel file to separate `.csv` files, which are git-friendly text files that anybody can view and edit using free and open source standard tools.  I would argue that you shouldn't generally distribute this tiny little conversion script as part of your published repo.  You won't be putting the input files in the repo, so the repo's users won't be able to run it.  I've committed in this case for pedgagocial purposes.

Note that this is the only script which requires the `readxl` package.

### 1_process_data.R

This script reads the .csv files created by the previous script from the disk and then does some very light data processing, specifically it uses `left_join()` to combine data from the two sheets into a single tibble, suitable for feeding to something like a statistical model, and also does a quick sanity check that each participant ID only has a single set of age and gender values.  The resulting combined table is saved to `data/procesed_data.csv`.  I've chosen not commit this file to the repo, because the script to create it and the input files are already in there.

In general, this script is where you would do things like:

* transform units
* remove outliers
* check for coding errors

### 2_fit_model.R

This script reads the .csv file created by the previous script and fits a simple logistic regression model to it.  The fitted model object is then saved to disk as an `.rds` file.

This particular data analysis is kind of trivial.  Think of it is a placeholder for an analysis which might run for hours and/or might give you slightly different results each time due to e.g. MCMC sampling variation.  For that kind of analysis, you really want to be able to save a copy of the analysis results.

Our analysis here using the `glm()` function runs in base R.  In general, if you were using other tools (like `lme4`, `glmmTMB`, `brms`, `rstan`), this file would need to load them, while the previous two would not.

### 3_knit_report.R

This is a very short optional script.  It just "knits" the RMarkdown report file (described below) into a .pdf.  It's there to show how you can use RMarkdown without relying on RStudio!  But if you are happily using RStudio, there's not much utility to this, you can just use the "Knit" button.  This script does have *one* advantage which is that it makes it easier to also save a git-friendly `.knit.md` file with the same numbers as the PDF file.

### my_rmarkdown.Rmd

This is not a script, but an RMarkdown document.  It loads the raw data and the fitted model object and presents some figures and a plot which might be useful in a manuscript.  I improved this document a little bit since the session!  It now demonstrates the super handy `group_by()` and `summarise()` functions, and I made more extensive use of the ability to embed the results of computations in line in text, to summarise the participant data.

## Workflow

If you have the raw data files in place, you would run the scripts in the order indicated by their file names, 0, 1, 2 and (optionally) 3.

Every time your raw data changes, you need to run the whole set, 0, 1, 2, 3 again.

If your raw data stays the same but you change your mind about e.g. the outlier criteria used in script 1, then you just need to run scripts 1, 2, 3 again.

If your raw data and processing methods staty the same but you change your mind about how to analyse the data, then you just need to run scripts 2 and 3 again.

If your data and analysis stays the same but you are trying to decide how to report things in the manuscript, then you just need to run script 3 each time you change the `.Rmd` file.

###
