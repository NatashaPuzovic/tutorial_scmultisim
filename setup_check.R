# Run this once before the tutorial:  Rscript setup_check.R
# It checks that all packages load and runs a tiny simulation (about 10 s).

pkgs <- c("scMultiSim", "SingleCellExperiment", "scuttle", "scran",
          "ape", "Rtsne", "MASS", "rmarkdown", "knitr")

ok <- vapply(pkgs, requireNamespace, logical(1), quietly = TRUE)
for (p in pkgs) cat(sprintf("%-22s %s\n", p,
                            if (ok[p]) as.character(packageVersion(p)) else "MISSING"))
if (!all(ok)) stop("Missing packages: ", paste(pkgs[!ok], collapse = ", "),
                   "\nSee README.md, section 'Setup'.")

suppressPackageStartupMessages(library(scMultiSim))
data(GRN_params_100)
invisible(capture.output(res <- sim_true_counts(list(
  rand.seed = 1L, GRN = GRN_params_100, num.genes = 120L, num.cells = 300L,
  tree = Phyla3(), discrete.cif = TRUE, num.cifs = 20L))))
stopifnot(identical(dim(res$counts), c(120L, 300L)))
cat("\nAll good: scMultiSim simulated", nrow(res$counts), "genes x",
    ncol(res$counts), "cells. You are ready for the tutorial.\n")
