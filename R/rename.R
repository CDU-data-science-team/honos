#' Helper function to rename HoNOS variables
#'
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
rename_honos <- function(value_vars_current, prob_var_item8, spec_var_item8, value_vars_history, honos_version = c("working_adults")) {

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


message("YEAH")


}

rename_honos(
  value_vars_current <- c("asd1", "asd2",  "asd3", "asd4","asd5", "asd6", "asd7",  "asd8", "asd9", "asd10", "asd11",  "asd12", "asd13"),
  prob_var_item8 <- c("asd8p"),
  sepc_var_item8 <- c("asd8s"),
  value_vars_history <- c("asd14", "asd15", "asd16", "asd17", "asd18")
  )
