#' Convert HoNOS severity scores to labelled factor
#'
#' @param x Vector of severity rating from 0 to 4
#' @param short_descriptions Logical, specifying whether to return short or long descriptions
#' @param na_level String, specifying label for missing values.
#'
#' @return Labelled "factor"
#' @export
#'
#' @examples
#' x <- 0:4
#' as_severity_desc(x)
as_severity_desc <- function(x, short_descriptions = TRUE, na_level = NULL) {

  # define labels here, short or long
  if (short_descriptions == TRUE) {

    use_labels <- c("No problem",
                    "Minor",
                    "Mild",
                    "Moderately/Severe",
                    "Severe/Very severe")

  } else {

    use_labels <- c("No problem",
                    "Minor problem",
                    "Mild problem",
                    "Moderately severe problem",
                    "Severe to very severe problem")

  }

  x <- factor(x,
              levels = c(0:4),
              labels = use_labels)

  if (is.null(na_level) == FALSE) {

    x <- forcats::fct_explicit_na(x, na_level = na_level)

  }

  return(x)

}

#' Convert HoNOS item numbers to labelled factor
#' @description Types of other mental and behavioural problems specified in Item 8 can be labelled using the function \code{\link{as_i8_desc}}
#'
#' @param x Vector of item numbers
#' @param short_descriptions Logical, specifying whether to return short or long descriptions
#' @param .ignore_n_items Logical, if TRUE the specified vector does not check the item number and assumes that the 18 item "working adults" version that includes current and historical scales.
#'
#' @return Labelled "factor"
#' @export
#'
#' @examples
#' x <- 1:13
#' as_item_desc(x, n_items = 13)
as_item_desc <- function(x, short_descriptions = TRUE, .ignore_n_items = FALSE) {

  # Check max number of items
  n_items <- max(x, na.rm = TRUE)

  # ADD max number of items for each implemented HoNOS versions here
  n_items_available <- c(12, 13, 18)

  if (.ignore_n_items == FALSE) {

    # Check if max number of items is already implemented in this version of the package
    if (!n_items %in% n_items_available == TRUE) {
      stop("The maximum number of items in x (n = ", n_items, ") is currently not implemented.\nYou can ignore this behaviour by adding the argument '.ignore_n_items = FALSE'.", call. = FALSE)
    }

  } else if (.ignore_n_items == TRUE) {

    n_items <- 18

  }

  # define labels here, short or long
  if (short_descriptions == TRUE) {

    use_labels <- c(
      "Overactiver",
      "Self-harm",
      "Substance",
      "Cognitive",
      "Physical",
      "Psychotic",
      "Depression",
      "Other",
      "Relationships",
      "ADL",
      "Housing",
      "Activities",
      "Unreasonable beliefs",
      "Historic - Agitated",
      "Historic - Self-harm",
      "Historic - Safeguarding",
      "Historic - Engagement",
      "Historic - Vulnerability"
    )

  } else {

    use_labels <- c(
      "Scale 1: Overactive, aggressive, disruptive or agitated behaviour",
      "Scale 2: Non-accidental self-injury",
      "Scale 3: Problem drinking or drug taking",
      "Scale 4: Cognitive problems",
      "Scale 5: Physical illness or disability problems",
      "Scale 6: Hallucinations and Delusions",
      "Scale 7: Depressed mood",
      "Scale 8: Other mental and behavioural problems",
      "Scale 9: Relationships",
      "Scale 10: Activities of daily living",
      "Scale 11: Living conditions",
      "Scale 12: Occupation & Activities",
      "Scale 13: Strong unreasonable beliefs",
      "Scale A: Historic - Agitated behaviour/expansive mood",
      "Scale B: Historic - Repeat Self-harm",
      "Scale C: Historic - Safeguarding other children & vulnerable dependant adults",
      "Scale D: Historic - Engagement",
      "Scale E: Historic - Vulnerability"
    )

  }

  x <- factor(x,
                levels = c(1:18),
                labels = use_labels
    )

  return(x)

  }




