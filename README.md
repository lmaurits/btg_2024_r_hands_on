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

As your project progresses, you should find yourself running the earlier scripts in this workflow less and less frequently.  In the final stages, you'll just be knitting the report document repeatedly as you figure out which results of your analysis you want to present and how.  You won't need to re-run your analysis again if you restart your computer or RStudio, because the results are saved to your hard drive.  Knitting the report should be a pretty quick action, because all the hard number crunching was done earlier, and this allows you to iterate quickly as you e.g. tweak your plot axis label font size and all that annoying stuff that the default `ggplot` settings never get right...

## Principles

Some of the principles these scripts try to embody are:

* Don't expose the layout of your personal filesystem by using absolute paths (e.g. paths beginning with `/` or `C:\`) in your code.  Always use relative paths.  Don't use `setwd()` in a script.
* Don't store binary files (Excel spreadsheets, `.rds` saved R objects, `.png` images, `.pdf` documents) in git repositories - they make the repository large (and therefore slow to download) and git cannot generate meaningful diffs between different versions, so you can't see what changed and when.  Your commits are totally opaque (so if you really insist on putting these files in there, use extremely good descriptive commit messages when you change them!).
* Save intermediate results to the hard drive, with either `write_csv()` or `write_rds()` so that you don't need to re-run everything from the beginning when you restart your computer or your RStudio session.  This is also handy for working with collaborators.  When you send them your script(s), send them the intermediate files too (you shouldn't push binary `.rds` files to a git repo but it's fine to share them via Dropbox/Nextcloud/whatever), then they can also avoid having to re-run the early stuff (although sometimes it's handy if they do, as an easy way to double check that the code does in fact run on a different computer).  Avoid using `save()` and `load()`, it's impossible to predict the consequences of codee that uses `load()` and it's totally opaque which variables get changed.
* Break your code up into multiple scripts.  This makes it easy to only run the bits you need to when you don't need to run the entire pipeline form scratch.  Yes, you can always highlight separate parts of one long script in RStudio and run them, or run individual chunks in an RMarkdown / RNotebook.  This is fine when you are quickly laying the foundations for a project, but it's dangerous to rely on it too heavily.  You might end up writing code which only works correctly when somebody who understands it well highlights all the right parts and runs them in the right order in a single interactive session (e.g. you might accidentally modify earlier code to make reference to a variable defined for the first time in later code, not realising the problem at the time because you only interactively ran the modified early code with an environment already populated by the later code).  Third parties won't be able to use your code, and *you* might not be able to use it months later when your deep familiarity has worn off but you need to change something in response to reviewer comments.  Breaking your code into chunks also makes it easier for different team members to work on different parts of a project in parallel! 
* By all means use RMarkdown, but don't put heavy computational stuff that takes a long time to run into RMarkdown documents.  It will drive you nuts having to wait for that code to be re-run everytime you want to knit a fresh copy of your document because you made some tiny change to a table caption.  Yes, you *could* use an R Notebook instead where you can run separate chunks.  This ties your work more closely to RStudio, and e.g. compared to a simple R script makes it a lot trickier to run your code on a remote high performance machine.
