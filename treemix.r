setwd("~/projects/SACP/WGS_BovHD_Subset/popgen/treemix/output")
library(RColorBrewer)
library(R.utils)
source("nygcresearch-treemix-f38bfada3286/src/plotting_funcs.R")
prefix= "treemix"

par(mfrow=c(2,3))
for(edge in 0:5){
  plot_tree(cex=0.8,paste0(prefix,".",edge))
  title(paste(edge,"edges"))
}

png("filesAFT.png", width = 10, height = 15, units = "in")
for(edge in 0:5){
  plot_resid(stem=paste0(prefix,".",edge),pop_order="popmap.txt")
}
dev.off()
