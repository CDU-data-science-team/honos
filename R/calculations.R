#' Calculate lagged HoNOS scores
#'
#' @param data Dataframe in wide format (i.e., one row for each HoNOS assessment and one column for each HoNOS item)
#' @param id_var Name of variable that uniquely identifies each individual
#' @param date_var Name of date (or datetime) variable
#' @param add_change_label Logical, specifying whether to add a variable that describes the change using the function \code{\link{as_change_label}}
#' @param change_label String, specifying whether to describe the change using "high_low" (e.g., HL stands for high to low) or "deterio_improve" (Deterioration, Unchanged, Improved)
#'
#' @return Dataframe with original data and lagged values
#' @export
#'
#' @examples
#' lag_honos(data = honos_wide,
#'           id_var = id,
#'           date_var = date,
#'           change_label = "deterio_improve")
lag_honos <- function(data, id_var, date_var, add_change_label = TRUE, change_label = c("high_low", "deterio_improve")) {

  # Check arguments
  change_label <- match.arg(change_label)

  # TODO ADD SOME DATA CHECKS

  # TODO THIS NEEDS TO BE IMPROVED
  # MAKE THIS MORE GENERIC SO IT WORKS WITH ALL SORTS OF VARIABLE NAMES
  # Create vectors of variable names
  honos_scales_new_names <- paste0("honos_i", 1:13)
  honos_scales_lag_names <- paste0("lag1", "honos", "_", "i", 1:13)

  # Create lag1 in wide format
  data_lag <- data %>%
    dplyr::group_by({{ id_var }}) %>%
    dplyr::arrange({{ id_var }}, {{ date_var }}) %>%
    dplyr::mutate(dplyr::across(.cols = c({{ date_var }}, {{ honos_scales_new_names }}),
                                .fns = list(lag1 = ~dplyr::lag(.)),
                                .names = "{fn}{col}")) %>%
    dplyr::ungroup()


  # Calculate difference score in long format
  data_change <- data_lag %>%
    tidyr::pivot_longer(cols = dplyr::all_of(c({{ honos_scales_new_names }}, {{ honos_scales_lag_names }})),
                        values_to = "value",
                        names_to = c("lag", "item"),
                        names_sep = "_") %>%
    dplyr::mutate(item = factor(stringr::str_extract(item, "\\d+"),
                                labels = 1:13),
                  value = as.numeric(value)) %>%
    tidyr::pivot_wider(names_from = lag,
                       values_from = value) %>%
    dplyr::mutate(honos_change = lag1honos - honos,
                  honos_date_diff := {{ date_var }} - !! rlang::sym(paste0("lag1", rlang::ensym(date_var)))) %>%
    tidyr::drop_na(honos_date_diff)

  # Add change label
  if (add_change_label == TRUE) {

    data_change <- data_change %>%
      dplyr::mutate(honos_change_label = as_change_label(value = honos,
                                                         lag_value = lag1honos,
                                                         change_label = change_label))

  }

  # Return data
  return(data_change)

}





#' Calculate change labels for lagged change scores
#'
#' @param value Name of variable with HoNOS score at time point (t)
#' @param lag_value Name of variable with HoNOS score at previous time point (t-1)
#' @param change_label String, specifying whether to describe the change using "high_low" (e.g., HL stands for high to low) or "deterio_improve" (Deterioration, Unchanged, Improved)
#'
#' @return Labelled "factor"
#' @export
#'
#' @examples
#' as_change_label(value = 0, lag_value = 4,
#'                 change_label = "deterio_improve")
as_change_label <- function(value, lag_value, change_label = c("high_low", "deterio_improve")) {

  change_label <- match.arg(change_label)

  # Define high low change categories
  x4 <- dplyr::case_when({{value}} %in% c(3:4) & {{lag_value}} %in% c(0:2) ~ "HL",
                         {{value}} %in% c(0:2) & {{lag_value}} %in% c(3:4) ~ "LH",
                         {{value}} %in% c(0:2) & {{lag_value}} %in% c(0:2) ~ "LL",
                         {{value}} %in% c(3:4) & {{lag_value}} %in% c(3:4) ~ "HH")

  # Create factor
  x4 <-  factor(x4, levels = c("LL", "LH", "HL", "HH"))

  if (change_label == "high_low") {

    return(x4)

  } else if (change_label == "deterio_improve") {

    x3 <- dplyr::case_when(x4 %in% c("LL", "HH") ~ "Unchanged",
                           x4 == "LH" ~ "Deterioation",
                           x4 == "HL" ~ "Improvement")

    x3 <- factor(x3,
                 levels = c("Deterioation", "Unchanged", "Improvement"))

    return(x3)

  }

}