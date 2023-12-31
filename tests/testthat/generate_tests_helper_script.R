if(FALSE){
# Make sure that nothing bad happens if the file is accidentally sourced
library(MatrixGenerics)

matrixStats_functions <- sort(
  grep(
    "^(col|row)", 
    getNamespaceExports("matrixStats"), 
    value = TRUE))


fnc_list <- lapply(matrixStats_functions, function(fnc_name) eval(parse(text = paste0("matrixStats::", fnc_name))))

default_args <-  unlist(lapply(lapply(fnc_list, function(fnc) as.list(formals(fnc))), function(args){
  lapply(args, function(arg){
    if(is.vector(arg)) as.character(arg)
    else if(is.name(arg)) rlang::as_string(arg)
    else if(is.null(arg)) "NULL"
    else if(is.call(arg)) paste0(deparse(arg), collapse = ", ")
    else "NO IDEA"
  })
}))

parsed_matrixStats_api <- data.frame(function_name = unlist(lapply(seq_along(fnc_list), function(idx) 
  rep(matrixStats_functions[[idx]], length((formals(fnc_list[[idx]])))))),
           function_arg = unlist(lapply(fnc_list, function(fnc) names(formals(fnc)))),
           default_value = default_args)

parsed_matrixStats_api[
  !duplicated(parsed_matrixStats_api[, c("function_arg", "default_value")]), ]

function_args <- list(x = list("mat"),
                      rows = list(NULL, 1:3),
                      cols = list(NULL, 2),
                      value = list(TRUE, FALSE, 0),
                      na.rm = list(TRUE, FALSE),
                      dim. = list("dim(mat)", "c(12L, 8L)"),
                      useNames = list(TRUE, FALSE),
                      idxs = list(1, 2:3),
                      lag = list(1, 3),
                      differences = list(1, 2),
                      diff = list(1, 2),
                      trim = list(0, 1/3, 0.5),
                      lx = list("mat"),
                      col_center = list("colMeans2(mat, na.rm=TRUE)", "NULL"),
                      row_center = list("rowMeans2(mat, na.rm=TRUE)", "NULL"),
                      constant = list(1.4826, 5),
                      which = list(2, 1),
                      method = list("'direct'", "'expSumLog'"),
                      probs = list("seq(from = 0, to = 1, by = 0.25)", "0.1"),
                      type = list(7L, 3L),  # Type of quantile estimator see  `?quantile`
                      drop = list(TRUE, FALSE),
                      ties.method = list("'max'", "'first'", "'dense'"),
                      preserveShape = list(FALSE, TRUE),
                      values = list(0, c(0, 1)),
                      w = list(1:16, NULL),
                      X = list("mat"),
                      S = list("S"),
                      FUN = list("rowMeans", "rowVars", "colMeans", "colVars"),
                      W = list("NULL"),
                      tFUN = list("FALSE"))

extra_statements <- list(
  colAvgsPerRowSet = "S <- matrix(1:nrow(mat), ncol = 2)",
  rowAvgsPerColSet = "S <- matrix(1:ncol(mat), ncol = 2)",
  colTabulates = "mat <- array(suppressWarnings(as.integer(mat)), dim(mat))",
  rowTabulates = "mat <- array(suppressWarnings(as.integer(mat)), dim(mat))",
  colOrderStats = "mat[is.na(mat)] <- 4.1",
  rowOrderStats = "mat[is.na(mat)] <- 4.1",
  rowWeightedMeans = "mat <- array(mat, dim(t(mat)))",
  rowWeightedMedians = "mat <- array(mat, dim(t(mat)))",
  rowWeightedMads = "mat <- array(mat, dim(t(mat)))",
  rowWeightedSds = "mat <- array(mat, dim(t(mat)))",
  rowWeightedVars = "mat <- array(mat, dim(t(mat)))"
)

# matrixStats recommends colAnyNAs() / colAnyNAs() over 
# colAnyMissings() / rowAnyMissings(), so the latter aren't implemented.
testable_functions <- setdiff(
  matrixStats_functions,
  c("colAnyMissings", "rowAnyMissings"))

all_test_that_blocks <- sapply(testable_functions, function(fnc_name) {
  can_load <- tryCatch({eval(parse(text = fnc_name))}, error = function(error) error)
  skip <- if(is(can_load, "error")){
    paste0('\tskip("', fnc_name, ' not yet implemented")')
  }else{
    ""
  }

  generic_tests <- paste0("\t.check_formals(\"", fnc_name, "\")\n")

  fnc_ms <- eval(parse(text = paste0("matrixStats::", fnc_name)))
  default_args <- as.list(formals(fnc_ms))
  arg_missing <- setdiff(names(default_args)[sapply(default_args, function(arg) is.name(arg))], "...")
  filled_in_args <- function_args[arg_missing]
  # Need special handling of colAvgsPerRowSet / rowAvgsPerColSet
  if (fnc_name == "colAvgsPerRowSet") {
    filled_in_args[["FUN"]] <- filled_in_args[["FUN"]][
      sapply(filled_in_args[["FUN"]], function(x) grepl("^col", x))]
  } else if (fnc_name == "rowAvgsPerColSet") {
    filled_in_args[["FUN"]] <- filled_in_args[["FUN"]][
      sapply(filled_in_args[["FUN"]], function(x) grepl("^row", x))]
  }
  filled_in_args_str <- lapply(seq_along(arg_missing), function(idx) paste0(arg_missing[idx], " = ", filled_in_args[[idx]]))
  # First call without any additional argument
  default_tests <- paste0(sapply(seq_len(max(lengths(filled_in_args_str))), function(idx) {
    argument_string <- paste0(sapply(filled_in_args_str, function(args) {
      args[(idx - 1) %% length(args) + 1]
    }), collapse = ", ")
    line1 <- paste0("mg_res_def_", idx, " <- ", fnc_name, "(", argument_string, ")")
    line2 <- paste0("ms_res_def_", idx, " <- matrixStats::", fnc_name, "(", argument_string, ")")
    line3 <- paste0("expect_equal(mg_res_def_", idx, ", ms_res_def_", idx, ")")
    paste0("\t", line1, "\n\t", line2, "\n\t", line3)
  }), collapse = "\n")
  
  # Now all combinations of parameters
  arg_names <- setdiff(names(default_args), "...")
  arg_names_lookup <- arg_names
  arg_names_lookup[arg_names_lookup == "center"] <- paste0(substr(fnc_name, 1, 3), "_center")
  filled_in_args <- function_args[arg_names_lookup]
  # Need special handling of colAvgsPerRowSet / rowAvgsPerColSet
  if (fnc_name == "colAvgsPerRowSet") {
    filled_in_args[["cols"]][[2]] <- 1:2
    filled_in_args[["FUN"]] <- filled_in_args[["FUN"]][
      sapply(filled_in_args[["FUN"]], function(x) grepl("^col", x))]
  } else if (fnc_name == "rowAvgsPerColSet") {
    filled_in_args[["FUN"]] <- filled_in_args[["FUN"]][
      sapply(filled_in_args[["FUN"]], function(x) grepl("^row", x))]
  } else if(fnc_name == "colWeightedMads") {
    filled_in_args[[paste0(substr(fnc_name, 1, 3), "_center")]][[2]] <- "rep(6, ncol(mat))"
  } else if(fnc_name == "rowWeightedMads") {
    filled_in_args[[paste0(substr(fnc_name, 1, 3), "_center")]][[2]] <- "rep(6, nrow(mat))"
  }
  filled_in_args_str <- lapply(seq_along(arg_names), function(idx) paste0(arg_names[idx], " = ", filled_in_args[[idx]]))
  param_tests <- paste0(sapply(seq_len(max(lengths(filled_in_args_str))), function(idx){
    argument_string <-   paste0( sapply(filled_in_args_str, function(args) {
      args[(idx - 1) %% length(args) + 1]
    }), collapse = ", ")
    paste0("\tmg_res_", idx, " <- ", fnc_name, "(", argument_string, ")\n",
           "\tms_res_", idx, " <- matrixStats::", fnc_name, "(", argument_string, ")\n",
           "\texpect_equal(mg_res_", idx, ", ms_res_", idx, ")")
  }), collapse = "\n\n")

  extra_stat <- ""
  if(fnc_name %in% names(extra_statements)){
    # Do special stuff for those functions
    extra_stat <- paste0(paste0("\t", extra_statements[[fnc_name]], collapse = "\n"), "\n")
  }
  
  paste0('test_that("', fnc_name,  ' works", {\n',
         skip, "\n",
         generic_tests, "\n", 
         extra_stat, 
         default_tests, "\n\n", 
         param_tests, "\n})\n")
})

preamble <- 
"# Generated by tests/testthat/generate_tests_helper_script.R
# do not edit by hand


# Make a matrix with different features
mat <- matrix(rnorm(16 * 6), nrow = 16, ncol = 6, dimnames = list(letters[1:16], LETTERS[1:6]))
mat[1,1] <- 0
mat[2,3] <- NA
mat[3,3] <- -Inf
mat[5,4] <- NaN
mat[5,1] <- Inf
mat[6,2] <- 0
mat[6,5] <- 0


.check_formals <- function(fnc_name)
{
    if (fnc_name == \"rowRanges\")
        return(invisible(NULL))

    matrixStats_fun <- eval(parse(text=paste0(\"matrixStats::\", fnc_name)))
    MatrixGenerics_fun <- eval(parse(text=paste0(\"MatrixGenerics::\", fnc_name)))
    MatrixGenerics_matrixStats_method <- eval(parse(text=paste0(\"MatrixGenerics:::.matrixStats_\", fnc_name)))

    matrixStats_formals <- formals(matrixStats_fun)
    MatrixGenerics_matrixStats_method_formals <- formals(MatrixGenerics_matrixStats_method)
    if (fnc_name %in% c(\"rowMeans2\", \"colMeans2\", \"rowVars\", \"colVars\", \"rowSds\", \"colSds\"))
        matrixStats_formals$refine <- NULL
    if (fnc_name %in% c(\"rowQuantiles\", \"colQuantiles\"))
        matrixStats_formals$digits <- NULL
    expect_identical(MatrixGenerics_matrixStats_method_formals, matrixStats_formals)

    MatrixGenerics_formals <- formals(MatrixGenerics_fun)
    MatrixGenerics_matrixStats_method_formals <- formals(MatrixGenerics_matrixStats_method)
    MatrixGenerics_matrixStats_method_formals$dim. <- NULL
    if (fnc_name %in% c(\"rowProds\", \"colProds\"))
        MatrixGenerics_matrixStats_method_formals$method <- NULL
    if (fnc_name %in% c(\"rowRanks\", \"colRanks\"))
        MatrixGenerics_matrixStats_method_formals$ties.method <- MatrixGenerics_formals$ties.method <- NULL
    if (fnc_name == \"colRanks\")
        MatrixGenerics_matrixStats_method_formals$preserveShape <- NULL
    expect_identical(MatrixGenerics_matrixStats_method_formals, MatrixGenerics_formals)
    invisible(NULL)
}


"

writeLines(paste0(preamble, paste0(all_test_that_blocks, collapse="\n\n")), "tests/testthat/test-api_compatibility.R")
}

