#' Convert HoNOS severity scores to labelled factor
#'
#' @param x Vector of severity rating from 0 to 4
#' @param na_level String, specifying label for missing values.
#'
#' @return
#' @export
#'
#' @examples
#' x <- 0:4
#' as_severity_desc(x)
as_severity_desc <- function(x, na_level = NULL) {

  x <- factor(x,
              level = c(0:4),
              labels = c("No problem",
                         "Minor problem",
                         "Mild problem",
                         "Moderately severe problem",
                         "Severe to very severe problem")
  )

  if (is.null(na_level) == FALSE) {

   x <- forcats::fct_explicit_na(x, na_level = na_level)

  }

  return(x)

}

#' Convert HoNOS item numbers to labelled factor
#'
#' @param x Vector of item numbers
#' @param n_items Numeric, specifying maximum number of items
#'
#' @return
#' @export
#'
#' @examples
#' x <- 1:13
#' as_item_desc(x)
as_item_desc <- function(x, n_items) {

  if (n_items == 13) {

    x <- factor(x,
                levels = c(1:13),
                labels = c(
                  "Item 1: Overactive, aggressive, disruptive or agitated behaviour",
                  "Item 2: Non-accidental self-injury",
                  "Item 3: Problem drinking or drug taking",
                  "Item 4: Cognitive problems",
                  "Item 5: Physical illness or disability problems",
                  "Item 6: Hallucinations and Delusions",
                  "Item 7: Depressed mood",
                  "Item 8: Other mental and behavioural problems",
                  "Item 9: Relationships",
                  "Item 10: Activities of daily living",
                  "Item 11: Living conditions",
                  "Item 12: Occupation & Activities",
                  "Item 13: Strong unreasonable beliefs"
                  )
    )

  } else if (n_items == 18) {

    x <- factor(x,
                levels = c(1:18),
                labels = c(
                  "Item 1: Overactive, aggressive, disruptive or agitated behaviour",
                  "Item 2: Non-accidental self-injury",
                  "Item 3: Problem drinking or drug taking",
                  "Item 4: Cognitive problems",
                  "Item 5: Physical illness or disability problems",
                  "Item 6: Hallucinations and Delusions",
                  "Item 7: Depressed mood",
                  "Item 8: Other mental and behavioural problems",
                  "Item 9: Relationships",
                  "Item 10: Activities of daily living",
                  "Item 11: Living conditions",
                  "Item 12: Occupation & Activities",
                  "Item 13: Strong unreasonable beliefs",

                  "Item A: Agitated behaviour/expansive mood",
                  "Item B: Repeat Self-Harm",
                  "Item C: Safeguarding other children & vulnerable dependant adults",
                  "Item D: Engagement",
                  "Item E: Vulnerability"
                  )
    )

  } else if (n_items != 13 & n_items != 18) {

    stop("This version if the HoNOS is currently not supported.")

  }


              }




#' Convert HoNOS item 8 types to labelled factor
#'
#' @param x Vector of strings
#'
#' @return
#' @export
#'
#' @examples
#' x <- c("A", "B", "C", "D", "E", "F", "G", "H", "I", "J")
#' as_i8_desc(x)
as_i8_desc <- function(x) {

  x <- factor(x,
              levels = c("A", "B", "C", "D", "E", "F", "G", "H", "I", "J"),
              labls = c("Type A: Phobic",
                        "Type B: Anxiety",
                        "Type C: Obsessive-compulsive",
                        "Type D: Mental strain / tension",
                        "Type E: Dissociative",
                        "Type F: Somatoform",
                        "Type G: Eating",
                        "Type H: Sleep",
                        "Type I: Sexual",
                        "Type J: Other, specify"))

  return(x)

}
