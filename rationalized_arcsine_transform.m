% rationalized_arcsine_transform.m
% Author: Kevin Chu
% Last Modified: 9/11/19

function R = rationalized_arcsine_transform(X, N)
    % Computes the rationalized arcsine transform of proportion data
    %
    % Args:
    %   X (double, 1D array, or 2D array): number of positive samples
    %   N (double, 1D array, or 2D array): total number of samples
    %
    % Returns:
    %   R (double, 1D array, or 2D array): scores in rationalized arcsine
    %   units

    % First take the arcsine transform
    T = arcsine_transform(X, N);
    
    % Rationalized scale
    R = 46.47324337*T - 23;

end

function T = arcsine_transform(X, N)
    % Calculates the arcsine transform of proportion data
    %
    % Args:
    %   X (double, 1D array, or 2D array): number of positive samples
    %   N (double, 1D array, or 2D array): total number of samples
    %
    % Returns:
    %   T (double, 1D array, or 2D array): arcsine transformed data

    T = asin(sqrt(X./(N+1))) + asin(sqrt((X+1)./(N+1)));

end