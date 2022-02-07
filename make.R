#' IPBES Sustainable Use Assessment - Figure Chapter 3 - Global Fish Stocks
#' 
#' This R script reproduces the Figure 'Global Fish Stock' of the chapter 3 
#' of the IPBES Sustainable Use Assessment. This figure shows the evolution of
#' the estimated abundance of global fish stocks.
#' 
#' @author Nicolas Casajus <nicolas.casajus@fondationbiodiversite.fr>
#' @date 2022/02/07



## Install `remotes` package ----

if (!("remotes" %in% installed.packages())) install.packages("remotes")


## Install required packages (listed in DESCRIPTION) ----

remotes::install_deps(upgrade = "never")


## Load project dependencies ----

devtools::load_all(".")


## Make figure ----

tab <- read.csv(here::here("data", "state_space_results_01_07_2019.csv"))

regions <- c("European Union non Mediterranean", "Mediterranean-Black Sea", 
             "Atlantic Ocean Tunas", "Pacific Ocean Tunas")

lables <- c("B. EU non Mediterranean", "C. Mediterranean-Black Sea", 
            "D. Atlantic Ocean Tunas", "E. Pacific Ocean Tunas")
vars <- c("UvU", "BvB")
cols <- c("#008B65", "#F1541B")

# png(here::here("figures", "ipbes-su-chap3-fish_stock.png"), 
      # width = 21, height = 10.5, units = "cm", pointsize = 12, res = 600)

svg(here::here("figures", "ipbes-su-chap3-fish_stock.svg"), 
    width = 21, height = 10.5, pointsize = 14, family = "serif", bg = "transparent")

layout(matrix(c(5, 5, 1, 2, 5, 5, 3, 4), byrow = TRUE, ncol = 4))

for (j in 1:length(regions)) {
  
  mat <- tab[tab$region == regions[j], ]
  
  if (j == 1) mar <- c(0.05, 1.05, 1.05, 0.05)
  if (j == 2) mar <- c(0.05, 0.05, 1.05, 1.05)
  if (j == 3) mar <- c(1.05, 1.05, 0.05, 0.05)
  if (j == 4) mar <- c(1.05, 0.05, 0.05, 1.05)
  
  par(family = "serif", fg = "#333333", col = "#333333", col.axis = "#333333", 
      mar = mar, new = FALSE)
  
  plot(0, xlim = range(tab$year), ylim = c(0, 3), bty = "n", axes = FALSE, ann = FALSE)
  abline(v = seq(1975, 2015, by = 10), h = seq(0, 3, by = .5), col = "lightgray", lty = "dotted", lwd = .35)
  
  abline(h = 1, col = "#666666", lwd = 1.5)
  
  par(xpd = TRUE)
  for (i in 1:length(vars)) {
    dat <- mat[mat$variable == vars[i], ]
    polygon(x = c(dat$year, dat$year[nrow(dat):1]), 
            y = c(dat$dlm.upper, dat$dlm.lower[nrow(dat):1]),
            col = paste0(cols[i], "66"), 
            border = paste0(cols[i], "aa"), lwd = 0.5)
    lines(dat$year, dat$"dlm.geomean", lwd = 2, col = cols[i])
    #points(1995, dat[dat$year == 1995, "dlm.geomean"], pch = 1, cex = 3, col = cols[i], lwd = 3)
    #points(2005, dat[dat$year == 2005, "dlm.geomean"], pch = 1, cex = 3, col = cols[i], lwd = 3)
  }
  
  box("plot", lwd = 0.5, col = "#333333")
  par(xpd = FALSE)
  
  par(mgp = c(1, -.1, 0))
  if (j %in% 3:4) {
    axis(1, seq(1975, 2015, by = 10), lwd = 0, cex.axis = .8)
    # mtext(side = 1, line = 1.05, text = "Year", font = 2, cex = .8)
  }
  
  par(mgp = c(1, .15, 0))
  if (j %in% c(1, 3)) {
    axis(2, seq(0, 3, by = .5), lwd = 0, las = 1, cex.axis = .8)
    # mtext(side = 2, line = 1.25, text = "Relative biomass, fishing pressure, and catch", font = 2, cex = .8)
  }
  
  text(1969, 2.95, lables[j], font = 2, pos = 4, cex = 1)
}





tab <- read.csv(here::here("data", "state_space_results_all_regions_01_07_2019.csv"))

vars <- c("UvU", "BvB")
cols <- c("#008B65", "#F1541B")


par(family = "serif", fg = "#333333", col = "#333333", col.axis = "#333333", 
    mar = c(1.05, 2.05, 1.05, .75))

plot(0, xlim = range(tab$year), ylim = c(0, 2), bty = "n", axes = FALSE, ann = FALSE)
abline(v = seq(1975, 2015, by = 10), h = seq(0, 2, by = .5), col = "lightgray", lty = "dotted", lwd = .5)


abline(h = 1, col = "#666666", lwd = 1.5)

par(xpd = TRUE)
for (i in 1:length(vars)) {
  dat <- tab[tab$variable == vars[i], ]
  polygon(x = c(dat$year, dat$year[nrow(dat):1]), 
          y = c(dat$dlm.upper, dat$dlm.lower[nrow(dat):1]),
          col = paste0(cols[i], "66"), 
          border = paste0(cols[i], "aa"), lwd = 0.5)
  lines(dat$year, dat$"dlm.geomean", lwd = 2, col = cols[i])
  # points(1995, dat[dat$year == 1995, "dlm.geomean"], pch = 1, cex = 3, col = cols[i], lwd = 3)
  # points(2005, dat[dat$year == 2005, "dlm.geomean"], pch = 1, cex = 3, col = cols[i], lwd = 3)
}

box("plot", lwd = 0.5, col = "#333333")
par(xpd = FALSE)

par(mgp = c(1, -.1, 0))
axis(1, seq(1975, 2015, by = 10), lwd = 0, cex.axis = .8)

par(mgp = c(1, .15, 0))
axis(2, seq(0, 2, by = .5), lwd = 0, las = 1, cex.axis = .8)

# mtext(side = 1, line = 1.25, text = "Year", font = 2, cex = .8)
mtext(side = 2, line = 1.10, text = "Relative biomass and fishing pressure", font = 2, cex = .65)

text(1969, 2, "A. Global", font = 2, pos = 4, cex = 1)


lines(x = c(2002, 2004.5), y = rep(1.87, 2), col = cols[2], lwd = 2)
text(2004.5, 1.87, "Relative biomass", pos = 4, cex = 0.85)
lines(x = c(2002, 2004.5), y = rep(1.80, 2), col = cols[1], lwd = 2)
text(2004.5, 1.80, "Relative fishing pressure", pos = 4, cex = 0.85)
# lines(x = c(2002, 2004.5), y = rep(1.73, 2), col = cols[1], lwd = 2)
# text(2004.5, 1.73, "Relative catch", pos = 4, cex = 0.85)

dev.off()


