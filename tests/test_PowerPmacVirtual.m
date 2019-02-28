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

tic
ppmac.getReticleCoarseX()
ppmac.getReticleCoarseY()
ppmac.getReticleCoarseZ()
ppmac.getReticleCoarseTip()
ppmac.getReticleCoarseTilt()
ppmac.getWaferCoarseX()
ppmac.getWaferCoarseY()
ppmac.getWaferCoarseZ()
ppmac.getWaferCoarseTip()
ppmac.getWaferCoarseTilt()
ppmac.getReticleCap1V()
ppmac.getReticleCap2V()
ppmac.getReticleCap3V()
ppmac.getReticleCap4V()
toc

pause(2)

tic
ppmac.getReticleCoarseX()
ppmac.getReticleCoarseY()
ppmac.getReticleCoarseZ()
ppmac.getReticleCoarseTip()
ppmac.getReticleCoarseTilt()
ppmac.getWaferCoarseX()
ppmac.getWaferCoarseY()
ppmac.getWaferCoarseZ()
ppmac.getWaferCoarseTip()
ppmac.getWaferCoarseTilt()
ppmac.getReticleCap1V()
ppmac.getReticleCap2V()
ppmac.getReticleCap3V()
ppmac.getReticleCap4V()
toc

pause(2)


