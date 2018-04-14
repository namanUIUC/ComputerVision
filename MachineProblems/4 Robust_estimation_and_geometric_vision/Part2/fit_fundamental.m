function [ F ] = fit_fundamental( matches, Normalize )

%% CARTESIAN COORDINATES TO HOMOGENEOUS
x1 = homogeneousConverter(matches(:,1:2));
x2 = homogeneousConverter(matches(:,3:4));

%% NORMALIZATION
if Normalize
    
    t1 = transformationMatrix(x1);
    t2 = transformationMatrix(x2);
    x1 = (t1*x1')';
    x2 = (t2*x2')';
end

%% VARIABLES
u1 = x1(:,1);
v1 = x1(:,2);
u2 = x2(:,1);
v2 = x2(:,2);

%% 8 POINT ALGORITHM
EightPtMatrix = [ u2.*u1, u2.*v1, u2, v2.*u1, v2.*v1, v2, u1, v1, ones(size(matches,1), 1)];

%% SOLVING SYSTEM OF EQUATIONS + ENFORCING RANK 2 CONSTRAINT
[~,~,V] = svd(EightPtMatrix);
f_vec = V(:,9);
F = reshape(f_vec, 3,3);
[FU, FS, FV] = svd(F);
FS(end) = 0;
F = FU*FS*FV';

%% DE-NORMALIZATION
if Normalize
    F = t2' * F * t1;
end
end