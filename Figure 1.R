
require(ggplot2)
require(grid)
require(gridExtra)

xLabels <- c(1,NA,NA,365,1825,3650, NA, NA)
xLabels2 <- c(1,NA,NA,365,1825,3650, 7300, NA)
xLabels3 <- c(1,NA,NA,365,1825,3650, 7300, 14600)

xDelays <- c(1,30,180,365,1825,3650, 7300, 14600)
#xDelaysLog <- log10(xDelays)

dataFrame <- data.frame(X=xDelays,
                        Y=c(945,855,845,750,636,274,NA,NA))

dataFrame2 <- data.frame(X=xDelays,
                         Y=c(945,855,845,750,636,274,274,NA))

dataFrame3 <- data.frame(X=xDelays,
                         Y=c(945,855,845,750,636,274,274,274))

annotateMessage = sprintf("Maximum Area = (%s - %s) * 1000 = %s", 3650, 1, (3650-1) * 1000)

plotDraw <- ggplot(dataFrame, aes(x=X, y=Y, fill="gray")) +
  geom_line(size=1, linetype=1) +
  geom_area() +
  geom_point() +
  scale_fill_manual(values = c('gray')) +
  geom_segment(aes(x = dataFrame$X[1], y = 0, xend = dataFrame$X[1], yend = dataFrame$Y[1], colour = "black")) +
  geom_segment(aes(x = dataFrame$X[2], y = 0, xend = dataFrame$X[2], yend = dataFrame$Y[2], colour = "black")) +
  geom_segment(aes(x = dataFrame$X[3], y = 0, xend = dataFrame$X[3], yend = dataFrame$Y[3], colour = "black")) +
  geom_segment(aes(x = dataFrame$X[4], y = 0, xend = dataFrame$X[4], yend = dataFrame$Y[4], colour = "black")) +
  geom_segment(aes(x = dataFrame$X[5], y = 0, xend = dataFrame$X[5], yend = dataFrame$Y[5], colour = "black")) +
  geom_segment(aes(x = dataFrame$X[6], y = 0, xend = dataFrame$X[6], yend = dataFrame$Y[6], colour = "black")) +
  geom_segment(aes(x = dataFrame$X[7], y = 0, xend = dataFrame$X[7], yend = dataFrame$Y[7], colour = "black")) +
  geom_segment(aes(x = dataFrame$X[8], y = 0, xend = dataFrame$X[8], yend = dataFrame$Y[8], colour = "black")) +
  scale_x_continuous(breaks = xLabels,
                     labels = xLabels,
                     limits = c(0,max(xDelays)),
                     expand = c(0, 0)) +
  scale_y_continuous(limits = c(0,1000), expand = c(0, 0)) +
  annotate("text",
           y = 900,
           x = max(xDelays) - 250,
           label = annotateMessage,
           hjust = 1,
           family = "Times") +
  scale_colour_manual(values = c('black')) +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.margin = unit(c(0.1,0.5,0.1,0.5), "cm"),
        legend.position="none",
        plot.title = element_text(hjust = 0.5),
        axis.text = element_text(color = "black"),
        text=element_text(size=10, family="Times")) +
  labs(title = "PB-AUC = 0.5876 (Max Delay = 3650)",
       x = "",
       y = "")

annotateMessage2 = sprintf("Maximum Area = (%s - %s) * 1000 = %s", 7300, 1, (7300-1) * 1000)

plotDraw2 <- ggplot(dataFrame2, aes(x=X, y=Y, fill="gray")) +
  geom_line(size=1) +
  geom_area(aes(x=X, y=Y, fill="gray"), data = dataFrame2) +
  geom_point() +
  scale_fill_manual(values = c('gray')) +
  geom_segment(aes(x = dataFrame2$X[1], y = 0, xend = dataFrame2$X[1], yend = dataFrame2$Y[1], colour = "black")) +
  geom_segment(aes(x = dataFrame2$X[2], y = 0, xend = dataFrame2$X[2], yend = dataFrame2$Y[2], colour = "black")) +
  geom_segment(aes(x = dataFrame2$X[3], y = 0, xend = dataFrame2$X[3], yend = dataFrame2$Y[3], colour = "black")) +
  geom_segment(aes(x = dataFrame2$X[4], y = 0, xend = dataFrame2$X[4], yend = dataFrame2$Y[4], colour = "black")) +
  geom_segment(aes(x = dataFrame2$X[5], y = 0, xend = dataFrame2$X[5], yend = dataFrame2$Y[5], colour = "black")) +
  geom_segment(aes(x = dataFrame2$X[6], y = 0, xend = dataFrame2$X[6], yend = dataFrame2$Y[6], colour = "black")) +
  geom_segment(aes(x = dataFrame2$X[7], y = 0, xend = dataFrame2$X[7], yend = dataFrame2$Y[7], colour = "black")) +
  geom_segment(aes(x = dataFrame2$X[8], y = 0, xend = dataFrame2$X[8], yend = dataFrame2$Y[8], colour = "black")) +
  scale_x_continuous(breaks = xLabels2,
                     labels = xLabels2,
                     limits = c(0,max(xDelays)),
                     expand = c(0, 0)) +
  scale_y_continuous(limits = c(0,1000), expand = c(0, 0)) +
  annotate("text",
           y = 900,
           x = max(xDelays) - 250,
           label = annotateMessage2,
           hjust = 1,
           family = "Times") +
  scale_colour_manual(values = c('black')) +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.margin = unit(c(0.1,0.5,0.1,0.5), "cm"),
        legend.position="none",
        plot.title = element_text(hjust = 0.5),
        axis.text = element_text(color = "black"),
        text=element_text(size=10, family="Times")) +
  labs(title = "PB-AUC = 0.4306 (Max Delay = 7300)",
       x = "",
       y = "Value")

