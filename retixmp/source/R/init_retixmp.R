#' ixmp core
#'
#' This page provides documentation for the ixmp-R-reticulate implementation.
#' The package is sourcing the ixmp-core Python package, translating it with the R 'reticulate' package.
#'
#' Main features:
#'
#'  - a platform core linked to a database instance,
#'
#'  - integration with the |MESSAGEix| Integrated Assessment model
#'    and other numerical models
#'
#'  - for full documentation of the Python functions, use py_help(<package>$<class>)
#' @name retixmp
NULL

#' @import reticulate
NULL

.onAttach = function(libname, pkgname){
  packageStartupMessage(
    sprintf("Loaded retixmp v%s. See ?retixmp for help, citation(\"retixmp\") for use in publication.\n",
            utils::packageDescription(pkgname)$Version) )
}

#utils::globalVariables(c("ixmp_path"))

ixmp <- NULL

.onLoad <- function(libname, pkgname) {

  ModelConfig <<- list(default = list(model_file = gsub("/","\\\\" , file.path( "." , "{model}.gms") ),
                                      inp = gsub("/","\\\\" , file.path( ".", "{model}_in.gdx") ),
                                      outp = gsub("/","\\\\" , file.path(".", "{model}_out.gdx") ),
                                      args = gsub("/","\\\\" , paste('--in=',file.path( ".", "{model}_in.gdx"),' --out=',file.path(".", "{model}_out.gdx")))))

  ixmp <<- reticulate::import('ixmp', delay_load = TRUE)

}
