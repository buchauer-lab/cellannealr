test_that("run_cellanneal works", {
  mix <- readRDS("testdata/testmix.rds")
  sig <- readRDS("testdata/testsig.rds")
  expect_no_error(run_cellanneal(mixture = mix,
                                 signature = sig,
                                 mix_index = "gene",
                                 sig_index = "index"))
  }
  )


test_that("errors are raised", {
  mix <- readRDS("testdata/testmix.rds")
  sig <- readRDS("testdata/testsig.rds")
  expect_error(run_cellanneal(mixture = mix,
                                 signature = sig,
                                 mix_index = "geneabc",
                                 sig_index = "index"),
                 regexp = "_index not found in")

  expect_error(run_cellanneal(mixture = mix,
                              signature = sig,
                              mix_index = "gene",
                              sig_index = "indexabc"),
               regexp = "_index not found in")

  expect_error(run_cellanneal(mixture = rbind(mix, mix),
                              signature = sig,
                              mix_index = "gene",
                              sig_index = "index"),
               regexp = "contains duplicated gene ")

  expect_error(run_cellanneal(mixture = mix,
                              signature = rbind(sig, sig),
                              mix_index = "gene",
                              sig_index = "index"),
               regexp = "contains duplicated gene ")

  })
