plotRTeX
==============

Converts ggplot2 graphics to PDF using LaTeX. Relies on tikzDevice to create a tikzpicture and then compiles a LaTeX standalone document using PDFLaTeX.
Works on Mac OS, requires PDFLaTeX.

# How to Install

```{r}
devtools::install_github("3wen/plotRTex")
```

# How to

First create a ggplot graphic, then use the `ggplot2_to_pdf()` function to export it as a `tex` file and a `PDF` file.

```{r}
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


# ggplot2_to_pdf(plot = p_2, path = "./", filename = "eco_faceting", width = 15, height = 8)
```