function [a_star,pigment_esti]=retrievePigm_MatrixInversion(pigment,aph,wavelength,ifSVD)

% This function retrieves phytoplankton pigment concentrations using Matrix
% Inversion Technique. 

% Detailed in Liu et al.(2019): Retrieval of Phytoplankton Pigments from
% Underway Spectrophotometry in the Fram Strait. Remote Sensing, 11(3), 318.

% Input:
% pigment - phytoplankton pigment matrix (size: mxn).
% aph - phytoplankton absorption coefficient matrix (size: mxl).
% wavelength - wavelength matrix of aph (size: lx1).
% ifSVD==1, sigular value decomposition (SVD) is used to to derive
% pigment-specific absorption coefficient; ifSVD==0, non-negetive least
% squares (NNLS) is used to derive pigment-specific absorption coefficient.

% Output:
% a_star - pigment-specific absorption coefficient matirx of the pigments
% to be estimated (size: lxn).
% pigment_esti - estimated pigment concentrations matrix (size:mxn).

% m - number of samples (e.g., 300); n - number of pigment types to be
% estimated (e.g., 9); l - number of wavelengths (e.g., 76).

% Author:Yangyang Liu (yangyang.liu@awi.de), December 2018.


options = optimset('TolX',1e-8,'TolFun',1e-9,'MaxIter',4000,'MaxFunEvals',2000);

clear a_star pigment_esti

% derive pigment-specific absorption
for i=1:length(wavelength)
    
    if ifSVD==1
        %using SVD
        a_star(:,i)=pinv(pigment)*aph(:,i);   
    else
        %using NNLS
        a_star(:,i)= lsqnonneg(pigment,aph(:,i),options);
    end
    
end

a_star=a_star';

% retrieve pigments using NNLS
for i=1:size(aph,1)
    
    pigment_esti(:,i)= lsqnonneg(a_star,aph(i,:)',options);
    
end

pigment_esti=pigment_esti';