#' Convert HoNOS item 8 types to labelled factor
#'
#' @param x Vector of strings
#' @param short_descriptions Logical, specifying whether to return short or long descriptions
#'
#' @return Labelled "factor"
#' @export
#'
#' @examples
#' x <- c("A", "B", "C", "D", "E", "F", "G", "H", "I", "J")
#' as_i8_desc(x)
as_i8_desc <- function(x, short_descriptions = TRUE) {

  # define labels here, short or long
  if (short_descriptions == TRUE) {

    use_labels <- c("Phobic",
                    "Anxiety",
                    "Obsessive-compulsive",
                    "Mental strain / tension",
                    "Dissociative",
                    "Somatoform",
                    "Eating",
                    "Sleep",
                    "Sexual",
                    "Other, specify")

  } else {

    use_labels <- c("Type A: Phobic",
                    "Type B: Anxiety",
                    "Type C: Obsessive-compulsive",
                    "Type D: Mental strain / tension",
                    "Type E: Dissociative",
                    "Type F: Somatoform",
                    "Type G: Eating",
                    "Type H: Sleep",
                    "Type I: Sexual",
                    "Type J: Other, specify")

  }

  x <- factor(x,
              levels = c("A", "B", "C", "D", "E", "F", "G", "H", "I", "J"),
              labels = use_labels
              )

  return(x)

}


