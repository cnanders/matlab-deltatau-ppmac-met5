try 
    purge
end

clear all
clc

[cDirThis, cName, cExt] = fileparts(mfilename('fullpath'));
cDirSrc = fullfile(cDirThis, '..');
cDirVendor = fullfile(cDirSrc, 'vendor');

% Add src
addpath(genpath(fullfile(cDirSrc)))

% Add vendor ssh
% Needs to be one compiled > 2018.11.14 to have 2048 byte[]
javaaddpath(fullfile(cDirVendor, 'cnanderson', 'deltatau-power-pmac-comm-jre1.7.jar'));

cHostname = '192.168.20.23'; % MET5 endstation subnet

try
    ppmac = deltatau.PowerPmac(...
        'cHostname', cHostname ...
    );
    ppmac.init();
catch mE
    getAllVariablesort(mE);
    
end

tic
ppmac.getReticleCoarseX();
ppmac.getReticleCoarseY();
ppmac.getReticleCoarseZ();
ppmac.getReticleCoarseTip();
ppmac.getReticleCoarseTilt();
ppmac.getWaferCoarseX();
ppmac.getWaferCoarseY();
ppmac.getWaferCoarseZ();
ppmac.getWaferCoarseTip();
ppmac.getWaferCoarseTilt();
ppmac.getVoltageReticleCap1();
ppmac.getVoltageReticleCap2();
ppmac.getVoltageReticleCap3();
ppmac.getVoltageReticleCap4();
toc

pause(2)

tic
ppmac.getReticleCoarseX();
ppmac.getReticleCoarseY();
ppmac.getReticleCoarseZ();
ppmac.getReticleCoarseTip();
ppmac.getReticleCoarseTilt();
ppmac.getWaferCoarseX();
ppmac.getWaferCoarseY();
ppmac.getWaferCoarseZ();
ppmac.getWaferCoarseTip();
ppmac.getWaferCoarseTilt();
ppmac.getVoltageReticleCap1();
ppmac.getVoltageReticleCap2();
ppmac.getVoltageReticleCap3();
ppmac.getVoltageReticleCap4();
toc

pause(2)

tic
ppmac.getReticleCoarseX();
ppmac.getReticleCoarseY();
ppmac.getReticleCoarseZ();
ppmac.getReticleCoarseTip();
ppmac.getReticleCoarseTilt();
ppmac.getWaferCoarseX();
ppmac.getWaferCoarseY();
ppmac.getWaferCoarseZ();
ppmac.getWaferCoarseTip();
ppmac.getWaferCoarseTilt();
ppmac.getVoltageReticleCap1();
ppmac.getVoltageReticleCap2();
ppmac.getVoltageReticleCap3();
ppmac.getVoltageReticleCap4();
toc

pause(2)

tic
ppmac.getAll();
toc


%{
cecVariables = {...
    'RepCS1X', ...
    'RepCS1Y', ...
    'RepCS1Z', ...
    'RepCS1A', ...
    'RepCS1B', ...
    'RepCS2X', ...
    'RepCS2Y', ...
    'RepCS2Z', ...
    'RepCS2A', ...
    'RepCS2B', ...
    'RepCS3Z', ...
    'RepCS4X', ...
    'RepCS4Y', ...
    'RepCS5X' ...
};

tic
ppmac.queryChar(strjoin(cecVariables, ';'));
toc
%}
