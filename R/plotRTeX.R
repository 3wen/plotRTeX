library(dplyr)
library(tidyr)
library(ggplot2)
library(tikzDevice)
 
# Exports ggplot2 to a tex and then runs pdflatex to a standalone tex file
# @plot : ggplot2 object
# @path_to_latex: path to LaTeX folder (default to "/Library/TeX/texbin/")
# @interpreter : which interpreter to use (default to pdflatex)
# @path : path to file that will be created (must not contain filename)
# @filename: name of the file (without extension)
# @keep_tex: if FALSE (default), removes TeX files
# @width, height: plot dimensions
# @verbose: a logical value indicating whether diagnostic messages are printed when measuring dimensions of strings. Defaults to TRUE in interactive mode only, to FALSE otherwise.
# @ignore.stdout: a logical (not NA) indicating whether messages written to 'stdout' or 'stderr' should be ignored.
# path <- "../images/" ; filename <- "data" ; width = 15 ; height = .75*width
ggplot2_to_pdf <- 
  function(plot, path_to_latex = "/Library/TeX/texbin/", interpreter = "pdflatex", path = "./",
           filename, keep_tex = FALSE, width = 15, height = 15, verbose = FALSE, ignore.stdout = TRUE){
    content <- paste0("\\documentclass{standalone}
                      \\usepackage{amssymb}
                      \\usepackage{pgfplots}
                      \\usetikzlibrary{pgfplots.groupplots}
                      \\definecolor{mygrey2}{RGB}{127,127,127}
                      \\definecolor{deepblue}{RGB}{0,129,188}
                      \\definecolor{deepgreen}{RGB}{0,157,87}
                      \\definecolor{deepred}{RGB}{238,50,78}
                      \\begin{document}
                      
                      \\input{",
                      path, filename,
                      "_content.tex}
                      
                      \\end{document}")
    
    # Le fichier qui va importer le graphique au format tex pour le compiler en pdf
    fileConn<-file(paste0(path, filename, ".tex"))
    writeLines(content, fileConn)
    close(fileConn)
    
    # Exportation du graphique en tex
    tikz(file = paste0(path, filename, "_content.tex"), width = width, height = height, verbose = verbose)
    print(plot)
    dev.off()
    
    # Executer le fichier tex pour obtenir le pdf
    system(paste0(path_to_latex, interpreter, " -shell-escape -synctex=1 -interaction=nonstopmode  ",
                  path, filename, ".tex"), ignore.stdout = TRUE)
    system(paste0("mv ", filename, ".pdf ", path))
    system(paste0("rm ", filename, ".aux"))
    system(paste0("rm ", filename, ".log"))
    system(paste0("rm ", filename, ".synctex.gz"))
    if(!keep_tex){
      system(paste0("rm ", path, filename, ".tex"))
      system(paste0("rm ", path, filename, "_content.tex"))
    }
}

