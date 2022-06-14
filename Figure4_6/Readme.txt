IC50.mat: IC50 values for six NRTI inhibitors for wild type HIV.
INITINAL_GUESS.mat: Includes treshold \alpha and \tau values that seperates the occurence/nonoccurence of AIDS phase for 21 NRTI combination and all initial strains G_ij.
linear_logistic.m: Applies lineer logistic regression model to seperate the occurence/nonoccurence of AIDS in (\alpha,\tau) phase plane.
Machine_Learning_Data.mat: Produced by Main_Figures.m as traning data of further machine learning models.
Main_Figures.m: Produces Figure 4 and Figure 6 of the manuscritp. Additionally, it produces Machine_Learning_Data.mat.
Main_Simulations.m: Applies multi-strain within host model for each NRTI combinations and each initial viral strains G_ij. This code produces simulation results as "SIM_RESULTS_CASE_i_j.mat".
ML_C.mat: Adjecency list version of the mutation matrix.
MTT.mat: Includes the indexes of G_ij strains.
Prior_Estimate.m: For a given initial strain y0, it produces a matrix Z that includes the \beta_i values of this strain and possible one-point mutant strains for each 21 NRTI combinations.
SIM_RESULTS_CASE_i_j.mat: This file includes the simulation results as DAT_A: Occurence time of the AIDS phase (if AIDS phase has not been emerged it includes 7300),
		          DAT_D: At the final time of the simulations, number of virions belonging to the each viral strain that can be seen in DAT_S, 
			  DAT_S: Indexes of the emerged viral strains at the final time of the simulation.
simulation.m: Performs the simulation of the multi-strain within host model.
simulation2.m: Performs the simulation of the multi-strain within host model when \tau=0 and obtains the treshold \alpha value.
simulation3.m: Performs the simulation of the multi-strain within host model when \alpha=1 and obtains the treshold \tau value.
Z_generate.m: Produces time dependent \beta_i values for a specified viral strain and specified NRTI combinations.
Z_generate2.m: Produces mean \beta_i values for a specified viral strain and specified NRTI combinations.
