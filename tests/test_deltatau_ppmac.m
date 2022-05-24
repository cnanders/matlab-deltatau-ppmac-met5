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
catch mE
   mE;
end


ppmac.getXReticleCoarse()
ppmac.getYReticleCoarse()
ppmac.getZReticleCoarse()
ppmac.getTiltXReticleCoarse()
ppmac.getTiltYReticleCoarse()
ppmac.getXWaferCoarse()
ppmac.getYWaferCoarse()
ppmac.getZWaferCoarse()
ppmac.getTiltXWaferCoarse()
ppmac.getTiltYWaferCoarse()
ppmac.getVoltageReticleCap1()
ppmac.getVoltageReticleCap2()
ppmac.getVoltageReticleCap3()
ppmac.getVoltageReticleCap4()

disp('reticle fine');
ppmac.getDemandSpeedReticleFine()
ppmac.getDemandAccelTimeReticleFine()
ppmac.getDemandAccelTimeBlendedReticleFine()


disp('wafer coarse');
ppmac.getDemandSpeedWaferCoarse()
ppmac.getDemandAccelTimeWaferCoarse()
ppmac.getDemandAccelTimeBlendedWaferCoarse()


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
