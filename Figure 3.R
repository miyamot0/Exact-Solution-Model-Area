
bottomMargin   <- 0.4
leftMarginText <- 0.4
leftMarginBlank<- 0.2
topMargin <- 0.2

par(mfrow = c(2, 1), oma = c(0, 0, 0, 0), mar=c(2, 2, 2, 0) + 0.1, omi=c(0.2,0.2,0,0))

aucDelays <- c(7,14,30,183,365,1825)
aucValues <- c(0.995,0.975,0.825,0.8,0.7,0.6)

hypDelays <- seq(1, 9125, length.out = 20000)
hypValues <- 1 / (1 + 0.002357*hypDelays)

gmDelays <- seq(1, 1825, length.out = 20000)
gmValues <- 1 / (1 + 0.043864*gmDelays)^0.219506

# Base plot, AUC
plot(aucDelays,
     aucValues,
     main = "Discounting Results as Reported",
     log = "x",
     type = "p",
     cex = 1.5,
     pch = 15,
     xlab = NA,
     ylab = NA,
     xaxt = "n",
     yaxt = "n",
     xlim = c(1, 10000),
     ylim = c(0, 1))

# Axes
atx <- c(1, 10, 100, 1000, 10000)
labels <- sapply(atx, function(i) as.expression(bquote(.(NA))) )
axis(1, at=atx, labels=labels)

aty <- c(0, 0.25, 0.5, 0.75, 1)
labels <- sapply(aty, function(i) as.expression(bquote(.(i))) )
axis(2, at=aty, labels=labels)

# Lines
lines(aucDelays, aucValues, lty = 1, lwd = 2)

lines(gmDelays, gmValues, lty = 2, lwd = 2, col = "lightgray")

lines(hypDelays, hypValues, lty = 3, lwd = 2, col = "darkgray")

# Labels
arrows(1000,
       0.825,
       x1 = 1000,
       y1 = 0.675,
       code = 2)

text(1000, 0.9, labels = c("Study A"))

arrows(500,
       0.25,
       x1 = 1000,
       y1 = 0.25,
       code = 2)

text(450, 0.25,
     adj = 1,
     labels = c("Study B"))

arrows(10,
       0.725,
       x1 = 10,
       y1 = 0.9,
       code = 2)

text(10, 0.65, labels = c("Study C"))

########################################

aucDelays <- c(7,14,30,183,365,1825)
aucValues <- c(0.995,0.975,0.825,0.8,0.7,0.6)

hypDelays <- seq(7, 1825, length.out = 20000)
hypValues <- 1 / (1 + 0.002357*hypDelays)

gmDelays <- seq(7, 1825, length.out = 20000)
gmValues <- 1 / (1 + 0.043864*gmDelays)^0.219506

# Mod plot, AUC
plot(aucDelays,
     aucValues,
     main = "Discounting Results with Common Bounds",
     log = "x",
     type = "p",
     cex = 1.5,
     pch = 15,
     xlab = NA,
     ylab = NA,
     xaxt = "n",
     yaxt = "n",
     xlim = c(1, 10000),
     ylim = c(0, 1))

# Axes
atx <- c(1, 10, 100, 1000, 10000)
labels <- sapply(atx, function(i) as.expression(bquote(.(i))) )
axis(1, at=atx, labels=labels)

aty <- c(0, 0.25, 0.5, 0.75, 1)
labels <- sapply(aty, function(i) as.expression(bquote(.(i))) )
axis(2, at=aty, labels=labels)

# Lines
lines(aucDelays, aucValues, lty = 1, lwd = 2)

lines(gmDelays, gmValues, lty = 2, lwd = 2, col = "lightgray")

lines(hypDelays, hypValues, lty = 3, lwd = 2, col = "darkgray")

# Labels
arrows(1000,
       0.825,
       x1 = 1000,
       y1 = 0.675,
       code = 2)

text(1000, 0.9, labels = c("Study A"))

arrows(500,
       0.25,
       x1 = 1000,
       y1 = 0.25,
       code = 2)

text(450, 0.25,
     adj = 1,
     labels = c("Study B"))

arrows(10,
       0.725,
       x1 = 10,
       y1 = 0.9,
       code = 2)

text(10, 0.65, labels = c("Study C"))

# Description

lines(c(7,7),
      c(-1,10),
      lty = 2)
lines(c(1825,1825),
      c(-1,10),
      lty = 2)

#mtext(expression(bold('Comparative Discounting')), outer = T, cex = 1.5)
mtext(expression(bold('Normalized Value')), side=2, outer=T, at=0.5)
mtext(expression(bold('Delay')), side=1, line = 2, outer=F, at=100)
