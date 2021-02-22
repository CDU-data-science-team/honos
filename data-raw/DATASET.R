## code to prepare `DATASET` dataset goes here


library(tidyverse)
library(lubridate)

# questionnaire_values <- c(0:4)
# questionnaire_n_items <- 18
# values_probablilities <- runif(n = length(questionnaire_values), min = 0, max = 1)
#
# n_ids <- 1000
# id_vector <- paste0("id", 1:n_ids)
#
# timepoints <- 3
#
# # Simulate values here
# values <- list()
#
# for (id_time in seq_along(rep(id_vector, timepoints))) {
#
#   values_probablilities <- runif(n = length(questionnaire_values), min = 0, max = 1)
#
#       values[[id_time]] <- sample(x = questionnaire_values,
#                              size = questionnaire_n_items,
#                              prob = values_probablilities,
#                              replace = TRUE)
#
# }
#
# values_i8 <- list()
#
# for (id_time in seq_along(rep(id_vector, timepoints))) {
#
#   values_probablilities <- runif(n = length(c("A", "B", "C", "D", "E", "F", "G", "H", "I", "J")), min = 0, max = 1)
#
#   values_i8[[id_time]] <- sample(x = c("A", "B", "C", "D", "E", "F", "G", "H", "I", "J"),
#                                  size = 1,
#                                  prob = values_probablilities,
#                                  replace = TRUE)
#
# }
#
#
# # Simulate all other data here and create dataframe
# honos_data_sim <- tibble::tibble(id = factor(rep(id_vector, each = questionnaire_n_items * timepoints), levels = id_vector),
#                                  # time = factor(rep(rep(paste0("time_", 1:timepoints), each = questionnaire_n_items), times = n_ids)),
#                                  date = rep(sample(seq(as_date('2000/01/01'), as_date('2021/01/01'), by = "day"), replace = FALSE, size =  timepoints * n_ids), each = questionnaire_n_items),
#                                  measure = "honos",
#                                  item = factor(rep(c(1:questionnaire_n_items), times = n_ids * timepoints)),
#                                  type = "score",
#                                  value = unlist(values)) %>%
#   arrange(id, desc(date))
#
#
# # Simulate all other data here and create dataframe
# honos_data_sim <- tibble::tibble(id = factor(rep(id_vector, each = 1 * timepoints), levels = id_vector),
#                                  # time = factor(rep(rep(paste0("time_", 1:timepoints), each = questionnaire_n_items), times = n_ids)),
#                                  date = rep(sample(seq(as_date('2000/01/01'), as_date('2021/01/01'), by = "day"), replace = FALSE, size =  timepoints * n_ids), each = questionnaire_n_items),
#                                  measure = "honos",
#                                  item = factor(rep(c(1:1), times = n_ids * timepoints)),
#                                  type = "value",
#                                  value = unlist(values_i8)) %>%
#   arrange(id, desc(date))
#
# # Add some missing values here 5%
# honos_long <- honos_data_sim %>%
#   mutate(
#     random_num = runif(nrow(.)),
#     value = case_when(random_num <= 0.95 ~ value,
#                       random_num > 0.95 ~ NA_real_)
#     ) %>%
#   select(-random_num)



