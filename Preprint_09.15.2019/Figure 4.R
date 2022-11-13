library(ggplot2)

filePath <- "Sim Comparisons.csv"
file <- read.csv(filePath, stringsAsFactors = FALSE)

mVars = file

#overall
wilcox.test(mVars$NI.AUC, 
            mVars$Exact.AUC, correct = FALSE)
cor.test(x=mVars$NI.AUC, 
         y=mVars$Exact.AUC, method = 'spearman', exact = FALSE)

#Noise
wilcox.test(mVars[mVars$Model == "Noise",]$NI.AUC, 
            mVars[mVars$Model == "Noise",]$Exact.AUC, correct = FALSE)
cor.test(x=mVars[mVars$Model == "Noise",]$NI.AUC, 
         y=mVars[mVars$Model == "Noise",]$Exact.AUC, method = 'spearman', exact = FALSE)

#Exponential
wilcox.test(mVars[mVars$Model == "Exponential",]$NI.AUC, 
            mVars[mVars$Model == "Exponential",]$Exact.AUC, correct = FALSE)
cor.test(x=mVars[mVars$Model == "Exponential",]$NI.AUC, 
         y=mVars[mVars$Model == "Exponential",]$Exact.AUC, method = 'spearman', exact = FALSE)

#Hyperbolic
wilcox.test(mVars[mVars$Model == "Hyperbolic",]$NI.AUC, 
            mVars[mVars$Model == "Hyperbolic",]$Exact.AUC, correct = FALSE)
cor.test(x=mVars[mVars$Model == "Hyperbolic",]$NI.AUC, 
         y=mVars[mVars$Model == "Hyperbolic",]$Exact.AUC, method = 'spearman', exact = FALSE)

#Quasi-Hyperbolic
wilcox.test(mVars[mVars$Model == "Quasi-Hyperbolic",]$NI.AUC, 
            mVars[mVars$Model == "Quasi-Hyperbolic",]$Exact.AUC, correct = FALSE)
cor.test(x=mVars[mVars$Model == "Quasi-Hyperbolic",]$NI.AUC, 
         y=mVars[mVars$Model == "Quasi-Hyperbolic",]$Exact.AUC, method = 'spearman', exact = FALSE)


#Myerson-Green
wilcox.test(mVars[mVars$Model == "Myerson-Green",]$NI.AUC, 
            mVars[mVars$Model == "Myerson-Green",]$Exact.AUC, correct = FALSE)
cor.test(x=mVars[mVars$Model == "Myerson-Green",]$NI.AUC, 
         y=mVars[mVars$Model == "Myerson-Green",]$Exact.AUC, method = 'spearman', exact = FALSE)

#Rachlin
wilcox.test(mVars[mVars$Model == "Rachlin",]$NI.AUC, 
            mVars[mVars$Model == "Rachlin",]$Exact.AUC, correct = FALSE)
cor.test(x=mVars[mVars$Model == "Rachlin",]$NI.AUC, 
         y=mVars[mVars$Model == "Rachlin",]$Exact.AUC, method = 'spearman', exact = FALSE)

require(grid)
library(gridExtra)
require(ggplot2)

table(file$Model)

fontSize = 4
xOffset = 0.35
yOffset = 0.975

lm_eqn = function(m) {
  
  l <- list(a = as.numeric(format(coef(m)[1], digits = 3)),
            b = as.numeric(format(abs(coef(m)[2]), digits = 3)),
            r2 = format(summary(m)$r.squared, digits = 3));
  
  if (coef(m)[2] >= 0)  {
    eq <- substitute(italic(y) == a + b %.% italic(x)*","~~italic(r)^2~"="~r2,l)
  } else {
    eq <- substitute(italic(y) == a - b %.% italic(x)*","~~italic(r)^2~"="~r2,l)    
  }
  
  as.character(as.expression(eq));                 
}

#setEPS()
#postscript("SingleFigure.eps", 
#           fonts = "Times", 
#           #paper = "special",
#           #width = 6,
##           pointsize = 30,
#           horizontal = TRUE,
#           pagecentre = TRUE,
#           #paper = "special", 
#           #bg = "transparent", 
#           onefile = TRUE)

par(family = "Times")

ggplot(mVars[, c("NI.AUC", "Exact.AUC")], 
                aes(x=NI.AUC, y=Exact.AUC)) + 
  geom_point() +
  geom_smooth(method = "lm", colour = "gray", se = FALSE) +
  theme_bw() +
  annotate("text", 
           x = 0.15, 
           y = 1, 
           label = lm_eqn(lm(Exact.AUC ~ NI.AUC, mVars[,c("NI.AUC", "Exact.AUC")])), 
           colour="black", 
           size = fontSize, 
           parse=TRUE) +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        text=element_text(size=12, family="Times")) +
  labs(title = "All Models", 
       x = "Numerical Integration Area", 
       y = "Exact Solution Area")

ggsave("TestingSinglePlot.eps", 
       fonts = "Times", 
       width = 7,
       height = 5,
       plot = last_plot(), dpi = 200)

#dev.off()
#dev.copy2eps("Times", )