#' Describe clusters
#'
#' @param x Vector of numeric values ranging from 0 to 21
#' @param short_descriptions Logical, specifying whether to return short or long descriptions
#'
#' @return Labelled "factor"
#' @export
#'
#' @examples
#' x <- 0:21
#' # Return clusters (0 to 21)
#' as_cluster_desc(x)
#' # Return super clusters (A to C)
#' as_cluster_desc(x,
#'                 return = "super_cluster")
#' # Return detailed super clusters
#' as_cluster_desc(x,
#'                 return = "super_cluster",
#'                 super_cluster_details = TRUE)
as_cluster_desc <- function(x, return = c("cluster", "super_cluster"), short_descriptions = TRUE, super_cluster_details = FALSE) {

  return <- match.arg(return)

  if (return == "cluster") {

    # define labels here, short or long
    if (short_descriptions == TRUE) {

      use_labels <- c(
        "Care Cluster 0: Variance",
        "Care Cluster 1: Common mental health problems (Low severity)",
        "Care Cluster 2: Common mental health problems (Low severity with greater need)",
        "Care Cluster 3: Non-psychotic (Moderate severity)",
        "Care Cluster 4: Non-psychotic (Severe)",
        "Care Cluster 5: Non-psychotic disorders (Very severe)",
        "Care Cluster 6: Non-psychotic disorder of over-valued ideas",
        "Care Cluster 7: Enduring non-psychotic disorders (High disability)",
        "Care Cluster 8: Non-psychotic chaotic and challenging disorders",
        "Care Cluster 9: Blank cluster",
        "Care Cluster 10: First episode psychosis (With / without manic features)",
        "Care Cluster 11: Ongoing recurrent psychosis (Low symptoms)",
        "Care Cluster 12: Ongoing or recurrent psychosis (High disability)",
        "Care Cluster 13: Ongoing or recurrent psychosis (High symptom and disability)",
        "Care Cluster 14: Psychotic crisis",
        "Care Cluster 15: Severe psychotic depression",
        "Care Cluster 16: Psychosis and affective disorder (High substance misuse and engagement)",
        "Care Cluster 17: Psychosis and affective disorder – difficult to engage",
        "Care Cluster 18: Cognitive impairment (Low need)",
        "Care Cluster 19: Cognitive impairment or dementia complicated (Moderate need)",
        "Care Cluster 20: Cognitive impairment or dementia complicated (High need)",
        "Care Cluster 21: Cognitive impairment or dementia (High physical or engagement)"
      )

    } else {

      use_labels <- c(
        "Care Cluster 0: Variance",
        "Care Cluster 1: Common mental health problems (Low severity)",
        "Care Cluster 2: Common mental health problems (Low severity with greater need)",
        "Care Cluster 3: Non-psychotic (Moderate severity)",
        "Care Cluster 4: Non-psychotic (Severe)",
        "Care Cluster 5: Non-psychotic disorders (Very severe)",
        "Care Cluster 6: Non-psychotic disorder of over-valued ideas",
        "Care Cluster 7: Enduring non-psychotic disorders (High disability)",
        "Care Cluster 8: Non-psychotic chaotic and challenging disorders",
        "Care Cluster 9: Blank cluster",
        "Care Cluster 10: First episode psychosis (With / without manic features)",
        "Care Cluster 11: Ongoing recurrent psychosis (Low symptoms)",
        "Care Cluster 12: Ongoing or recurrent psychosis (High disability)",
        "Care Cluster 13: Ongoing or recurrent psychosis (High symptom and disability)",
        "Care Cluster 14: Psychotic crisis",
        "Care Cluster 15: Severe psychotic depression",
        "Care Cluster 16: Psychosis and affective disorder (High substance misuse and engagement)",
        "Care Cluster 17: Psychosis and affective disorder – difficult to engage",
        "Care Cluster 18: Cognitive impairment (Low need)",
        "Care Cluster 19: Cognitive impairment or dementia complicated (Moderate need)",
        "Care Cluster 20: Cognitive impairment or dementia complicated (High need)",
        "Care Cluster 21: Cognitive impairment or dementia (High physical or engagement)"
      )

    }

  x <- factor(x,
              levels = c(0:21),
              labels = use_labels
              )
  } else if (return == "super_cluster") {

    if (super_cluster_details == FALSE) {

      # define labels here, short or long
      if (short_descriptions == TRUE) {

        use_labels <- c("A: Non-psycotic", "B: Psychosis", "C: Organic")

      } else {

        use_labels <- c("A: Non-psycotic", "B: Psychosis", "C: Organic")

      }

      x <- dplyr::case_when(x == 0 ~ NA_character_,
                            x %in% 1:8 ~ use_labels[[1]],
                            x %in% 9 ~ use_labels[[1]],
                            x %in% 10:17 ~ use_labels[[2]],
                            x %in% 18:21 ~ use_labels[[3]],
                            TRUE ~ NA_character_
                            )

      x <- factor(x,
                  levels = use_labels,
                  labels = use_labels
                  )

    } else if (super_cluster_details == TRUE) {

      # define labels here, short or long
      if (short_descriptions == TRUE) {

        use_labels <- c("A: Non-psycotic (Blank place marker)",
                        "A: Non-psycotic (Very severe and complex)",
                        "A: Non-psycotic (Mild, moderate, or severe)",
                        "B: Psychosis (First episode)",
                        "B: Psychosis (Ongoing or recurrent)",
                        "B: Psychosis (Psychotic crisis)",
                        "B: Psychosis (Very severe engagement)",
                        "C: Organic (Cognitive impairment)")

      } else {

        use_labels <- c("A: Non-psycotic (Blank place marker)",
                        "A: Non-psycotic (Very severe and complex)",
                        "A: Non-psycotic (Mild, moderate, or severe)",
                        "B: Psychosis (First episode)",
                        "B: Psychosis (Ongoing or recurrent)",
                        "B: Psychosis (Psychotic crisis)",
                        "B: Psychosis (Very severe engagement)",
                        "C: Organic (Cognitive impairment)")

      }

      x <- dplyr::case_when(x == 0 ~ NA_character_,
                            x %in% 1:4 ~   use_labels[[2]],
                            x %in% 5:8 ~   use_labels[[3]],
                            x == 9 ~       use_labels[[1]],
                            x == 10 ~      use_labels[[4]],
                            x %in% 11:13 ~ use_labels[[5]],
                            x %in% 14:15 ~ use_labels[[6]],
                            x %in% 16:17 ~ use_labels[[7]],
                            x %in% 18:21 ~ use_labels[[8]],
                            TRUE ~ NA_character_
                            )

      x <- factor(x,
                  levels = use_labels,
                  labels = use_labels
                  )
    }

  }

  return(x)

}
