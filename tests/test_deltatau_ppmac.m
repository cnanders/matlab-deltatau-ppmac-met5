clear all
clc

[cDirThis, cName, cExt] = fileparts(mfilename('fullpath'));
cDirSrc = fullfile(cDirThis, '..');
cDirVendor = fullfile(cDirSrc, 'vendor');

% Add src
addpath(genpath(fullfile(cDirSrc)))

% Add javapath
javaaddpath(fullfile(cDirVendor, 'ganymed-ssh2-build250', 'ganymed-ssh2-build250.jar'));

% Add vendor ssh
addpath(genpath(fullfile(cDirVendor, 'fileexchange', 'ssh2_v2_m1_r6')));

% Add 
cHost = '192.168.20.23'; % MET5 endstation subnet

ppmac = deltatau.PowerPmac(...
    'cHost', cHost ...
);

% ppmac.init();