plot0 <- ggplot(mVars[mVars$Model == "Noise", c("NI.AUC", "Exact.AUC")], 
                aes(x=NI.AUC, y=Exact.AUC)) + 
  geom_point() +
  geom_smooth(method = "lm", colour = "gray", se = FALSE) +
  theme_bw() +
  annotate("text", 
           x = xOffset, 
           y = yOffset, 
           label = lm_eqn(lm(Exact.AUC ~ NI.AUC, mVars[mVars$Model == "Noise", 
                                                       c("NI.AUC", "Exact.AUC")])), 
           colour="black", 
           size = fontSize, 
           parse=TRUE) +
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        text=element_text(size=12, family="Times")) +
  labs(title = "Noise Model", 
       x = "Numerical Integration Area", 
       y = "Exact Solution Area")

plot1 <- ggplot(mVars[mVars$Model == "Hyperbolic", c("NI.AUC", "Exact.AUC")], aes(x=NI.AUC, y=Exact.AUC)) + 
  geom_point() +
  geom_smooth(method = "lm", colour = "gray", se = FALSE) +
  theme_bw() +
  annotate("text", 
           x = xOffset, 
           y = yOffset, 
           label = lm_eqn(lm(Exact.AUC ~ NI.AUC, mVars[mVars$Model == "Hyperbolic", 
                                                       c("NI.AUC", "Exact.AUC")])), 
           colour="black", 
           size = fontSize, 
           parse=TRUE) +  
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        text=element_text(size=12, family="Times")) +
  labs(title = "Mazur Model", x = "Numerical Integration Area", y = "Exact Solution Area")

plot2 <- ggplot(mVars[mVars$Model == "Exponential", c("NI.AUC", "Exact.AUC")], aes(x=NI.AUC, y=Exact.AUC)) + 
         geom_point() +
         geom_smooth(method = "lm", colour = "gray", se = FALSE) +
         theme_bw() +
  annotate("text", 
           x = xOffset, 
           y = yOffset, 
           label = lm_eqn(lm(Exact.AUC ~ NI.AUC, mVars[mVars$Model == "Exponential", c("NI.AUC", "Exact.AUC")])), 
           colour="black", 
           size = fontSize, 
           parse=TRUE) +    
         theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
               text=element_text(size=12, family="Times")) +
         labs(title = "Exponential Model", x = "Numerical Integration Area", y = "Exact Solution Area")

plot3 <- ggplot(mVars[mVars$Model == "Quasi-Hyperbolic", c("NI.AUC", "Exact.AUC")], aes(x=NI.AUC, y=Exact.AUC)) + 
         geom_point() +
         geom_smooth(method = "lm", colour = "gray", se = FALSE) +
         theme_bw() +
  annotate("text", 
           x = xOffset, 
           y = yOffset, 
           label = lm_eqn(lm(Exact.AUC ~ NI.AUC, mVars[mVars$Model == "Quasi-Hyperbolic", c("NI.AUC", "Exact.AUC")])), 
           colour="black", 
           size = fontSize, 
           parse=TRUE) +    
         theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
               text=element_text(size=12, family="Times")) +
         labs(title = "Quasi-Hyperbolic Model", x = "Numerical Integration Area", y = "Exact Solution Area")

plot4 <- ggplot(mVars[mVars$Model == "Myerson-Green", c("NI.AUC", "Exact.AUC")], aes(x=NI.AUC, y=Exact.AUC)) + 
         geom_point() +
         geom_smooth(method = "lm", colour = "gray", se = FALSE) +
         theme_bw() +
  annotate("text", 
           x = xOffset, 
           y = yOffset, 
           label = lm_eqn(lm(Exact.AUC ~ NI.AUC, mVars[mVars$Model == "Myerson-Green", c("NI.AUC", "Exact.AUC")])), 
           colour="black", 
           size = fontSize, 
           parse=TRUE) +      
         theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
               text=element_text(size=12, family="Times")) +
         labs(title = "Green Myerson Model", x = "Numerical Integration Area", y = "Exact Solution Area") 

plot5 <- ggplot(mVars[mVars$Model == "Rachlin", c("NI.AUC", "Exact.AUC")], aes(x=NI.AUC, y=Exact.AUC)) + 
         geom_point() +
         geom_smooth(method = "lm", colour = "gray", se = FALSE) +
         theme_bw() +
  annotate("text", 
           x = xOffset, 
           y = yOffset, 
           label = lm_eqn(lm(Exact.AUC ~ NI.AUC, mVars[mVars$Model == "Rachlin", c("NI.AUC", "Exact.AUC")])), 
           colour="black", 
           size = fontSize, 
           parse=TRUE) +       
         theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
               text=element_text(size=12, family="Times")) +
         labs(title = "Rachlin Model", x = "Numerical Integration Area", y = "Exact Solution Area")

#setEPS()
#postscript("BigFigure.eps", 
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
pushViewport(viewport(layout = grid.layout(2, 6, heights = unit(c(8, 8), "null"))))

print(plot0, vp = viewport(layout.pos.row = 1, layout.pos.col = 1:2))
print(plot1, vp = viewport(layout.pos.row = 1, layout.pos.col = 3:4))
print(plot2, vp = viewport(layout.pos.row = 1, layout.pos.col = 5:6))

print(plot3, vp = viewport(layout.pos.row = 2, layout.pos.col = 1:2))
print(plot4, vp = viewport(layout.pos.row = 2, layout.pos.col = 3:4))
print(plot5, vp = viewport(layout.pos.row = 2, layout.pos.col = 5:6))

#dev.off()

#modelVars <- mVars[mVars$Model == "Rachlin",]

