clear all
clc

[cDirThis, cName, cExt] = fileparts(mfilename('fullpath'));
cDirSrc = fullfile(cDirThis, '..');
cDirVendor = fullfile(cDirScr, 'vendor');

% Add src
addpath(genpath(fullfile(cDirSrc)))

% Add vendor ssh
addpath(genpath(fullfile(cDirVendor, 'fileexchange', 'ssh2_v2_m1_r6')));

cHost = '198.128.220.144'; % chris mpb at LBNL
cUser = 'cnanderson';
cPass = 'For/24an';

ppmac = deltatau.PowerPmac

