clear all
clc

[cDirThis, cName, cExt] = fileparts(mfilename('fullpath'));
cDirSrc = fullfile(cDirThis, '..');
cDirVendor = fullfile(cDirSrc, 'vendor');

% Add src
addpath(genpath(fullfile(cDirSrc)))

% Add vendor ssh
javaaddpath(fullfile(cDirVendor, 'cnanderson', 'deltatau-power-pmac-comm-jre1.7.jar'));


cHostname = '192.168.20.23'; % MET5 endstation subnet

ppmac = deltatau.PowerPmac(...
    'cHostname', cHostname ...
);

ppmac.init();

