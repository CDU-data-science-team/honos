# Return rows
# Column headers should match expected output
# With SQL header names v R tidy

# Data is returned----

testthat::test_that("Check data is returned by row count for a SQL connection", {

  df <- nottshcData::get_rio_honos(return = "tbl_sql") %>%
    nottshcData::tidy_rio_honos() %>%
    honos::rename_honos(
      data = data,
      value_vars_current = c(
        "Q1", "Q2", "Q3",
        "Q4", "Q5", "Q6",
        "Q7", "Q8Score",
        "Q9", "Q10", "Q11",
        "Q12", "Q13"
      ),
      prob_var_item8 = "Q8Problem",
      spec_var_item8 = "Q8JSpec",
      value_vars_history = c("QA", "QB", "QC",
                             "QD", "QE")) %>%
    dplyr::count() %>%
    dplyr::collect()

  testthat::expect_gt(
    df$n, 0
  )
})


testthat::test_that("Check data is returned by row count for a data frame", {

  df <- nottshcData::get_rio_honos(return = "tbl_df",
                                   from = "20200101",
                                   to = "20201201") %>%
    nottshcData::tidy_rio_honos() %>%
    honos::rename_honos(
      data = data,
      value_vars_current = c(
        "Q1", "Q2", "Q3",
        "Q4", "Q5", "Q6",
        "Q7", "Q8Score",
        "Q9", "Q10", "Q11",
        "Q12", "Q13"
      ),
      prob_var_item8 = "Q8Problem",
      spec_var_item8 = "Q8JSpec",
      value_vars_history = c("QA", "QB", "QC",
                             "QD", "QE")) %>%
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

  df <- nottshcData::get_rio_honos(return = "tbl_df",
                                   from = "20200101",
                                   to = "20201201") %>%
    honos::rename_honos(
      data = data,
      value_vars_current = c(
        "Q1", "Q2", "Q3",
        "Q4", "Q5", "Q6",
        "Q7", "Q8Score",
        "Q9", "Q10", "Q11",
        "Q12", "Q13"
      ),
      prob_var_item8 = "Q8Problem",
      spec_var_item8 = "Q8JSpec",
      value_vars_history = c("QA", "QB", "QC",
                             "QD", "QE")) %>%
    dplyr::select(7, 8, 15, 16, 17, 26
    ) %>%
    dplyr::collect()

  testthat::expect_named(
    df, col_names,
    ignore.order = TRUE, ignore.case = FALSE
  )
})

testthat::test_that("Check for column names expected", {
  col_names <- c("honos_i1_value",
                 "honos_i2_value",
                 "honos_i8_prob",
                 "honos_i8_spec",
                 "honos_i9_value",
                 "honos_i18_value"
  )

  df <- nottshcData::get_rio_honos(return = "tbl_df",
                                   from = "20200101",
                                   to = "20201201") %>%
    nottshcData::tidy_rio_honos() %>%
    honos::rename_honos(
      data = data,
      value_vars_current = c(
        "q1", "q2", "q3",
        "q4", "q5", "q6",
        "q7", "q8score", "q9",
        "q10", "q11", "q12", "q13"
      ),
      prob_var_item8 = "q8problem",
      spec_var_item8 = "q8j_spec",
      value_vars_history = c("qa", "qb", "qc",
                             "qd", "qe")) %>%
    dplyr::select(7, 8, 15, 16, 17, 26
    ) %>%
    dplyr::collect()

  testthat::expect_named(
    df, col_names,
    ignore.order = TRUE, ignore.case = FALSE
  )
})

