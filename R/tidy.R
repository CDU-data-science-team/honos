#' Pivot HoNOS data from wide to long
#'
#' @description THis functions transforms HoNOS data from wide (i.e., one row per assessment, one column per variable) to long (i.e., one row per item) data.
#' This data format is needed to perform common calculations and visualisations of HoNOS data in R.
#' This function automatically replaces the value 9 with a missing value ('NA').
#'
#' @param data Dataset including HoNOS variables in wide format (i.e., one row per assessment, one column per item)
#' @param value_vars_current Vector, specifying variable names with values for 'current' items
#' @param prob_var_item8 Vector, specifying variable name with description of problem (prob) for item 8
#' @param spec_var_item8 Vector, specifying variable name with problem specification (spec) of for item 8
#' @param value_vars_history Vector, specifying specifying variable names with values for 'historic' items
#' @param honos_version Vector, specifying version of the HoNOS that is being used. TODO IMPLEMENT MORE VERSIONS.
#' @param pivot String, specifying whether to include item 8 problem and item 8 specification in the long format ('all_items') or whether to only include all item scores in long format ("item_scores").
#'
#' @return
#' @export
#'
#' @examples
pivot_honos_longer <- function(data, value_vars_current, prob_var_item8,
                               spec_var_item8, value_vars_history,
                               honos_version = c("working_adults"),
                               pivot = c("all_items", "item_scores")) {

  pivot <- match.arg(pivot)

  # Rename data
  honos_renamed <- rename_honos(data = data,
                                value_vars_current = value_vars_current,
                                prob_var_item8 = prob_var_item8,
                                spec_var_item8 = spec_var_item8,
                                value_vars_history = value_vars_history,
                                honos_version = honos_version)

  # Get new variable names
  honos_new_var_names <- rename_honos(data = data,
                                      value_vars_current = value_vars_current,
                                      prob_var_item8 = prob_var_item8,
                                      spec_var_item8 = spec_var_item8,
                                      value_vars_history = value_vars_history,
                                      honos_version = honos_version,
                                      .return_new_var_names = TRUE)

  # nor make data long, first need to make sure all values are same type, I dont really like this
  honos_long <- honos_renamed %>%
    dplyr::mutate_if(is.double, as.character) %>%
    tidyr::pivot_longer(cols = dplyr::all_of(honos_new_var_names),
                        names_sep = "_",
                        names_to = c("measure", "item", "type")) %>%
    dplyr::mutate(item = as.numeric(stringr::str_extract(item, "\\d+")),
                  value = dplyr::na_if(value, 9)) %>%
    dplyr::arrange(id, dplyr::desc(date), item)

  if (pivot == "all_items") {

    return(honos_long)

  } else if (pivot == "item_scores") {

    # now make long data a little wider
    # this may be useful when I only want to have actual numeric values in the values column
    # need this for calculating lagged scores for example
    honos_long %>%
      tidyr::pivot_wider(names_from = type,
                         values_from = value) %>%
      dplyr::mutate(value = as.numeric(value)) %>%
      dplyr::arrange(id, dplyr::desc(date), item)

  }





}
