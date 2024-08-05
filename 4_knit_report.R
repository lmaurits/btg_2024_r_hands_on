library(rmarkdown)

# This line will "knit" the .Rmd file into a .pdf, so you can create the PDF
# by just running this script with `Rscript`, without to use RStudio.  The
# result is the same, this is just easier to automate or to run remotely.
# The `clean=FALSE` argument tells the `render()` function not to clean up 
# after itself.  This helpfully produces a git-friendly text file with the
# results of the knitting!
rmarkdown::render("my_rmarkdown.Rmd", "pdf_document", clean=FALSE)
