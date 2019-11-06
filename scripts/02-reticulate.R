library(reticulate)
library(here)

(conda_envs <- reticulate::conda_list())
conda_envs$name[[1]]
env <- conda_envs$name[[1]]
env

reticulate::use_condaenv(env)

# reticulate::use_python("~/miniconda3/bin/python")

# reticulate::repl_python()

reticulate::source_python(here::here("./temp/01-02-python.py"))

df
df

library(here)
here
here::here

pd <- reticulate::import("pandas")

pd$Series$plot(reticulate::r_to_py(mean_rank_by_week))
