## pcev_pipelineCBRAIN
This is a pipeline to run a pcev analysis from the R package on CBRAIN. 

### Descrition of PCEV

> Principal component of explained variance (PCEV) is a statistical tool for the analysis of a multivariate response vector. It is a dimension-reduction technique, similar to Principal component analysis (PCA), which seeks to maximize the proportion of variance (in the response vector) being explained by a set of covariates. 

> We consider the following setting: let $Y$ be a multivariate phenotype of dimension p (e.g. methylation values at CpG sites, or brain imaging measured at p
locations in the brain), let $X$ be a q-dimensional vector of covariates of interest (e.g.: smoking, cell type or SNPs) and let C be an r-dimensional vector of confounders. We assume that the relationship between Y and X can be represented via a linear model $$Y=BX + \Gamma C +E$$
where $B$ and $\Gamma$ are $p\times q$ and $p\times r$ matrices of regression coefficients for the covariates of interest and confounders, respectively,and $E\sim N_p(0,V_r)$ is a vector of residual errors. This model assumption allows us to decompose the total variance of $Y$, conditionnal on $C$, ... , in two components, the model variance component and the residual variance component. PCEV seeks a linear combination of outcomes, $w^TY$, that maximises the ratio of variance being explained by the covariates $X$. 

This tool returns a overall p-value for a test of association between all the variable in $X$ and all the variable in $Y$. It also return a vector of variable importance factors (VIMP) of length $p$.

> The VIMP can serve as surrogates for the univariate p-values when it comes to identifying the most important response variables.

### Description of the pipeline

Although possible in the R package, this pipeline cannot run a pcev analysis when the number of response variables ($p$) is larger than the number of samples.  

#### Input 

The command line of the pipeline take 3 to 4 arguments:

1.  The name of the desired output folder
2.  The name of the csv file corresponding to Y, the response matrix
3.  The name of the csv file corresponding to X, the covariates matrix
4.  If applicable, the name of the csv file corresponding to C, the confounder matrix

The pipeline assumes that the row is the header and contains the variables ID, then for the subsequent row, the first column contains the sample ID. The samples are then match across the files, and only the samples present in all two (three) files are retained for the analysis.  

#### Output

When succesfully run, the pipeline creates 5 output files found in the output folder:

1.  The resulting p-value (file Results_pvalue.txt)
2.  The variable importance factors (file Results_variableImportanceFactors.csv)
3.  The ID of the samples kept in the analysis (file SamplesKept.txt)
4.  A final report summarizing the results and indicating a what time the analysis was run (file FinalReport.txt).
5.  A trace of what appeared on the screen when the analysis was run (file resultsScreen.txt)

### References

R package: https://cran.r-project.org/web/packages/pcev/index.html

Paper: Turgeon, M., Oualkacha, K., Ciampi, A., Miftah, H., Dehghan, G., Zanke, B.W.,
Benedet, A.L., Rosa-Neto, P., Greenwood, C.M.T., Labbe, A., for the Alzheimer’s
Disease Neuroimaging Initiative (2016). Principal component of explained variance: An
efficient and optimal data dimension reduction framework for association studies. Statistical Methods in Medical Research, doi:10.1177/0962280216660128. 