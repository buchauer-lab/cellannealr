# Cellannealr

<!-- badges: start -->
[![R-CMD-check](https://github.com/buchauer-lab/cellannealr/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/buchauer-lab/cellannealr/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

Cellannealr is a R wrapper for the python based [cellanneal](https://github.com/LiBuchauer/cellanneal) deconvolution tool. So far, it contains only one function (`run_cellanneal()`) which creates a gene dictionary and performs deconvolution. 

## Installation

```
# install.packages("devtools")
devtools::install_github("buchauer-lab/cellannealr")
```

During the first installation, a conda environment named "cellannelr-internal" is created and the python dependencies are automatically installed in this environment.  

