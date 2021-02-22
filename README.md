
<!-- README.md is generated from README.Rmd. Please edit that file -->

# honos

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

<!-- badges: end -->

The goal of the `honos` R package is to assist with the analysis and
visualisation of Health of the Nation Outcome Scales (HoNOS) ([Wing et
al. 1998](#ref-Wing1998)).

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("CDU-data-science-team/honos", build_vignettes = TRUE)
```

## Functions

See vignettes using `browseVignettes(package = "honos")` for further
information. The vignettes are also available at
<https://cdu-data-science-team.github.io/honos> (see “Articles”).

### Add descriptions to HoNOS data

-   `as_item_desc()`: Add labels for HoNOS items
-   `as_severity_desc()`: Add labels for HoNOS severity ratings
-   `as_cluster_desc()`: Add labels for HoNOS clusters

### Calculations

-   `lag_honos()`: Calculate lagged scores based on a date variable and
    calculate change labels (e.g., “high to low,” or ‘deterioration’)
-   `calc_change_label()`: Calculates change labels for repeated
    measures of the HoNOS
-   `calc_subscales()`: Calculates sums of HoNOS subscales

### Random tests

``` r
library(honos)
#> This is honos 0.1.1
#> honos is currently in development -function names and arguments might change.
#> PLEASE REPORT ANY BUGS!

honos_long <- honos_data %>% 
  pivot_honos_longer(value_vars_current = c("q1", "q2", "q3", "q4", "q5", "q6", "q7", 
                                            "q8", "q9", "q10", "q11", "q12", "q13"),
                     prob_var_item8 = c("q8_prob"),
                     spec_var_item8 = c("q8_spec"),
                     value_vars_history = c("qa", "qb", "qc", "qd", "qe"), 
                     pivot = "all_items")


honos_long
#> # A tibble: 360 x 8
#>    id    date       team  stage measure  item type  value
#>    <chr> <chr>      <chr> <chr> <chr>   <dbl> <chr> <chr>
#>  1 id1   2020-04-20 team2 pre   honos       1 value 1    
#>  2 id1   2020-04-20 team2 pre   honos       2 value 2    
#>  3 id1   2020-04-20 team2 pre   honos       3 value 4    
#>  4 id1   2020-04-20 team2 pre   honos       4 value 2    
#>  5 id1   2020-04-20 team2 pre   honos       5 value 2    
#>  6 id1   2020-04-20 team2 pre   honos       6 value 4    
#>  7 id1   2020-04-20 team2 pre   honos       7 value 3    
#>  8 id1   2020-04-20 team2 pre   honos       8 value 4    
#>  9 id1   2020-04-20 team2 pre   honos       8 prob  A    
#> 10 id1   2020-04-20 team2 pre   honos       8 spec  <NA> 
#> # ... with 350 more rows
```

``` r
honos_longish <- honos_data %>% 
  pivot_honos_longer(value_vars_current = c("q1", "q2", "q3", "q4", "q5", "q6", "q7", 
                                            "q8", "q9", "q10", "q11", "q12", "q13"),
                     prob_var_item8 = c("q8_prob"),
                     spec_var_item8 = c("q8_spec"),
                     value_vars_history = c("qa", "qb", "qc", "qd", "qe"), 
                     pivot = "item_scores")
```

``` r
# make use of all these description functions I wrote
honos_longish %>% 
  dplyr::mutate(item = as_item_desc(item)) %>% 
  dplyr::mutate(prob = as_i8_desc(prob)) %>% 
  dplyr::mutate(value = as_severity_desc(value))
#> # A tibble: 324 x 9
#>    id    date    team  stage measure item               value      prob    spec 
#>    <chr> <chr>   <chr> <chr> <chr>   <fct>              <fct>      <fct>   <chr>
#>  1 id1   2020-0~ team2 pre   honos   Scale 1: Overacti~ Minor pro~ <NA>    <NA> 
#>  2 id1   2020-0~ team2 pre   honos   Scale 2: Non-acci~ Mild prob~ <NA>    <NA> 
#>  3 id1   2020-0~ team2 pre   honos   Scale 3: Problem ~ Severe to~ <NA>    <NA> 
#>  4 id1   2020-0~ team2 pre   honos   Scale 4: Cognitiv~ Mild prob~ <NA>    <NA> 
#>  5 id1   2020-0~ team2 pre   honos   Scale 5: Physical~ Mild prob~ <NA>    <NA> 
#>  6 id1   2020-0~ team2 pre   honos   Scale 6: Hallucin~ Severe to~ <NA>    <NA> 
#>  7 id1   2020-0~ team2 pre   honos   Scale 7: Depresse~ Moderatel~ <NA>    <NA> 
#>  8 id1   2020-0~ team2 pre   honos   Scale 8: Other me~ Severe to~ Type A~ <NA> 
#>  9 id1   2020-0~ team2 pre   honos   Scale 9: Relation~ Mild prob~ <NA>    <NA> 
#> 10 id1   2020-0~ team2 pre   honos   Scale 10: Activit~ Moderatel~ <NA>    <NA> 
#> # ... with 314 more rows
```

``` r
# not sure if this is ever needed but might be useful when filtering for all cases where item 8 is a particular problem
honos_longish  %>% 
  dplyr::group_by(id, date, team) %>% 
  tidyr::fill(prob, .direction = "downup")
#> # A tibble: 324 x 9
#> # Groups:   id, date, team [18]
#>    id    date       team  stage measure  item value prob  spec 
#>    <chr> <chr>      <chr> <chr> <chr>   <dbl> <dbl> <chr> <chr>
#>  1 id1   2020-04-20 team2 pre   honos       1     1 A     <NA> 
#>  2 id1   2020-04-20 team2 pre   honos       2     2 A     <NA> 
#>  3 id1   2020-04-20 team2 pre   honos       3     4 A     <NA> 
#>  4 id1   2020-04-20 team2 pre   honos       4     2 A     <NA> 
#>  5 id1   2020-04-20 team2 pre   honos       5     2 A     <NA> 
#>  6 id1   2020-04-20 team2 pre   honos       6     4 A     <NA> 
#>  7 id1   2020-04-20 team2 pre   honos       7     3 A     <NA> 
#>  8 id1   2020-04-20 team2 pre   honos       8     4 A     <NA> 
#>  9 id1   2020-04-20 team2 pre   honos       9     2 A     <NA> 
#> 10 id1   2020-04-20 team2 pre   honos      10     3 A     <NA> 
#> # ... with 314 more rows
```

## Resources

-   <https://improvement.nhs.uk/documents/485/Annex_DtE_Mental_health_clustering_tool.pdf>
-   <https://www.rcpsych.ac.uk/events/in-house-training/health-of-nation-outcome-scales>
-   <https://www.nhs.uk/Scorecard/Pages/IndicatorFacts.aspx?MetricId=9308>
-   <https://www.healthylondon.org/resource/mental-health-in-integrated-care-systems/outcome-measures/honos/>
-   <https://bmjopen.bmj.com/content/6/4/e010732>
-   <https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5914766/>
-   <https://www.healthylondon.org/wp-content/uploads/2017/11/Clinical-engagement-with-HoNOS-REPORT-NOV-2018-FINAL.pdf>

## References

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-Wing1998" class="csl-entry">

Wing, J K, A S Beevor, R H Curtis, S B G Park, S Madden, and A Burns.
1998. “Health of the Nation Outcome Scales (HoNOS).” *British Journal of
Psychiatry* 172 (1): 11–18. <https://doi.org/10.1192/bjp.172.1.11>.

</div>

</div>
