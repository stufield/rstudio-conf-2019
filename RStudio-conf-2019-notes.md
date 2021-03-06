RStudio::conf 2019 Notes
================
Stu Field

-----

# Workshop: What they forgot to tell you about R

**January 15-16, 2019**

## Day 1

### Sessions 1-2

Here are some notes:

  - jack handy:
  - Figuring out library and library structures
      - `.libPaths()`
      - `installed.packages()`
      - `01_explore-libraries_jenny.R`
  - Use relative paths
      - use `here::here()`
      - `fs::path_real()` -\> for following symbolic links
  - Naming things
      - machine readable - no spaces, no non-ascii
      - human readable - stuff.R,
        thisissomesillyexampleofasillyfilename.txt
      - sort nicely - prefix-01, dates yyyy-mm-dd (ISO 8601), common
        sense
  - Safer way to source files than `source()`
      - `callr` package

### Sessions 3-4

Here are some notes:

  - Debugging in R with Jim Hester
      - google the `exact` error message
      - Keyword search comminity.rstudio.com
      - StackOverflow - \[r\] tag
  - Useful functions
      - `traceback()`
      - `print()`, `cat()`, `str()` -\> use str() more than print()
      - `browser()`
      - `debug()`, `trace()`, `recover()`
      - `options(error = traceback)` -\> automatically print
        `traceback()`
      - `options(error = recover)` -\> choose which level of call stack
        to enter browser
      - where inside `browser()` -\> gives call stack
  - Useful functions
      - [github.com/cran](https://github.com/cran) -\> CRAN as github
        for viewing
      - [github.com/search](https://github.com/search)
          - search window: “Error ‘x’ is non-numeric” repo:wch/r-source
      - [github.com/wch/r-source](https://github.com/wch/r-source)
      - lookup package finds source code of a function on GitHub
          - `devtools::install_github("jimhester/lookup")`
  - De-centralized Version Congrol w `GitHub`
      - Multiple users
  - R scripts can be rendered by hitting the “notebook” icon at top
    (next to `knit` icon)
      - This is called “render to markdown”
      - You can then click on the file in GitHub and it’s rendered
        nicely, not as an HTML page.

## Day 2

### Sessions 1-2

  - Setting up `.Rprofile` and `.Renviron`
      - Multiple users
  - GitHub personal access token (PAT)
      - setup and using outside of SSH
  - More detailed version of `.Rpofile`
      - set up personalized startup message
      - `.First` and `.Last`
      - use of the `cowsay` package
  - Maintaining `R`
      - Update packages -\> most recent versions
      - `devtools::upgrade_packages("pkgname")` -\> remembers where pkg
        came from, e.g. github
      - Reinstalling from scrtach
      - `pkgs <- installed.packages(Sys.getenv("R_LIBS_USER")) %>%
        tibble::as_tibble()`
      - Then filter `pkgs` for only pkgs not provided as `base` or
        `recommended`
      - `install.packages("pkgs")`

#### R Infrastructure

  - R Infrastructure (Jeroen Ooms)
      - The `R` universe actually depends on numerous external system
        level libraries
          - `BLAS` and `LAPACK` packages, highly optimized linear
            algebra, FORTRAN
          - `LIBCURL` package, anything networking and server related
          - `PCRE` Peal Compatible Regular Expressions; all things regex
          - `CAIRO` graphical rendering and R graphics device, `x11()`
            and `quartz()`
      - Linking to external libraries
          - `Linux`: Dynamic and managed by `apt` or `yum`
          - `MacOS/Windows`: Static (comes with install)
  - R packages (CRAN and scalability)
      - Some R packages often depend on specific external libraries
      - are linked and available at the `CRAN` webpage for the package
  - Tools, Imaging, Graphics and Vision
      - All quite common external open source libraries
      - e.g. `TESSERACT` performs OCR
      - Vision = detecting shapes in images, following players on soccer
        field, security, etc.
  - Future work
      - `RTOOLS 40` -\> compiled toolchain for building/updating
        external libraries
      - `RHUB` -\> package testing (especially with compiled code),
        esp. cross platform, nice API
      - `devtools::check_rhub()` -\> checks in `RHUB`
  - Setting up a `dev` environment
      - `devtools::has_devel()`
    
      - Use `brew cask install r-app` at command line (*not* `brew
        install r`)
        
          - compiles package binaries
    
      - Try not to use `install.packages()` because you lose the
        installation tool chain and the reproducibility to create your
        environment
    
      -   - `devtools::install_dev()` -\> installs GitHub development
            version if link exists in `URL` field of the DESCRIPTION
            file
          - `devtools::install_github()` -\> install any package from
            GitHub; need repo location
              - `devtools::install_github("r-lib/glue")` -\> install
                latest head
              - `devtools::install_github("r-lib/glue@v1.2.0")` -\>
                install version
              - `devtools::install_github("r-lib/glue@#81")` -\> install
                specific version, not necessarily merged issues
          - `devtools::install_version()` -\> install a specific version
            of a package
          - `devtools::install()` -\> install a local repository; pass
            the path
    
      - Use the `library(x, lib.loc =)` argument when loading library
        from a temporary location

### Sessions 3-4

  - Git Workflows
      - “Fork & clone”
        
            git remote -v
            git remote add upstream https://github.com/jennybc/wtf-2019-rsc.git
            git pull upstream master --ff-only
            git push
  - Major resource
      - [Happy Git](https://happygitwithr.com) by Jenny Brian
  - Branches
      - `Git` and time travel
      - `git checkout -b <branchname> SHA-1`
      - `git revert --no-edit HEAD` -\> 1 commit
      - `git revert --no-edit SHA-1` -\> a specific SHA-1
  - Resetting
      - git reset <file> -\> remove local changes
      - git reset –hard -\> undo all local changes with HEAD if
        *haven’t* committed
      - git reset ~HEAD -\> undo all local changes with HEAD if *have*
        committed (`Git Squash`)
  - Surgical Time Travel
      - `git cherry-pick SHA-1` -\> pull in a specific commit into the
        current branch
      - `git checkout SHA-1 -- <file>` -\> pull out a specific from a
        specific commit into current branch
  - Amend Commits
      - There is a “Amend previous commit” checkbox in the `RStudio` API
      - `git commit --amend -m "message"`
  - Abort Merge
      - `git merge --abort` -\> oh S&\#\*t\! abort the merge and figure
        out a plan
  - Working with lists with `purrr`
      - `str(got_chars, max.level = 2, list.len = 4)`
      - `View(got_chars)`
      - `map_chr(got_chars, "playedBy", .default = NA)` -\> if you have
        missing entries
      - `map_chr(got_chars, list("playedBy", 1L))` -\> if you have \>
        length 1 entries
      - `map_chr(got_chars, list("playedBy", 1L), .default = NA)` -\>
        both challenges
      - `purrr::enframe()` -\> learn about it … might be useful

-----

# `RStudio` Conference

**January 17-18, 2019**

## Day 1

### `RStudio`’s Growth

  - 1700 attendees in 2019
  - 1100 in 2018

### Concept of a “Data Compendium”

  - stratified agreed-upon project structure
  - Include a simple “DESCRIPTION”-like minimal file for dependencies
  - Include a `Dockerfile` to the compendium
  - Karthik Ram: <https://github.com/karthik>
  - `Drake` package -\> data frames in R for (GNU) `Make`
      - instead of `Makefile`
  - `piggyback` package -\> link binaries to specific GitHub versions

### `RStudio` IDE 1.2

  - SQL, Python, D3, Stan compatible -\> all within `RStudio`
  - Python chunks are now non-independent -\> can refer to variables
    from other chunks
  - D3 -\> visualizations -\> ex. `bubbles.js`
  - New Python functionality -\> line-by-line execution
  - New Features:
      - Background jobs -\> don’t have to wait for scrips to finish
          - Use “source as local job” (drop-down menu)
          - Can run multiple simultaneous jobs
      - Auto-installation of missing R packages
          - analysis of R script for libraries not installed -\> appears
            at top of script editor
      - Rmarkdown -\> PowerPoint (drop-down menu)
      - Custom themes -\> `night owlish`

### `RStudio` Package Manager (Sean Lopp)

  - managing central repository
  - automatic versioning
  - CRAN, curated CRAN, local packages, GitHub
  - usage metrics
  - `countdeps::countdeps()`
  - `rstd.io/countdeps`

### `RStudio` Job Launcher

  - launch independent jobs to a server without waiting within the IDE
  - For use with `RStudio` Server product line
  - Future releases of `RStudio` will trickle down various levels

### The `mlflow` platform

  - for managing machine learning workflows
    1.  keeps track of what you did
    2.  bundles your project for reproducibility
    3.  models

### Democratizing `RStudio` API

  - James Blair (Software engineer @ `RStudio`)
  - Using the `plumber` package
      - Create API endpoints for any arbitrary R functions
      - Uses `roxygen` style tags (`#*`) to identify `plumber` specific
        commants/control sequences
      - Functions with `OpenAPI` under the hood
      - Works well with `JSON` and `YAML`
  - Similar to `Shiny Apps` provided to end users
  - Facilitates hand-off between R developers of Shiny Apps to software
    engineers who typically want programmatic access
      - `Plumber` can facilitate this transition
  - The talk <https://github.com/sol-eng/plumber-model>
  - **Example**: created a quick predict model that a Swift App
    developer was easily able to turn into a phone App, where the
    developer had no idea how to use `R`.

### Model representation with `Broom`

  - Alex Hayes

  - No uniform convention or standard for model object shapes

  - `broom::tidy()` -\> returns tibble of model `summary()` -\> rows ==
    parameters
    
      - also has a `CI=` argument

  - `broom::glance()` -\> 1 row tibble about Goodness of Fit

  - `broom::augment()` -\> add information about observations to a
    dataset

  - Tensor flow eager execution
    
      - `Keras` functional API
      - Generative adversarial networks (GANs)
      - Variational auto-encoders (VAEs)

### Karl Broman

  - rewriting a very old R pkg -\> `R/qtl` (quantitative trait loci)
  - Hilarious …
  - Long-term story of an old package, mistakes made, all sorts of
    hilarious what-not-to-do anecdotes

### The `gganimate()` cookbook

  - Thomas Lin Pedersen
  - a grammar of animated graphics -\> extension of `ggplot2`
  - Three types:
      - transitions -\> move fig from one to the other
      - views -\> change viewpoint
      - shadows -\> memory of the previous state to create trails on
        points
  - A [Getting started guide](www.gganimate.com)
  - Interpolates data to ensure animation is smooth -\> corrects frame
    rate on the fly

## Day 2

### A fresh approach to pkg mgmt with `pkg`

  - Gabor Csardi
  - `devtools::install_github("r-lib/pkg")`
  - The `pkg` package has 3 main features:
      - Speedy features: concurrent HTTP requests, building, and
        install. Lazy downloads (don’t install if unnecessary). And
        caching meta data & pkg files
    
      - Safety features: fails on ERROR, conflicts declared prior to
        install, all package dependencies in a private library, detect
        and fail for loaded packages. Also uses sub-process to perform
        install to work around loaded package interferences
    
      - Convenience features: Progress bar, CRAN, BioConductor, GitHub,
        Remotes -\> DESCRIPTION
        
            Remotes:
              r-lib/pkgcache,
              tidyverse/glue@dev
    
      - Everything all in the same call\!
        
          - `pkg::pkg_install("dplyr", lib = "/tmp/lib")` -\> CRAN
          - `pkg::pkg_install("eisa", lib = "/tmp/lib")` -\>
            BioConductor. Same call\!
          - `pkg::pkg_install("r-lib/pkg", lib = "/tmp/lib")` -\>
            GitHub. Same call\!
    
      - Conflicts
        
          - Automatically detected early and trips ERROR
    
      - Safe and Convenient workflows
        
          - Everything set up in a `.Rprofile` and `DESCRIPTION` files
          - Not too convenient yet, so this will eventually change

### Managing Dependencies

  - Jim Hester
  - The zero-dependency myth
  - Concept of `bitrot` -\> gradual change creeps in and code no longer
    works
  - Not all dependencies are equal\! It’s OK to have some.
  - Issues to consider:
      - pkg size
      - install time
      - other dependencies
      - system-level dependencies (e.g. `rJava` is a pain)
  - Must carefully weigh the cost-benefit of adding a particular package
  - There are pitfalls of dependency removal
      - e.g. less testing
      - you’re not as good as you think you are
  - The `itdepends` package
      - helps weight pros-cons of adding a package
      - `itdepends::dep_usage_proj()` -\> for a R project
      - `itdepends::dep_usage_pkg()` -\> for a package
      - `itdepends::dep_weight()`
      - `itdepends::dep_plot_time()` -\> graphical display of install
        time and size
      - `itdepends::dep_plot_size()`
      - `itdepends::dep_locate("purrr")` -\> assist removal, finds all
        instances of a dependency
      - Slides <https://speakerdeck.com/jimhester/it-depends>

### The `vctrs` package

  - Hadley Wickham
  - Type stability
      - rules associated with `c()` and lowest type in concatenation
        1.  types should be stable
        2.  the order should not dictate the result -\> `c(NULL, date)`
            vs `c(data, NULL)`
        3.  the rules should be consistent
      - Main function -\> `vec_c()`
  - Alternative:
      - `vec_typeof()`
  - Recycling rules are strange
      - `c(1, 2) + c(1, 2, 3)`
  - New rules for vector classes
  - Website: <https://vctrs.r-lib.org/>

### Tidy Eval in Context

  - Jenny Bryan
  - What is tidy-eval?
      - toolkit for meta-programming (meta-programming)
          - NSE, naked variable names, etc.
      - tidy-eval powers things like `quosures`
  - NSE
      - manipulate either the expression before it’s executed or the
        environment chain
  - Matching pairs
      - `rlang::enquo()` -\> `!!`
      - `:=`
  - Lionel Henry
      - Tidy Eval <https://tidyeval.tidyverse.org>

### Selecting and Doing Tidy Eval

  - Lionel Henry
  - Two flavours:
    1.  Selecting verbs -\> `dplyr::select()`
    2.  Action verbs -\> `dplyr::mutate()`
  - Quoting -\> delays computation, then modify and continue
      - “promise evaluation”???
  - `dplyr::group_by()` is actually an action verb
      - the `dplyr::group_by_at()` verb is the selection verb equivalent
  - Three challenges to tidy-eval
      - user selections are made
      - modifying selections
      - passing selections
  - Easiest way of doing tidy-eval is to take advantage of passing the
    `...`

-----

### FiraCode

Fonts in editor: <https://github.com/tonsky/FiraCode>

## Fin\!

-----

Created by [Rmarkdown](https://github.com/rstudio/rmarkdown) (v1.11) and
R version 3.5.2 (2018-12-20).
