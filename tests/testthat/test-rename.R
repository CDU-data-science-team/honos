# Return rows
# Column headers should match expected output
# With SQL header names v R tidy

# Data is returned----

load("data/honos_data.rda")

testthat::test_that("Check data is returned by row count for a SQL connection", {

  df <- honos_data %>%
    rename_honos(
      data = honos::honos_data,
      value_vars_current = c(
        "q1", "q2", "q3", "q4", "q5", "q6", "q7",
        "q8", "q9", "q10", "q11", "q12", "q13"
      ),
      prob_var_item8 = c("q8_prob"),
      spec_var_item8 = c("q8_spec"),
      value_vars_history = c("qa", "qb", "qc", "qd", "qe")
    ) %>%
    dplyr::count() %>%
    dplyr::collect()

  testthat::expect_gt(
    df$n, 0
  )
})


testthat::test_that("Check data is returned by row count for a data frame", {

  df <- rename_honos(
    data = honos::honos_data,
    value_vars_current = c(
      "q1", "q2", "q3", "q4", "q5", "q6", "q7",
      "q8", "q9", "q10", "q11", "q12", "q13"
    ),
    prob_var_item8 = c("q8_prob"),
    spec_var_item8 = c("q8_spec"),
    value_vars_history = c("qa", "qb", "qc", "qd", "qe")
  )  %>%
    dplyr::count() %>%
    dplyr::collect()

  testthat::expect_gt(
    df$n, 0
  )
})

# Column name checks----


testthat::test_that("Check for column names expected", {
  col_names <- c("honos_i1_value",
                 "honos_i2_value",
                 "honos_i8_prob",
                 "honos_i8_spec",
                 "honos_i9_value",
                 "honos_i18_value"
  )

  df <- rename_honos(
    data = honos::honos_data,
    value_vars_current = c(
      "q1", "q2", "q3", "q4", "q5", "q6", "q7",
      "q8", "q9", "q10", "q11", "q12", "q13"
    ),
    prob_var_item8 = c("q8_prob"),
    spec_var_item8 = c("q8_spec"),
    value_vars_history = c("qa", "qb", "qc", "qd", "qe")
  )  %>%
    dplyr::select(5, 6, 13, 14, 15, 24
    ) %>%
    dplyr::collect()

  testthat::expect_named(
    df, col_names,
    ignore.order = TRUE, ignore.case = FALSE
  )
})


