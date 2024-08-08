#' Wrapper for the cellanneals make_gene_dictionary and deconvolve functions
#'
#' Takes a mixture (bulk with gene column and several samples) and a signature (sc with gene colunm and several celltypes) and estimates cell-fractions in mixutre
#'
#' @param mixture A dataframe containing one column with gene names and several samples. Gene names must be unique.
#' @param signature A dataframe containg one columns with gene names and one for each cell type. Gene names must be unique.
#' @param sig_index Name of the gene name column in signature
#' @param mix_index Name of the gene name column in mixture
#' @param disp_min Minimum scaled dispersion. Cellanneal parameter
#' @param bulk_min Minimum allowed expression in mixture. Cellanneal parameter
#' @param bulk_max Maximum allowed expression in mixture. Cellanneal parameter
#' @param maxiter Maximum nbumber of iterations fpr dual annealing. Cellanneal parameter
#'
#' @return A dataframe containing cell-type proportions, Spearmans, and Pearsons rho for each sample.
#' @export
#'
#' @examples
#' \dontrun{
#' run_cellanneal(mix, sig, sig_index = "index", mix_index = "gene")
#' }



run_cellanneal <- function(mixture,
                           signature,
                           sig_index = "gene",
                           mix_index = "gene",
                           disp_min = 0.5,
                           bulk_min=1e-5,
                           bulk_max = 0.01,
                           maxiter){
  # Check imputs
  stopifnot("mix_index not found in mixture" = mix_index %in% colnames(mixture))
  stopifnot("sig_index not found in signature" = sig_index %in% colnames(signature))
  # Check if signature and mixture have no duplicated gene names
  stopifnot("signature contains duplicated gene names" = length(signature[[sig_index]]) == length(unique(signature[[sig_index]])))
  stopifnot("mixture contains duplicated gene names" = length(mixture[[mix_index]]) == length(unique(mixture[[mix_index]])))

  reticulate::use_condaenv("cellannealr-internal")
  ca <- reticulate::import("cellanneal")
  pd <- reticulate::import("pandas")

  # Convert imput data
  mix_py <- reticulate::r_to_py(mixture)
  sig_py <- reticulate::r_to_py(signature)
  sig_py <- sig_py$set_index(sig_index)
  mix_py <- mix_py$set_index(mix_index)

  # Run cellanneal
  gene_dict <- ca$make_gene_dictionary(sig_py,
                                       mix_py,
                                       disp_min = disp_min,
                                       bulk_min = bulk_min,
                                       bulk_max = bulk_max
                                       )

  deconv <- ca$deconvolve(sig_py,
                          mix_py,
                          maxiter = as.integer(1000),
                          gene_dict = gene_dict)

  dplyr::as_tibble(deconv, rownames = "Sample")
  }
