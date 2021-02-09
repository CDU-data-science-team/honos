
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

## Examples

``` r
library(honos)
# library(tidyverse)
```

### Datasets

The package comes with a simulated datasets of HoNOS scores (13-items)
that is available in “long” as well as “wide” format.

#### Long format

-   `id`: Unique identifier
-   `date`: Date variable
-   `measure`: Description of measure
-   `item`: Number of HoNOS item
-   `value`: HoNOS score

``` r
# Show fist 5 ids
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
#> # … with 185 more rows
```

#### Wide format

-   `id`: Unique identifier
-   `date`: Date variable
-   `measure`: Description of measure
-   `honos_i1` to `honos_i13`: HoNOS score for each item

``` r
# Show fist 5 ids
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
#> # … with 8 more variables: honos_i6 <dbl>, honos_i7 <dbl>, honos_i8 <dbl>,
#> #   honos_i9 <dbl>, honos_i10 <dbl>, honos_i11 <dbl>, honos_i12 <dbl>,
#> #   honos_i13 <dbl>
```

#### Tidy HoNOS data

-   `as_item_desc()`: Add item descriptions (Fot 13 and 18 item versions
    of the HoNOS)
-   `as_severity_desc()`: Add severity descriptions (Values ‘0’ to ‘4’)
-   `as_i8_desc()`: Add description for item 8 types (Type ‘A’ to ‘J’)

``` r
honos_long %>% 
  dplyr::mutate(item_desc = as_item_desc(item, n_items = 13)) %>% 
  dplyr::mutate(value = as_severity_desc(value, na_level = "I AM A MISSING VALUE"))
#> # A tibble: 39,000 x 6
#>    id    date       measure item  value           item_desc                     
#>    <fct> <date>     <chr>   <fct> <fct>           <fct>                         
#>  1 id1   2018-08-05 honos   1     Mild problem    Item 1: Overactive, aggressiv…
#>  2 id1   2018-08-05 honos   2     Severe to very… Item 2: Non-accidental self-i…
#>  3 id1   2018-08-05 honos   3     Mild problem    Item 3: Problem drinking or d…
#>  4 id1   2018-08-05 honos   4     Moderately sev… Item 4: Cognitive problems    
#>  5 id1   2018-08-05 honos   5     Mild problem    Item 5: Physical illness or d…
#>  6 id1   2018-08-05 honos   6     I AM A MISSING… Item 6: Hallucinations and De…
#>  7 id1   2018-08-05 honos   7     Minor problem   Item 7: Depressed mood        
#>  8 id1   2018-08-05 honos   8     No problem      Item 8: Other mental and beha…
#>  9 id1   2018-08-05 honos   9     Minor problem   Item 9: Relationships         
#> 10 id1   2018-08-05 honos   10    Moderately sev… Item 10: Activities of daily …
#> # … with 38,990 more rows
```

#### Calculate lagged scores

-   `lag_honos()`: Calculate lagged scores based on a date variable and
    calculate change labels (e.g., “high to low,” or ‘deterioration’)
-   `as_change_label()`: Creates change labels for repeated measures of
    the HoNOS. This is an optional argument in the `lag_honos()`
    function or can be used separately

``` r
honos_wide %>% 
  dplyr::rename(client_id = id, assessment_date = date) %>% 
  honos::lag_honos(id_var = client_id, 
                   date_var = assessment_date, 
                   change_label = "deterio_improve")
#> # A tibble: 26,000 x 10
#> # Groups:   client_id [1,000]
#>    client_id assessment_date measure lag1assessment_… item  honos lag1honos
#>    <fct>     <date>          <chr>   <date>           <fct> <dbl>     <dbl>
#>  1 id1       2015-10-31      honos   2009-09-23       1        NA         2
#>  2 id1       2015-10-31      honos   2009-09-23       6         4         1
#>  3 id1       2015-10-31      honos   2009-09-23       7         2         4
#>  4 id1       2015-10-31      honos   2009-09-23       8         4         1
#>  5 id1       2015-10-31      honos   2009-09-23       9         1         0
#>  6 id1       2015-10-31      honos   2009-09-23       10        0         4
#>  7 id1       2015-10-31      honos   2009-09-23       11        4         0
#>  8 id1       2015-10-31      honos   2009-09-23       12        4         1
#>  9 id1       2015-10-31      honos   2009-09-23       13        4         0
#> 10 id1       2015-10-31      honos   2009-09-23       2         4         3
#> # … with 25,990 more rows, and 3 more variables: honos_change <dbl>,
#> #   honos_date_diff <drtn>, honos_change_label <fct>
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
