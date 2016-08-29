% TO DO: Explain here what this script does.
clear

% SCRIPT PARAMETERS
% -----------------
n  = 800;   % Number of samples.
p  = 2000;  % Number of variables (genetic markers).
se = 4;     % Variance of residual.

% The standard deviations and mixture weights used to simulate the additive
% effects on the quantitative trait.
sd = [     1  0.2   0.1 0.01 ]';
q  = [ 0.005 0.01 0.025 0.96 ]';

% Set the random number generator seed.
rng(1);

% GENERATE DATA SET
% -----------------
% Generate the minor allele frequencies so that they are uniform over range
% [0.05,0.5]. Then simulate genotypes assuming all markers are uncorrelated
% (i.e., unlinked), according to the specified minor allele frequencies.
fprintf('1. GENERATING DATA SET.\n')
maf = 0.05 + 0.45 * rand(1,p);
X   = (rand(n,p) < repmat(maf,n,1)) + ...
      (rand(n,p) < repmat(maf,n,1));
X   = single(X);

% Generate additive effects according to the specified standard deviations
% (sd) and mixture weights (q).
k    = randtable(q,p);
beta = sd(k) .* randn(p,1);

% Generate random labels for the markers.
labels = num2cell(randi(max(1e6,p),p,1));
labels = cellfun(@num2str,labels,'UniformOutput',false);
labels = strcat('rs',labels);