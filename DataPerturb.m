function [pigment_perturbed,aph_perturbed]=DataPerturb(pigment,aph,aph_std)

% This function returns the perturbed pigment and aph data.
% Assuming an uncertainty of 15% for HPLC pigment data, pigment matrix is
% perturbed with random values within +-15% of the measurements. aph matrix
% is perturbed with the random values within +-aph_std.

% Detailed in Liu et al.(2019): Retrieval of Phytoplankton pigmentents from
% Underway Spectrophotometry in the Fram Strait, Remote Sensing, 11(3), 318.

% Input:
% pigment - phytoplankton pigmentent matrix (size: mxn).
% aph - phytoplankton absorption coefficient matrix (size: mxl).
% aph_std - standard deviation of the aph spectra (size: mxl). 


% Output:
% aph_perturbed - perturbed aph matrix (size: mxl).
% pigmentent_perturbed - perturbed pigment concentrations matrix (size:mxn).

% m - number of samples (e.g., 300); n - number of pigmentent types (e.g.,
% 20); l - number of wavelengths (e.g., 76).

% Author:Yangyang Liu (yangyang.liu@awi.de), December 2018.


%perturbe aph data with random values within +-aph_std.

range_aph=-1:0.02:1;
rand_idx_aph=randi(length(range_aph),size(aph,1),size(aph,2));

clear i j pos noise_coeff*
for i=1:size(aph,2)
    
    for j=1:size(aph,1)
        
        pos=rand_idx_aph(j,i);
        noise_coeff_aph(j,i)=range_aph(pos);
        
    end
    
end

aph_perturbed=aph+aph_std.*noise_coeff_aph;


%perturbe pigmentent data with random values within +-15% of the measurements.

range_pigment=-0.15:0.02:0.15; 
rand_idx_pigment=randi(length(range_pigment),size(pigment,1),size(pigment,2));

clear i j pos noise_coeff*
for i=1:size(pigment,2)
    
    for j=1:size(pigment,1)
        
        pos=rand_idx_pigment(j,i);
        noise_coeff_pigment(j,i)=range_pigment(pos);
        
    end
    
end

pigment_perturbed=pigment+pigment.*noise_coeff_pigment;

