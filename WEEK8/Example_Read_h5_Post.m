clc
clearvars -except NodeX NodeY T
close all
%--------------------------------------------------------------------------
%% CREATE A NEW UNIFORMLY-SPACED MESH WHERE DATA WILL BE INTERPOLATED 
DataFolder = cd;
%--------------------------------------------------------------------------
%% READ FLUENT MESH FROM CASE FILE
if ~exist('NodeX','var')
    casefiles = dir(fullfile(DataFolder,'*.cas.post'));
    %----------------------------------------------------------------------
    fname = fullfile(DataFolder,casefiles(1).name);
    %----------------------------------------------------------------------
    VertexList = ctranspose(h5read(fname,'/meshes/1.post/nodes/coords/1'));
    %----------------------------------------------------------------------    
    NodeX = VertexList(:,1);
    NodeY = VertexList(:,2);
    %----------------------------------------------------------------------    
    clear temp casefiles
end
Tw = 308;
Yw = -0.015;
% %--------------------------------------------------------------------------
datafiles  = dir(fullfile(DataFolder,'*dat.post'));
if ~exist('T','var')
    fname      = fullfile(DataFolder,datafiles(end).name);        
    T          = h5read(fname,'/results/1.post/mixture/nodes/Static Temperature/1');
    U          = h5read(fname,'/results/1.post/mixture/nodes/X Velocity/1');
    V          = h5read(fname,'/results/1.post/mixture/nodes/Y Velocity/1');
end
