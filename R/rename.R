#' Helper function to rename HoNOS variables
#'
#' @param data Dataset including HoNOS variables in wide format (i.e., one row per assessment, one column per item)
#' @param value_vars_current Vector, specifying variable names with values for 'current' items
#' @param prob_var_item8 Vector, specifying variable name with description of problem (prob) for item 8
#' @param spec_var_item8 Vector, specifying variable name with problem specification (spec) of for item 8
#' @param value_vars_history Vector, specifying specifying variable names with values for 'historic' items
#' @param honos_version Vector, specifying version of the HoNOS that is being used. TODO IMPLEMENT MORE VERSIONS.
#'
#' @return
#' @export
#'
#' @examples
#' rename_honos(data = honos::honos_data,
#'              value_vars_current = c("q1", "q2", "q3", "q4", "q5", "q6", "q7", "q8", "q9", "q10", "q11", "q12", "q13"),
#'              prob_var_item8 = c("q8_prob"),
#'              spec_var_item8 = c("q8_spec"),
#'              value_vars_history = c("qa", "qb", "qc", "qd", "qe")
#'              )
rename_honos <- function(data, value_vars_current, prob_var_item8, spec_var_item8, value_vars_history, honos_version = c("working_adults"), .return_new_var_names = FALSE) {

  honos_version <- match.arg(honos_version)

  # Create different checks for different versions of HONOS
  if (honos_version == "working_adults") {

    n_honos_vars_check <- list(n_value_vars_current = 13, n_prob_var_item8 = 1, n_spec_var_item8 = 1, n_value_vars_history = 5)

  }

  # check if vectors have the correct length
  if (length(value_vars_current) != n_honos_vars_check[["n_value_vars_current"]]) {
    stop(paste0("Specify n = ", n_honos_vars_check[["n_value_vars_current"]] ," variables in 'value_vars_current'."), call. = FALSE)
  }

  if (length(prob_var_item8) != n_honos_vars_check[["n_prob_var_item8"]]) {
    stop(paste0("Specify n = ", n_honos_vars_check[["n_spec_var_item8"]] ," variables in 'prob_var_item8'."), call. = FALSE)
  }

  if (length(spec_var_item8) != n_honos_vars_check[["n_spec_var_item8"]]) {
    stop(paste0("Specify n = ", n_honos_vars_check[["n_spec_var_item8"]] ," variables in 'spec_var_item8'."), call. = FALSE)
  }

  if (length(value_vars_history) != n_honos_vars_check[["n_value_vars_history"]]) {
    stop(paste0("Specify n = ", n_honos_vars_check[["n_value_vars_history"]] ," variables in 'value_vars_history'."), call. = FALSE)
  }

  if (any(duplicated(c(value_vars_current, prob_var_item8, spec_var_item8, value_vars_history)))) {
    stop("Variable names must be unique.", call. = FALSE)
  }

  # check that variables are present in data, also add sql functionality

  if ("tbl_df" %in% class(data)) {

    names_data <- names(data)

  } else if ("tbl_sql" %in% class(data)) {

    names_data <- names(data$ops$args$vars)

  }




  if (all(c(value_vars_current, prob_var_item8, spec_var_item8, value_vars_history) %in% names_data) == FALSE) {

    stop("Specified variables must be present in 'data'.", call. = FALSE)

  }


  # Create vector of consistent variable names for honos 13 item version
  # TODO this needs to be changed for other versions of the honos
  honos_scales_new_names <- c(paste0("honos", "_", "i", 1:8, "_value"),
                              c("honos_i8_prob", "honos_i8_spec"),
                              paste0("honos", "_", "i", 9:13, "_value"),
                              paste0("honos", "_", "i", 14:18, "_value"))

  # TODO I might need to add more checks here to make sure that none of these new variables names already exist in the data sets specified in 'data'


  if (.return_new_var_names == TRUE) {

    return(honos_scales_new_names)

  } else if (.return_new_var_names == FALSE) {

    if (all(c(value_vars_current[1:8], prob_var_item8, spec_var_item8, value_vars_current[9:13], value_vars_history) %in% honos_scales_new_names)) {

      message("The variable names specified in 'data' are already named appropriately.")

      return(data)

    } else {
      # create object for rename function
      honos_scales_rename <- setNames(object = c(value_vars_current[1:8], prob_var_item8, spec_var_item8, value_vars_current[9:13], value_vars_history),
                                      nm = honos_scales_new_names)

      # rename variables ...
      data %>%
        dplyr::rename(dplyr::all_of(honos_scales_rename))
    }

  }

}
