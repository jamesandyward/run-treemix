# How to run Treemix

Starting off we will need the appropriate software to first generate the inputs we need and also Treemix itself. Everything can be installed using conda.

The most straightforward method is to use Stacks (any version prior to v2).

Once we have it installed we will have to use the populations program:
``
populations -V $yourvcf.vcf --treemix -O myoutdir/ -M popmap.txt
``
The popmap.txt file contains two columns, the first has an individual ID, the second has the population ID.

You can generate this file using this following command
``
bcftools query -l $yourvcf.vcf | awk '{split($1,pop,"."); print $1"\t"$1"\t"pop[2]}' > popmap.txt
``
Once you have run the command you should have the necessary files to run Treemix.

There are two changes you need to make to the file first. Identify the file with the .treemix prefix

We want to first remove the comment from the first line. You can do this in nano easily. 

Secondly, we want to gzip the file. Straightforward.

With that done we can now run treemix. I have written the following:
``
for i in {0..5}
do
 treemix -i $myvcf.treemix.gz -m $i -o treemix_$pop.$i -root $root_pop -bootstrap -k 500 -noss > treemix_$pop_${i}_log &
done
``
With that done we can now plot the results. To do this we will need the following R script:
``
setwd("~/projects/SACP/WGS_BovHD_Subset/popgen/treemix/output")
library(RColorBrewer)
library(R.utils)
source("nygcresearch-treemix-f38bfada3286/src/plotting_funcs.R")
prefix= "treemix"
``
``
par(mfrow=c(2,3))
for(edge in 0:5){
  plot_tree(cex=0.8,paste0(prefix,".",edge))
  title(paste(edge,"edges"))
}
``
``
png("filesAFT.png", width = 10, height = 15, units = "in")
for(edge in 0:5){
  plot_resid(stem=paste0(prefix,".",edge),pop_order="popmap.txt")
}
dev.off()
``
