In this repository, there are 3 Matlab functions related to the retrieval of phytoplankton pigment concentrations using Matrix Inversion Technique, i.e. SVD-NNLS; NNLS-NNLS. Detailed in Liu et al.(2019): Retrieval of Phytoplankton Pigments from Underway Spectrophotometry in the Fram Strait. Remote Sensing, 11(3), 318.

SVD stands for singular value decomposition; NNLS stands for non-negative least squares.

retrievePigm_MatrixInversion.m: 
This function retrieves phytoplankton pigment concentrations using Matrix Inversion Technique. 

PigmCondn.m:
This function calculates the condition numbers of the pigment matrix with k types of pigments included, and the corresponding pigment indices for all n!/(k!(n-k)!) pigment combinations.

DataPerturb.m:
This function returns the perturbed pigment and aph data. Assuming an uncertainty of 15% for HPLC pigment data, pigment matrix is perturbed with random values within +-15% of the measurements. aph matrix is perturbed with the random values within +-aph_std (satandard deviation of the aph spectra).
