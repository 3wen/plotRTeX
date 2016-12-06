\name{ggplot2_to_pdf}
\alias{ggplot2_to_pdf}
\title{
ggplot2 graphics to PDF using LaTeX
}
\description{
Converts a ggplot2 graphic into LaTeX-friendly format (tikzpicture) and runs PDFLaTeX on a self-contained LaTeX document to obtain the graphic in a PDF format.
}
\usage{
ggplot2_to_pdf(plot, interpreter = "pdflatex", path = "./", filename, keep_tex = FALSE, width = 15, height = 15, verbose = FALSE, ignore.stdout = TRUE)
}

\arguments{
  \item{plot}{
ggplot2 object
}
\item{interpreter}{
which interpreter to use (default to pdflatex)
}
  \item{path}{
path to file that will be created (must not contain filename)
}
  \item{filename}{
name of the file (without extension)
}
  \item{keep_tex}{
if FALSE (default), removes TeX files
}

  \item{width}{
width: plot width
}
  \item{height}{
height: plot height
}
  \item{verbose}{
verbose: a logical value indicating whether diagnostic messages are printed when measuring dimensions of strings. Defaults to TRUE in interactive mode only, to FALSE otherwise.
}
  \item{ignore.stdout}{
ignore.stdout: a logical (not NA) indicating whether messages written to 'stdout' or 'stderr' should be ignored.
}
}
\value{
ggplot2_to_pdf() returns no values.
}
\author{
Ewen Gallic <ewen.gallic@gmail.com>
}
\note{
For use with Mac OS.
}
\examples{
economics_long <- 
mutate(economics_long, variable_tex = factor(variable,
                        levels = c("pce", "pop", "psavert", "uempmed", "unemploy"),
                        labels = c("$PCE_t$", "$N_t$", "$r_t$", "$\\bar{s}_t$", "$s_t$")))



p <- 
  ggplot(economics_long, aes(x = date, y = value01, colour = variable_tex, linetype = variable_tex)) +
  geom_line(size = 2) +
  scale_colour_discrete("Variable") +
  scale_linetype_discrete("Variable") +
  xlab("") + ylab("") +
  theme(text = element_text(size = 20),
        panel.background = element_rect(fill = NA),
        panel.margin = unit(1, "lines"),
        panel.grid.major = element_line(colour = "grey90"),
        panel.grid.minor = element_blank(),
        plot.title = element_text(hjust = 0, size = rel(1.3), face = "bold"),
        plot.margin = unit(c(1, 1, 1, 1), "lines"),
        # Axes
        axis.line = element_line(colour = "grey60"),
        axis.text = element_text(colour = "#7F7F7F"),
        axis.title = element_text(),
        # Legende
        legend.text = element_text(size = rel(1.1)),
        legend.title = element_text(size = rel(1.1)),
        legend.key = element_rect(fill = NA),
        legend.key.size = unit(2, "lines"),
        legend.key.width = unit(2.5, "lines"),
        legend.position = "right", 
        legend.box = "vertical",
        legend.direction = "vertical",
        # Faceting
        strip.background = element_rect(fill=NA, colour = NA),
        strip.text = element_text(size = rel(1.1))
  )
  
# ggplot2_to_pdf(plot = p, path = "./", filename = "eco", width = 15, height = 8)

# Using facetting

p_2 <- 
  ggplot(economics_long, aes(x = date, y = value01, colour = variable_tex, linetype = variable_tex)) +
  facet_wrap(~variable_tex) +
  geom_line(size = 2) +
  scale_colour_discrete("Variable") +
  scale_linetype_discrete("Variable") +
  xlab("") + ylab("") +
  theme(text = element_text(size = 20),
        panel.background = element_rect(fill = NA),
        panel.margin = unit(1, "lines"),
        panel.grid.major = element_line(colour = "grey90"),
        panel.grid.minor = element_blank(),
        plot.title = element_text(hjust = 0, size = rel(1.3), face = "bold"),
        plot.margin = unit(c(1, 1, 1, 1), "lines"),
        # Axes
        axis.line = element_line(colour = "grey60"),
        axis.text = element_text(colour = "#7F7F7F"),
        axis.title = element_text(),
        # Legende
        legend.text = element_text(size = rel(1.1)),
        legend.title = element_text(size = rel(1.1)),
        legend.key = element_rect(fill = NA),
        legend.key.size = unit(2, "lines"),
        legend.key.width = unit(2.5, "lines"),
        legend.position = "bottom", 
        legend.box = "vertical",
        legend.direction = "horizontal",
        # Faceting
        strip.background = element_rect(fill=NA, colour = NA),
        strip.text = element_text(size = rel(1.1))
  )


# ggplot2_to_pdf(plot = p_2, path = "./", filename = "eco_faceting",width = 15, height = 8)
}