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


cParams = {'Min', 'Grad'};
cLevels = {'Low', 'Norm', 'High'};

for j = 1:length(cLevels)
  for k = 1:length(cParams)
    for l = 1:3 % hydras
        mEnd = 2;
        if l == 3
            mEnd = 1;
        end
        for m = 1:mEnd
            % sprintf('%s-%s-%d-%d', cParams{k}, cLevels{j}, l, m);
            ppmac.getMot(cParams{k}, cLevels{j}, l, m);
        end
    end
  end
end
                        
ppmac.getMot('Min', 'Low', 1, 1)
ppmac.setMot('Grad', 'High', 1, 2, 6.1)
ppmac.getMot('Grad', 'High', 1, 2)


