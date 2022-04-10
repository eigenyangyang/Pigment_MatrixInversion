function [n_cond,PigmentIdx]=PigmCondn(pigment,k)

% This function calculates the condition numbers of the pigment matrix with
% k types of pigments included, and the corresponding pigment indices for
% all n!/(k!(n-k)!) pigment combinations.

% Detailed in Liu et al.(2019): Retrieval of Phytoplankton Pigments from
% Underway Spectrophotometry in the Fram Strait. Remote Sensing, 11(3), 318.

% Input:
% pigment - original phytoplankton pigment matrix (size: mxn).
% k - number of selected pigment types (e.g., 9);

% Output:
% CondN - condition numbers of the pigment matrix with k types of
% pigment included (size: n!/(k!(n-k)!)x1).
% PigmentIdx - the indices of the pigments in the original n pigments for
% all n!/(k!(n-k)!) pigment combinations (size: n!/(k!(n-k)!)xk).

% m - number of samples (e.g., 300);
% n - number of pigment types involved in the original pigment matrix
% (e.g., 20);


% Author:Yangyang Liu (yangyang.liu@awi.de), December 2018.


% summed pigment concentrations in each sample
pigment_sum=sum(pigment,2);
n=size(pigment,2);

% combinations of n types of pigments taken k at a time.
c=nchoosek(1:1:n,k);

for j=1:size(c,1)
    
    idx_row=c(j,:);
    
    clear others pigment_mat pigment_selected
    pigment_selected=pigment(:,idx_row);
    others=pigment_sum-sum(pigment_selected,2);
    
    if k<n
        pigment_mat=[pigment_selected others];
    else
        pigment_mat=pigment_selected;
    end
    
    n_cond(j,1)=cond(pigment_mat); %condition number
    
end

PigmentIdx=c;
    

