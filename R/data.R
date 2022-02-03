#' @importFrom tibble tibble
NULL



#' Example dataset dataset with repeated measures of HoNOS scores in wide format
#'
#' @description Example dataset with repeated measures of the Health of the
#' Nation Outcome Scales (HoNOS) to illustrate how the package works and test
#' functions.
#' The data was created by hand, see here:
#' \url{https://github.com/CDU-data-science-team/honos/blob/main/data-raw/DATASET.R}.
#' @docType data
#' @usage data(honos_data)
#' @format A longitudinal dataset in wide format, i.e one row per person,
#' one column per variable.
#' \itemize{
#'   \item{id}{: ID variable, unique identifier for each person}
#'   \item{date}{: Date of HoNOS assesmment}
#'   \item{team}{: String, specifying team}
#'   \item{stage}{: String, specifying stage of assessment point (e.g., pre, mid, post)}
#'    \item{q1}{: Scale 1 - Overactive, aggressive, disruptive or agitated behaviour}
#'    \item{q2}{: Scale 2 - Non-accidental self-injury}
#'    \item{q3}{: Scale 3 - Problem drinking or drug taking}
#'    \item{q4}{: Scale 4 - Cognitive problems}
#'    \item{q5}{: Scale 5 - Physical illness or disability problems}
#'    \item{q6}{: Scale 6 - Hallucinations and Delusions}
#'    \item{q7}{: Scale 7 - Depressed mood}
#'    \item{q8}{: Scale 8 - Other mental and behavioural problems (Value)}
#'    \item{q8_prob}{: Scale 8 - Other mental and behavioural problems (Problem)}
#'    \item{q8_spec}{: Scale 8 - Other mental and behavioural problems (Specification)}
#'    \item{q9}{: Scale 9 - Relationships}
#'   \item{q10}{: Scale 10 - Activities of daily living}
#'   \item{q11}{: Scale 11 - Living conditions}
#'   \item{q12}{: Scale 12 - Occupation & Activities}
#'   \item{q13}{: Scale 13 - Strong unreasonable beliefs}
#'    \item{qa}{: Scale A - Agitated behaviour/expansive mood}
#'    \item{qb}{: Scale B - Repeat Self-Harm}
#'    \item{qc}{: Scale C - Safeguarding other children & vulnerable dependant adults}
#'    \item{qd}{: Scale D - Engagement}
#'    \item{qe}{: Scale E - Vulnerability}
#' }
#' @keywords dataset
#' @examples
#' # Load data into global environment
#' data(honos_data)
"honos_data"