annotateMessage3 = sprintf("Maximum Area = (%s - %s) * 1000 = %s", 14600, 1, (14600-1) * 1000)

plotDraw3 <- ggplot(dataFrame3, aes(x=X, y=Y, fill="gray")) +
  geom_line(size=1) +
  geom_area(aes(x=X, y=Y, fill="gray"), data = dataFrame3) +
  geom_point() +
  scale_fill_manual(values = c('gray')) +
  geom_segment(aes(x = dataFrame3$X[1], y = 0, xend = dataFrame3$X[1], yend = dataFrame3$Y[1], colour = "black")) +
  geom_segment(aes(x = dataFrame3$X[2], y = 0, xend = dataFrame3$X[2], yend = dataFrame3$Y[2], colour = "black")) +
  geom_segment(aes(x = dataFrame3$X[3], y = 0, xend = dataFrame3$X[3], yend = dataFrame3$Y[3], colour = "black")) +
  geom_segment(aes(x = dataFrame3$X[4], y = 0, xend = dataFrame3$X[4], yend = dataFrame3$Y[4], colour = "black")) +
  geom_segment(aes(x = dataFrame3$X[5], y = 0, xend = dataFrame3$X[5], yend = dataFrame3$Y[5], colour = "black")) +
  geom_segment(aes(x = dataFrame3$X[6], y = 0, xend = dataFrame3$X[6], yend = dataFrame3$Y[6], colour = "black")) +
  geom_segment(aes(x = dataFrame3$X[7], y = 0, xend = dataFrame3$X[7], yend = dataFrame3$Y[7], colour = "black")) +
  geom_segment(aes(x = dataFrame3$X[8], y = 0, xend = dataFrame3$X[8], yend = dataFrame3$Y[8], colour = "black")) +
  scale_x_continuous(breaks = xLabels3,
                     labels = xLabels3,
                     limits = c(0,max(xDelays)),
                     expand = c(0, 0)) +
  scale_y_continuous(limits = c(0,1000), expand = c(0, 0)) +
  annotate("text",
           y = 900,
           x = max(xDelays) - 250,
           label = annotateMessage3,
           hjust = 1,
           family = "Times") +
  scale_colour_manual(values = c('black')) +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.margin = unit(c(0.1,0.5,0.1,0.5), "cm"),
        legend.position="none",
        plot.title = element_text(hjust = 0.5),
        axis.text = element_text(color = "black"),
        text=element_text(size=10, family="Times")) +
  labs(title = "PB-AUC = 0.3523 (Max Delay = 14600)",
       x = "Delay",
       y = "")

#windowsFonts()


#setEPS()
#postscript("AUCCompare.eps", 
#           fonts = "Times", 
#           paper = "special",
#           width = 11,
#           height = 8,
#           horizontal = TRUE,
#           pagecentre = FALSE,
           #paper = "special", 
           #bg = "transparent", 
#           onefile = TRUE)

par(family = "Times", mar=c(3,3,2,1), mgp=c(2,.7,0), tck=-.01)

grid.newpage()
pushViewport(viewport(layout = grid.layout(3, 6,
                                           heights = unit(c(11), "null"),
                                           widths = unit(c(8, 8, 8, 8, 8, 8), "null"))))

#print(plotDraw)
#print(plotDraw2)
#print(plotDraw3)

print(plotDraw,  vp = viewport(layout.pos.row = 1, layout.pos.col = 1:6))
print(plotDraw2, vp = viewport(layout.pos.row = 2, layout.pos.col = 1:6))
print(plotDraw3, vp = viewport(layout.pos.row = 3, layout.pos.col = 1:6))

#ggsave("plotDraw1.eps", 
#       fonts = "Times", 
#       width = 7,
#       height = 2.25,
#       plot = plotDraw, 
#       dpi = 200)

#ggsave("plotDraw2.eps", 
#       fonts = "Times", 
#       width = 7,
#       height = 2.25,
#       plot = plotDraw2, 
#       dpi = 200)

#ggsave("plotDraw3.eps", 
#       fonts = "Times", 
#       width = 7,
#       height = 2.5,
#       plot = plotDraw3, 
#       dpi = 200)

#dev.off()

#grid.text("Delay",
#          gp = gpar(fontsize=12, fontfamily="Times New Roman", fontface = 2),
#          vp = viewport(layout.pos.row = 2, layout.pos.col = 2:7))

#grid.text("Value",
#          rot = 90,
#          gp = gpar(fontsize=12, fontfamily="Times New Roman", fontface = 2),
#          vp = viewport(layout.pos.row = 1, layout.pos.col = 1))
#multiplot(plotDraw, plotDraw2, cols=2, labs=list("cool x label", "cool y label"))
