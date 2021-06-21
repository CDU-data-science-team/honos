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
#' pivot_honos_longer(data = honos_data,
#'                    id_var = id,
#'                    value_vars_current = c("q1", "q2", "q3", "q4", "q5", "q6", "q7",
#'                                           "q8", "q9", "q10", "q11", "q12", "q13"),
#'                    prob_var_item8 = "q8_prob",
#'                    spec_var_item8 = "q8_spec",
#'                    value_vars_history = c("qa", "qb", "qc", "qd", "qe"),
#'                    pivot = "all_items")
pivot_honos_longer <- function(data,
                               value_vars_current, prob_var_item8, spec_var_item8, value_vars_history,
                               pivot = c("all_items", "item_scores"),
                               honos_version = c("working_adults")) {

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

  # pivot honos longer
  honos_long <- honos_renamed %>%
    tidyr::pivot_longer(cols = dplyr::all_of(c(honos_new_var_names)),
                        names_sep = "_",
                        names_to = c("measure", "item", "type"))


  if ("tbl_sql" %in% class(data)) {

    honos_long <- honos_long %>%
      dplyr::mutate(item = dplyr::case_when(item %like% "i1" ~ '1',
                                            item %like% "i2" ~ '2',
                                            item %like% "i3" ~ '3',
                                            item %like% "i4" ~ '4',
                                            item %like% "i5" ~ '5',
                                            item %like% "i6" ~ '6',
                                            item %like% "i7" ~ '7',
                                            item %like% "i8" ~ '8',
                                            item %like% "i9" ~ '9',
                                            item %like% "i10" ~ '10',
                                            item %like% "i11" ~ '11',
                                            item %like% "i12" ~ '12',
                                            item %like% "i13" ~ '13',
                                            item %like% "i14" ~ '14',
                                            item %like% "i15" ~ '15',
                                            item %like% "i16" ~ '16',
                                            item %like% "i17" ~ '17',
                                            item %like% "i18" ~ '18'),
                    item = as.numeric(item))

  } else if ("tbl_df" %in% class(data)) {

    honos_long <- honos_long %>%
      dplyr::mutate(item = as.numeric(stringr::str_extract(item, "\\d+")))

  }


  if (pivot == "all_items") {

    return(honos_long)

  } else if (pivot == "item_scores") {

    # now make long data a little wider
    # this may be useful when I only want to have actual numeric values in the values column
    # need this for calculating lagged scores for example
    honos_long %>%
      tidyr::pivot_wider(names_from = type,
                         values_from = value) %>%
      dplyr::mutate(value = as.numeric(value))

  }

}
