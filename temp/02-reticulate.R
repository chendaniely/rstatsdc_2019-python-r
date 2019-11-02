library(reticulate)

reticulate::conda_list()
reticulate::use_condaenv("miniconda3")

# reticulate::use_python("~/miniconda3/bin/python")

# reticulate::repl_python()

reticulate::source_python("01-02-python.py")

df
df

library(here)
here
here::here

pd <- reticulate::import("pandas")

pd$Series$plot(reticulate::r_to_py(mean_rank_by_week))
