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

ppmac = deltatau.PowerPmacVirtual();

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
