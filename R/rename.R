#' Helper function to rename HoNOS variables
#'
#' @param data
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
rename_honos <- function(data, value_vars_current, prob_var_item8, spec_var_item8, value_vars_history, honos_version = c("working_adults")) {

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

  # check that variables are present in data

  if (all(c(value_vars_current, prob_var_item8, spec_var_item8, value_vars_history) %in% names(data)) == FALSE) {

    stop("Specified variables must be present in 'data'.", call. = FALSE)

  }
  # start renaming


  message("YEAH")


}
