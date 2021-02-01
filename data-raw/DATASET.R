## code to prepare `DATASET` dataset goes here


library(tidyverse)
library(lubridate)

questionnaire_values <- c(0:4)
questionnaire_n_items <- 13
values_probablilities <- runif(n = length(questionnaire_values), min = 0, max = 1)

n_ids <- 1000
id_vector <- paste0("id", 1:n_ids)

timepoints <- 3

# Simulate values here
values <- list()

for (id_time in seq_along(rep(id_vector, timepoints))) {

  values_probablilities <- runif(n = length(questionnaire_values), min = 0, max = 1)

      values[[id_time]] <- sample(x = questionnaire_values,
                             size = questionnaire_n_items,
                             prob = values_probablilities,
                             replace = TRUE)

}


# Simulate all other data here and create dataframe
honos_data_sim <- tibble::tibble(id = factor(rep(id_vector, each = questionnaire_n_items * timepoints), levels = id_vector),
                             # time = factor(rep(rep(paste0("time_", 1:timepoints), each = questionnaire_n_items), times = n_ids)),
                             date = rep(sample(seq(as_date('2000/01/01'), as_date('2021/01/01'), by = "day"), replace = FALSE, size =  timepoints * n_ids), each = questionnaire_n_items),
                             measure = "honos",
                             item = factor(rep(c(1:questionnaire_n_items), times = n_ids * timepoints)),
                             value = as.numeric(unlist(values))) %>%
  arrange(id, desc(date))

# Add some missing values here 5%
honos_long <- honos_data_sim %>%
  mutate(
    random_num = runif(nrow(.)),
    value = case_when(random_num <= 0.95 ~ value,
                      random_num > 0.95 ~ NA_real_)
    ) %>%
  select(-random_num)

# Option to return wide instead of long data
honos_wide <- honos_long %>%
  pivot_wider(id_cols = c("id", "date", "measure"),
              names_from = item,
              names_prefix = "honos_i",
              values_from = value)

usethis::use_data(honos_wide, overwrite = TRUE)
usethis::use_data(honos_long, overwrite = TRUE)
