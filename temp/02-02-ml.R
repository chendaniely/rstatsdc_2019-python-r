# get the python data -----
library(reticulate)
reticulate::use_condaenv("miniconda3")

reticulate::py_config()

sklearn_datasets = reticulate::import_from_path("sklearn.datasets")
cancer = sklearn_datasets$load_breast_cancer()

library(tibble)
cancer_df <- tibble::as_tibble(cancer$data)
names(cancer_df) <- cancer$feature_names
cancer_df$target <- cancer$target
cancer_df

# prep data for modeling -----
library(rsample)
library(recipes)

cancer_split <- rsample::initial_split(cancer_df)
cancer_train <- rsample::training(cancer_split)
cancer_test <- rsample::testing(cancer_split)

res <- recipes::recipe(target ~ ., data = cancer_train) %>%
  recipes::step_scale(recipes::all_predictors()) %>%
  recipes::step_num2factor(recipes::all_predictors())

res_preped <- res %>% recipes::prep()

# model the data -----
library(parsnip)

svm <- res_preped %>%
  parsnip::svm_rbf(mode = "classification", cost = 1) %>%
  parsnip::set_engine("kernlab") %>%
  parsnip::fit(target ~ ., data = cancer_train)

library(yardstick)

yardstick::accuracy(cancer$data, cancer$target, predict(svm, cancer_test))
