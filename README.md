
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
# install.packages("remotes")
remotes::install_github("CDU-data-science-team/honos", build_vignettes = TRUE)
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
