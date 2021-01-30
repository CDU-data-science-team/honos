## code to prepare `DATASET` dataset goes here

usethis::use_data(DATASET, overwrite = TRUE)

library(tidyverse)

questionnaire_values <- c(0:4)
questionnaire_n_items <- 12
values_probablilities <- runif(n = length(questionnaire_values), min = 0, max = 1)

n_ids <- 1000
id_vector <- paste0("id", 1:n_ids)

timepoints <- 5

values <- list()

for (id_time in seq_along(rep(id_vector, timepoints))) {

  values_probablilities <- runif(n = length(questionnaire_values), min = 0, max = 1)

      values[[id_time]] <- sample(x = questionnaire_values,
                             size = 12,
                             prob = values_probablilities,
                             replace = TRUE)

}

honos_data <- tibble::tibble(id = rep(id_vector, each = questionnaire_n_items * timepoints),
                             time = factor(rep(rep(paste0("time_", 1:timepoints), each = questionnaire_n_items), times = n_ids)),
                             measure = "honos",
                             item = factor(rep(c(1:questionnaire_n_items), times = n_ids * timepoints)),
                             value = unlist(values))


honos_data %>%
  pivot_wider(names_from = item,  names_prefix = "honos_i", values_from = value)