honos_data <- tribble(~id,        ~date, ~measure,   ~team,  ~stage, ~q1, ~q2, ~q3, ~q4, ~q5, ~q6, ~q7, ~q8, ~q8_prob, ~q8_spec, ~q9, ~q10, ~q11, ~q12, ~q13, ~qa, ~qb, ~qc, ~qd, ~qe,
                      "id1", "2020-01-01",  "honos", "team1", "pre",   3,   3,   3,   2,   0,   0,   1,   2,    "A",       NA,   3,    4,    2,    4,    4,   1,   2,    1,  2,   2,
                      "id1", "2020-02-11",  "honos", "team1", "pre",   3,   4,   3,   0,   1,   1,   1,   4,    "A",       NA,   2,    1,    1,    1,    1,   1,   1,    1,  1,   3,
                      "id1", "2020-03-04",  "honos", "team2", "pre",   2,   0,   2,   1,   3,   3,   2,   2,    "A",       NA,   0,    3,    1,    1,    2,   0,   1,    1,  1,   2,
                      "id1", "2020-04-20",  "honos", "team2", "pre",   1,   2,   4,   2,   2,   4,   3,   4,    "A",       NA,   2,    3,    3,    0,    0,   1,   2,    2,  2,   1,
                      "id2", "2020-01-14",  "honos", "team1", "pre",   0,   0,   2,   4,   1,   0,   2,   2,    "B",       NA,   4,    1,    1,    1,    1,   3,   1,    1,  1,   1,
                      "id2", "2020-02-22",  "honos", "team2", "pre",   1,   1,   1,   2,   4,   1,   4,   1,    "B",       NA,   2,    1,    1,    0,    2,   4,   2,    2,  1,   0,
                      "id3", "2019-05-19",  "honos", "team1", "pre",   2,   2,   0,   4,   4,   0,   2,   4,    "J",    "aaa",   1,    2,    2,    2,    2,   2,   2,    4,  1,   1,
                      "id4", "2020-11-08",  "honos", "team1", "pre",   3,   0,   1,   2,   2,   0,   0,   2,    "E",       NA,   4,    4,    1,    4,    2,   1,   4,    2,  1,   1,
                      "id4", "2021-01-04",  "honos", "team2", "pre",   4,   1,   0,   0,   2,   1,   1,   2,    "D",       NA,   2,    4,    2,    1,    4,   2,   3,    1,  1,   3,
                      "id4", "2021-01-15",  "honos", "team2", "pre",   0,   2,   2,   1,   0,   3,   2,   4,    "J",   "lala",   1,    1,    1,    1,    1,   1,   1,    2,  1,   2,
                      "id4", "2021-02-14",  "honos", "team1", "pre",   3,   5,   1,   2,   4,   1,   3,   4,    "J",   "lulu",   0,    2,    2,    0,    3,   1,   0,    3,  1,   2,
                      "id4", "2020-02-17",  "honos", "team1", "pre",   2,   4,   3,   4,   2,   2,   2,   2,    "J",    "bbb",   0,    0,    0,    3,    0,   2,   1,    0,  1,   1,
                      "id4", "2020-02-18",  "honos", "team2", "pre",   1,   3,   2,   2,   0,   2,   3,   1,    "F",       NA,   1,    3,    1,    3,    3,   2,   2,    1,  0,   1,
                      "id5", "2020-01-01",  "honos", "team1", "pre",   0,   3,   4,   3,   1,   4,   2,   1,    "G",       NA,   2,    4,    4,    4,    4,   0,   0,    0,  0,   0,
                      "id5", "2020-02-13",  "honos", "team2", "pre",   1,   1,   0,   2,   0,   2,   1,   2,    "H",       NA,   1,    2,    1,    3,    3,   0,   0,    0,  0,   0,
                      "id5", "2020-03-21",  "honos", "team3", "pre",   2,   2,   2,   0,   3,   3,   4,   1,    "I",       NA,   4,    1,    2,    1,    3,   0,   0,    0,  0,   0,
                      "id5", "2020-04-08",  "honos", "team2", "pre",   3,   2,   2,   2,   2,   0,   2,   1,    "C",       NA,   1,    3,    1,    0,    1,   0,   0,    0,  0,   0,
                      "id5", "2020-05-02",  "honos", "team1", "pre",   0,   0,   0,   1,   0,   0,   0,   1,    "C",       NA,   0,    0,    2,    0,    0,   0,   0,    0,  0,   0
  ) %>%
  mutate(date = as.Date(date))

usethis::use_data(honos_data, overwrite = TRUE)
# usethis::use_data(honos_long, overwrite = TRUE)


