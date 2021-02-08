
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
devtools::install_github("CDU-data-science-team/honos")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(honos)
library(tidyverse)
#> Warning: package 'tidyverse' was built under R version 4.0.3
#> -- Attaching packages --------------------------------------- tidyverse 1.3.0 --
#> v ggplot2 3.3.3     v purrr   0.3.4
#> v tibble  3.0.5     v dplyr   1.0.3
#> v tidyr   1.1.2     v stringr 1.4.0
#> v readr   1.4.0     v forcats 0.5.0
#> Warning: package 'ggplot2' was built under R version 4.0.3
#> Warning: package 'tibble' was built under R version 4.0.3
#> Warning: package 'tidyr' was built under R version 4.0.3
#> Warning: package 'readr' was built under R version 4.0.3
#> Warning: package 'purrr' was built under R version 4.0.3
#> Warning: package 'dplyr' was built under R version 4.0.3
#> Warning: package 'stringr' was built under R version 4.0.3
#> Warning: package 'forcats' was built under R version 4.0.3
#> -- Conflicts ------------------------------------------ tidyverse_conflicts() --
#> x dplyr::filter() masks stats::filter()
#> x dplyr::lag()    masks stats::lag()
## basic example code
```

## Datasets

The package comes with a simulated datasets of HoNOS scores (13-items)
that is available in “long” as well as “wide” format.

### Long format

-   `id`: Unique identifier
-   `date`: Date variable
-   `measure`: Description of measure
-   `item`: Number of HoNOS item
-   `value`: HoNOS score

``` r
honos_long %>% 
  dplyr::filter(id %in% paste0("id", 1:5))
#> # A tibble: 195 x 5
#>    id    date       measure item  value
#>    <fct> <date>     <chr>   <fct> <dbl>
#>  1 id1   2018-08-05 honos   1         2
#>  2 id1   2018-08-05 honos   2         4
#>  3 id1   2018-08-05 honos   3         2
#>  4 id1   2018-08-05 honos   4         3
#>  5 id1   2018-08-05 honos   5         2
#>  6 id1   2018-08-05 honos   6        NA
#>  7 id1   2018-08-05 honos   7         1
#>  8 id1   2018-08-05 honos   8         0
#>  9 id1   2018-08-05 honos   9         1
#> 10 id1   2018-08-05 honos   10        3
#> # ... with 185 more rows
```

### Wide format

-   `id`: Unique identifier
-   `date`: Date variable
-   `measure`: Description of measure
-   `honos_i1` to `honos_i13`: HoNOS score for each item

``` r
honos_wide %>% 
  dplyr::filter(id %in% paste0("id", 1:5))
#> # A tibble: 15 x 16
#>    id    date       measure honos_i1 honos_i2 honos_i3 honos_i4 honos_i5
#>    <fct> <date>     <chr>      <dbl>    <dbl>    <dbl>    <dbl>    <dbl>
#>  1 id1   2018-08-05 honos          2        4        2        3        2
#>  2 id1   2015-10-31 honos         NA        4        2        4        1
#>  3 id1   2009-09-23 honos          2        1        4        1        0
#>  4 id2   2019-06-13 honos          1        1        2        1        2
#>  5 id2   2019-06-10 honos          3        3        0        3        0
#>  6 id2   2003-08-06 honos          3        1        2        4       NA
#>  7 id3   2019-12-17 honos          3        3        3        4        2
#>  8 id3   2016-04-17 honos          1        0        0       NA        4
#>  9 id3   2010-02-13 honos         NA        4        3        2        2
#> 10 id4   2019-05-01 honos          3        2        4        4        4
#> 11 id4   2015-09-01 honos          0        0        2        4        2
#> 12 id4   2013-01-26 honos          3        0        3        3        3
#> 13 id5   2016-08-02 honos          3        3        3        1        3
#> 14 id5   2012-12-05 honos          2        1        1        1        3
#> 15 id5   2000-09-20 honos          2        3        3        0        4
#> # ... with 8 more variables: honos_i6 <dbl>, honos_i7 <dbl>, honos_i8 <dbl>,
#> #   honos_i9 <dbl>, honos_i10 <dbl>, honos_i11 <dbl>, honos_i12 <dbl>,
#> #   honos_i13 <dbl>
```

## Tidy HoNOS data

-   `as_item_desc()`: Add item descriptions
-   `as_severity_desc()`: Add severity descriptions

``` r
honos_long %>% 
  mutate(item_desc = as_item_desc(item, n_items = 13)) %>% 
  mutate(value = as_severity_desc(value, na_level = "I AM A MISSING VALUE"))
#> # A tibble: 39,000 x 6
#>    id    date       measure item  value           item_desc                     
#>    <fct> <date>     <chr>   <fct> <fct>           <fct>                         
#>  1 id1   2018-08-05 honos   1     Mild problem    Item 1: Overactive, aggressiv~
#>  2 id1   2018-08-05 honos   2     Severe to very~ Item 2: Non-accidental self-i~
#>  3 id1   2018-08-05 honos   3     Mild problem    Item 3: Problem drinking or d~
#>  4 id1   2018-08-05 honos   4     Moderately sev~ Item 4: Cognitive problems    
#>  5 id1   2018-08-05 honos   5     Mild problem    Item 5: Physical illness or d~
#>  6 id1   2018-08-05 honos   6     I AM A MISSING~ Item 6: Hallucinations and De~
#>  7 id1   2018-08-05 honos   7     Minor problem   Item 7: Depressed mood        
#>  8 id1   2018-08-05 honos   8     No problem      Item 8: Other mental and beha~
#>  9 id1   2018-08-05 honos   9     Minor problem   Item 9: Relationships         
#> 10 id1   2018-08-05 honos   10    Moderately sev~ Item 10: Activities of daily ~
#> # ... with 38,990 more rows
```

## Resources

-   <https://improvement.nhs.uk/documents/485/Annex_DtE_Mental_health_clustering_tool.pdf>
-   <https://www.rcpsych.ac.uk/events/in-house-training/health-of-nation-outcome-scales>
-   <https://www.nhs.uk/Scorecard/Pages/IndicatorFacts.aspx?MetricId=9308>
-   <https://www.healthylondon.org/resource/mental-health-in-integrated-care-systems/outcome-measures/honos/>

## References

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-Wing1998" class="csl-entry">

Wing, J K, A S Beevor, R H Curtis, S B G Park, S Madden, and A Burns.
1998. “Health of the Nation Outcome Scales (HoNOS).” *British Journal of
Psychiatry* 172 (1): 11–18. <https://doi.org/10.1192/bjp.172.1.11>.

</div>

</div>
