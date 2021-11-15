## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.path = "man/figures/",
  dpi = 300,
  fig.width = 5,
  fig.height = 3
)

## ----setup--------------------------------------------------------------------
library(cusumcharter)
library(ggplot2)

## -----------------------------------------------------------------------------
test_vec <- c(1,1,2,3,5,7,11,7,5,7,8,9,5)
test_vec

## ----baseplot, fig.width=5, fig.height=3--------------------------------------
test_vec <- c(1,1,2,3,5,7,11,7,5,7,8,9,5)
variances <- cusum_single(test_vec)
p <- qplot(y = variances)
p <- p + geom_line()
p + geom_hline(yintercept = 0)
p


## ----singledf-----------------------------------------------------------------
variance_df <- cusum_single_df(test_vec)
variance_df

## ----baseplot2,fig.width=5, fig.height=3--------------------------------------

p <- qplot(y = variance_df$x)
p <- p + geom_line()
p <- p + geom_hline(yintercept = variance_df$target)
p

## ----cusumcontrol-------------------------------------------------------------
cs_data <- cusum_control(test_vec)
cs_data

## ----cusumcontrolplot,fig.width=5, fig.height=3-------------------------------
cusum_control_plot(cs_data,xvar = obs)

## ----controlplotshow,fig.width=5, fig.height=3--------------------------------
cusum_control_plot(cs_data,xvar = obs, show_below = TRUE)

## ----facetcontrolplots,fig.width=5, fig.height=3------------------------------
library(dplyr)
library(ggplot2)
library(cusumcharter)

testdata <- tibble::tibble(
N = c(-15L,2L,-11L,3L,1L,1L,-11L,1L,1L,
2L,1L,1L,1L,10L,7L,9L,11L,9L),
metric = c("metric1","metric1","metric1","metric1","metric1",
"metric1","metric1","metric1","metric1","metric2",
"metric2","metric2","metric2","metric2","metric2",
"metric2","metric2","metric2"))

datecol <- as.Date(c("2021-01-01","2021-01-02", "2021-01-03", "2021-01-04" ,
             "2021-01-05", "2021-01-06","2021-01-07", "2021-01-08",
             "2021-01-09"))

testres <- testdata %>%
  dplyr::group_by(metric) %>%
  dplyr::mutate(cusum_control(N)) %>%
  dplyr::ungroup() %>%
  dplyr::group_by(metric) %>%
  dplyr::mutate(report_date = datecol) %>%
  ungroup()


p5 <- cusum_control_plot(testres,
                         xvar = report_date,
                         show_below = TRUE,
                         facet_var = metric,
                         title_text = "Highlights above and below control limits")
p5


