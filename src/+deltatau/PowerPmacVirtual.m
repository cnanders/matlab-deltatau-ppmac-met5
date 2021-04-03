classdef PowerPmacVirtual < deltatau.AbstractPowerPmac
        

    
    properties (Access = private)
        
        dMeanCap = 2;
        dSigCap = 0.5;
        
        dWorkingMode = 0
        dMotMinWaferCoarseX = 0
        dMotMinWaferCoarseY = 0
        dMotMinReticleCoarseX = 0
        dMotMinReticleCoarseY = 0
        dMotMinLsiX = 0
        
        dXWaferCoarse = 0
        dYWaferCoarse = 0
        dZWaferCoarse = 0
        dTiltXWaferCoarse = 0
        dTiltYWaferCoarse = 0
        
        dZWaferFine = 0;
        
        dXReticleCoarse = 0
        dYReticleCoarse = 0
        dZReticleCoarse = 0
        dTiltXReticleCoarse = 0
        dTiltYReticleCoarse = 0
        
        dXReticleFine = 0
        dYReticleFine = 0
        
        dXLsiCoarse = 450;
        
        dAccelWaferCoarse = 400;
        dAccelReticleCoarse = 400;
        
        dAccelBlendedWaferCoarse = 400;
        dAccelBlendedReticleCoarse = 400;
        
        dDemandSpeedWaferCoarse = 98
        dDemandSpeedReticleCoarse = 99
        
        dInvAccelMaxOfMotor = [1/251e-6 1/252e-6]
        dInvDecelMaxOfMotor = [1/151e-6 1/152e-6]
        dSpeedMaxOfMotor = [51e-3 52e-3]
        
        
        dVelHydraWaferX = 24;
        dVelHydraWaferY = 24
        dAccelHydraWaferX = 996
        dAccelHydraWaferY = 997
        dDecelHydraWaferX = 998
        dDecelHydraWaferY = 999
        
    end
   
    methods
        
        
        function sendCommandCode(this, u8Val)
            fprintf('deltatau.PowerPmacVirtual.sendCommandCode(%d)\n', u8Val);
        end
        
        
        % x, y, z (mm)
        % tiltX, tiltY (urad)
        function setLocalWaferTransferPosition(this, dX, dY, dZ, dTiltX, dTiltY)
            
        end
        
         % x, y, z (mm)
         % tiltX, tiltY (urad)
        function setLocalReticleTransferPosition(this, dX, dY, dZ, dTiltX, dTiltY)
            
        end

        function setWorkingModeUndefined(this)
            this.dWorkingMode = 0;
        end
        
        function setWorkingModeActivate(this)
            this.dWorkingMode = 1;
        end
        
        function setWorkingModeShutdown(this)
            this.dWorkingMode = 2;
        end
        
        function setWorkingModeRunSetup(this)
            this.dWorkingMode = 3;
        end
        
        function setWorkingModeRunExposure(this)
            this.dWorkingMode = 4;
        end
        
        function setWorkingModeRun(this)
            this.dWorkingMode = 5;
        end
        
        function setWorkingModeLsiRun(this)
            this.dWorkingMode = 6;
        end
        
        function setWorkingModeWaferTransfer(this)
            this.dWorkingMode = 7;
        end
        
        function setWorkingModeReticleTransfer(this)
            this.dWorkingMode = 8;
        end
        
        % Returns the working mode formatted as a double
        function d = getActiveWorkingMode(this)
            d = this.dWorkingMode;
        end
        
        % Returns the working mode formatted as a double
        function d = getNewWorkingMode(this)
            d = this.dWorkingMode;
        end
        
        
        %% Getters
        
        % These return true immediately after this coordinate system
        % is instructed to move to a new destinataino and return false
        % once the destination is achieved or after stopAll() is called
        
        function d = getMotMinWaferCoarseX(this)
            d = this.dMotMinWaferCoarseX;
        end
        
        function d = getMotMinWaferCoarseY(this)
            d = this.dMotMinWaferCoarseY;
        end
        
        function d = getMotMinReticleCoarseX(this)
            d = this.dMotMinReticleCoarseX;
        end
        
        function d = getMotMinReticleCoarseY(this)
            d = this.dMotMinReticleCoarseY;
        end
        
        function d = getMotMinLsiCoarseX(this)
            d = this.dMotMinLsiX;
        end
        
        function l = getIsStartedWaferCoarseXYZTipTilt(this)
            l = false;
        end
        
        function l = getIsStartedReticleCoarseXYZTipTilt(this)
           l = false;
        end
        
        function l = getIsStartedWaferFineZ(this)
           l = false;
        end
        
        function l = getIsStartedReticleFineXY(this)
           l = false;
        end
        
        function l = getIsStartedLsiCoarseX(this)
           l = false;
        end
        
        % Returns mm
        function d = getXWaferCoarse(this)
            d = this.dXWaferCoarse;
        end
        
        % Returns mm
        function d = getYWaferCoarse(this)
            d = this.dYWaferCoarse;
        end
        
        % Returns um
        function d = getZWaferCoarse(this)
           d = this.dZWaferCoarse; 
        end
        
        % Returns urad
        function d = getTiltXWaferCoarse(this)
            d = this.dTiltXWaferCoarse;
        end
        
        % Returns urad
        function d = getTiltYWaferCoarse(this)
            d = this.dTiltYWaferCoarse;
        end
        
        % Returns um
        function d = getZWaferFine(this)
            d = this.dZWaferFine;
        end
        
        % Returns the voltage [-5 5] of the DeltaTau ACC20E 16-bit ADC board
        % that are connected to the DAQ of the Lion Amplifier of the Cap
        % Sensors
        % 16-bit gives signed values in [-32768, 32767] 32768 is 2^15
        % Board 2 is connected to slots 1 - 4 of the Lion Chassis
        % Board 3 is connected to slots 5 - 8 of the Lion Chassis
        % This command can be used to get the values of the Mod3 and
        % POB cap sensors sensing the retielc and wafer, respectively
        function d = getAcc28EADCValue(this, u8Board, u8Channel)
            
            d = this.dMeanCap + this.dSigCap * randn(1);
        end
        
               
        
        % returns Volts
        function d = getVoltageReticleCap1(this)
           d = this.dMeanCap + this.dSigCap * randn(1);
        end
        
        % returns Volts
        function d = getVoltageReticleCap2(this)
           d = this.dMeanCap + this.dSigCap * randn(1);
        end
        
        % returns Volts
        function d = getVoltageReticleCap3(this)
           d = this.dMeanCap + this.dSigCap * randn(1);
        end
        
        % returns Volts
        function d = getVoltageReticleCap4(this)
            d = this.dMeanCap + this.dSigCap * randn(1);
           
            
        end
        
        
        
        
        % Returns mm
        function d = getXReticleCoarse(this)
            d = this.dXReticleCoarse;
            
        end
        
        % Returns mm
        function d = getYReticleCoarse(this)
            d = this.dYReticleCoarse;
        end
        
        % Returns um
        function d = getZReticleCoarse(this)
            d = this.dZReticleCoarse;
        end
        
        % Returns urad
        function d = getTiltXReticleCoarse(this)
            d = this.dTiltXReticleCoarse;
        end
        
        % Returns urad
        function d = getTiltYReticleCoarse(this)
            d = this.dTiltYReticleCoarse;
        end
        
        % Returns um
        function d = getXReticleFine(this)
            d = this.dXReticleFine;
        end
        
        % Returns um
        function d = getYReticleFine(this)
            d = this.dYReticleFine;
        end
        
        % Returns mm
        function d = getXLsiCoarse(this)
            d = this.dXLsiCoarse;
        end
        

        function l = getMotorErrorWaferCoarseXHoming(this)
            l = this.getRandomLogical();
        end
        
        function l = getMotorErrorWaferCoarseYHoming(this)
            l = this.getRandomLogical();
        end
        
        function l = getMotorErrorReticleCoarseXHoming(this)
            l = this.getRandomLogical();
        end
        
        function l = getMotorErrorReticleCoarseYHoming(this)
            l = this.getRandomLogical();
        end
        
        function l = getMotorErrorLsiCoarseXHoming(this)
            l = this.getRandomLogical(); 
        end
        
        
        % Hydra 1
        function l = getMotorErrorWaferCoarseX(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMotorErrorWaferCoarseY(this)
           l = this.getRandomLogical();
        end
        
        % Hyrda 2
        function l = getMotorErrorReticleCoarseX(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMotorErrorReticleCoarseY(this)
            l = this.getRandomLogical(); 
        end
        
        % Hydra 3
        function l = getMotorErrorLsiCoarseX(this)
            l = this.getRandomLogical(); 
        end
                
               
        function l = getMotorErrorWaferCoarseZ(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMotorErrorWaferCoarseTip(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMotorErrorWaferCoarseTilt(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMotorErrorWaferFineZ(this)
            l = this.getRandomLogical(); 
        end
        
        
        function l = getMotorErrorReticleCoarseZ(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMotorErrorReticleCoarseTip(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMotorErrorReticleCoarseTilt(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMotorErrorReticleFineX(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMotorErrorReticleFineY(this)
            l = this.getRandomLogical(); 
        end
         
                 
         
        function l = getMotorErrorWaferCoarseXAltera(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMotorErrorWaferCoarseYAltera(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMotorErrorReticleCoarseXAltera(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMotorErrorReticleCoarseYAltera(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMotorErrorLsiCoarseXAltera(this)
            l = this.getRandomLogical(); 
        end
        
        
        %% MotorStatus1
        
        % Returns locical {1x1}
        function l = getMotorStatusWaferCoarseXIsMoving(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMotorStatusWaferCoarseYIsMoving(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMotorStatusReticleCoarseXIsMoving(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMotorStatusReticleCoarseYIsMoving(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMotorStatusLsiCoarseXIsMoving(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMotorStatusWaferCoarseZIsMoving(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMotorStatusWaferCoarseTipIsMoving(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMotorStatusWaferCoarseTiltIsMoving(this)
            l = this.getRandomLogical(); 
        end
        
        
        function l = getMotorStatusOpenLoopWaferCoarseX(this)
            l = this.getRandomLogical(); 
        end
        function l = getMotorStatusOpenLoopWaferCoarseY(this)
            l = this.getRandomLogical(); 
        end
        function l = getMotorStatusOpenLoopReticleCoarseX(this)
            l = this.getRandomLogical(); 
        end
        function l = getMotorStatusOpenLoopReticleCoarseY(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMotorStatusOpenLoopLsiCoarseX(this)
            l = this.getRandomLogical(); 
        end
        function l = getMotorStatusOpenLoopWaferCoarseZ(this)
            l = this.getRandomLogical(); 
        end
        function l = getMotorStatusOpenLoopWaferCoarseTip(this)
            l = this.getRandomLogical(); 
        end
        function l = getMotorStatusOpenLoopWaferCoarseTilt(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMotorStatusMinusLimitWaferCoarseX(this)
            l = this.getRandomLogical(); 
        end
        function l = getMotorStatusMinusLimitWaferCoarseY(this)
            l = this.getRandomLogical(); 
        end
        function l = getMotorStatusMinusLimitReticleCoarseX(this)
            l = this.getRandomLogical(); 
        end
        function l = getMotorStatusMinusLimitReticleCoarseY(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMotorStatusMinusLimitLsiCoarseX(this)
            
            l = this.getRandomLogical(); 
        end
        function l = getMotorStatusMinusLimitWaferCoarseZ(this)
            l = this.getRandomLogical(); 
        end
        function l = getMotorStatusMinusLimitWaferCoarseTip(this)
            l = this.getRandomLogical(); 
        end
        function l = getMotorStatusMinusLimitWaferCoarseTilt(this)
            l = this.getRandomLogical(); 
        end
        
        
        function l = getMotorStatusPlusLimitWaferCoarseX(this)
            l = this.getRandomLogical(); 
        end
        function l = getMotorStatusPlusLimitWaferCoarseY(this)
            l = this.getRandomLogical(); 
        end
        function l = getMotorStatusPlusLimitReticleCoarseX(this)
            l = this.getRandomLogical(); 
        end
        function l = getMotorStatusPlusLimitReticleCoarseY(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMotorStatusPlusLimitLsiCoarseX(this)
            l = this.getRandomLogical(); 
        end
        function l = getMotorStatusPlusLimitWaferCoarseZ(this)
            l = this.getRandomLogical(); 
        end
        function l = getMotorStatusPlusLimitWaferCoarseTip(this)
            l = this.getRandomLogical(); 
        end
        function l = getMotorStatusPlusLimitWaferCoarseTilt(this)
            l = this.getRandomLogical(); 
        end
        
        
        
        
                
        %% MotorStatus2
        
        
        function l = getMotorStatusWaferFineZIsMoving(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMotorStatusReticleCoarseZIsMoving(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMotorStatusReticleCoarseTipIsMoving(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMotorStatusReticleCoarseTiltIsMoving(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMotorStatusReticleFineXIsMoving(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMotorStatusReticleFineYIsMoving(this)
            l = this.getRandomLogical(); 
        end
        
        

         
        function l = getMotorStatusOpenLoopWaferFineZ(this)
            l = this.getRandomLogical(); 
        end
        function l = getMotorStatusOpenLoopReticleCoarseZ(this)
            l = this.getRandomLogical(); 
        end
        function l = getMotorStatusOpenLoopReticleCoarseTip(this)
            l = this.getRandomLogical(); 
        end
        function l = getMotorStatusOpenLoopReticleCoarseTilt(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMotorStatusOpenLoopReticleFineX(this)
            l = this.getRandomLogical(); 
        end
        function l = getMotorStatusOpenLoopReticleFineY(this)
            l = this.getRandomLogical(); 
        end
       
        
        function l = getMotorStatusMinusLimitWaferFineZ(this)
            l = this.getRandomLogical(); 
        end
        function l = getMotorStatusMinusLimitReticleCoarseZ(this)
            l = this.getRandomLogical(); 
        end
        function l = getMotorStatusMinusLimitReticleCoarseTip(this)
            l = this.getRandomLogical(); 
        end
        function l = getMotorStatusMinusLimitReticleCoarseTilt(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMotorStatusMinusLimitReticleFineX(this)
            l = this.getRandomLogical(); 
        end
        function l = getMotorStatusMinusLimitReticleFineY(this)
            l = this.getRandomLogical(); 
        end
        
        
        
        function l = getMotorStatusPlusLimitWaferFineZ(this)
            l = this.getRandomLogical(); 
        end
        function l = getMotorStatusPlusLimitReticleCoarseZ(this)
            l = this.getRandomLogical(); 
        end
        function l = getMotorStatusPlusLimitReticleCoarseTip(this)
            l = this.getRandomLogical(); 
        end
        function l = getMotorStatusPlusLimitReticleCoarseTilt(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMotorStatusPlusLimitReticleFineX(this)
            l = this.getRandomLogical(); 
        end
        function l = getMotorStatusPlusLimitReticleFineY(this)
            l = this.getRandomLogical(); 
        end
        
        
        
        
        
        
        % EncoderError (loss)
        
        function l = getEncoderErrorLossWaferCoarseX(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getEncoderErrorLossWaferCoarseY(this)
            l = this.getRandomLogical(); 
        end
        function l = getEncoderErrorLossReticleCoarseX(this)
            l = this.getRandomLogical(); 
        end
        function l = getEncoderErrorLossReticleCoarseY(this)
            l = this.getRandomLogical(); 
        end
        function l = getEncoderErrorLossLsiCoarseX(this)
            l = this.getRandomLogical(); 
        end
        
        % EncoderError Error
        
        function l = getEncoderErrorWaferCoarseX(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getEncoderErrorWaferCoarseY(this)
            l = this.getRandomLogical(); 
        end
        function l = getEncoderErrorReticleCoarseX(this)
            l = this.getRandomLogical(); 
        end
        function l = getEncoderErrorReticleCoarseY(this)
            l = this.getRandomLogical(); 
        end
        function l = getEncoderErrorLsiCoarseX(this)
            l = this.getRandomLogical(); 
        end
        
        
        function l = getEncoderErrorWaferCoarseZ(this)
            l = this.getRandomLogical(); 
        end
        function l = getEncoderErrorWaferCoarseTip(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getEncoderErrorWaferCoarseTilt(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getEncoderErrorWaferFineZ(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getEncoderErrorReticleCoarseZ(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getEncoderErrorReticleCoarseTip(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getEncoderErrorReticleCoarseTilt(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getEncoderErrorReticleFineX(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getEncoderErrorReticleFineY(this)
            l = this.getRandomLogical(); 
        end
        
        
        
        
        % CSError (runtime)
        
        function l = getCsErrorWaferCoarseRunTime(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getCsErrorReticleCoarseRunTime(this)
            l = this.getRandomLogical(); 
        end
        
        
        function l = getCsErrorWaferFineRunTime(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getCsErrorReticleFineRunTime(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getCsErrorLsiCoarseRunTime(this)
            l = this.getRandomLogical(); 
        end
        
        % CSError (limit stop)
        
        function l = getCsErrorWaferCoarseLimitStop(this)
            l = this.getRandomLogical(); 
            
        end
        
        function l = getCsErrorReticleCoarseLimitStop(this)
            l = this.getRandomLogical(); 
        end
        
        
        function l = getCsErrorWaferFineLimitStop(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getCsErrorReticleFineLimitStop(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getCsErrorLsiCoarseLimitStop(this)
            l = this.getRandomLogical(); 
        end
        
        
        % CSError (error status)
        
        function l = getCsErrorWaferCoarseErrorStatus(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getCsErrorReticleCoarseErrorStatus(this)
            l = this.getRandomLogical(); 
        end
        
        
        function l = getCsErrorWaferFineErrorStatus(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getCsErrorReticleFineErrorStatus(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getCsErrorLsiCoarseErrorStatus(this)
            l = this.getRandomLogical(); 
        end
        
        
        % CSError (soft limit)
        
        function l = getCsErrorWaferCoarseSoftLimit(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getCsErrorReticleCoarseSoftLimit(this)
            l = this.getRandomLogical(); 
        end
        
        
        function l = getCsErrorWaferFineSoftLimit(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getCsErrorReticleFineSoftLimit(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getCsErrorLsiCoarseSoftLimit(this)
            l = this.getRandomLogical(); 
        end
        
        
                
        % CSStatus (program running)
        
        function l = getCsStatusWaferCoarseProgramRunning(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getCsStatusReticleCoarseProgramRunning(this)
            l = this.getRandomLogical(); 
        end
        
        
        function l = getCsStatusWaferFineProgramRunning(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getCsStatusReticleFineProgramRunning(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getCsStatusLsiCoarseProgramRunning(this)
            l = this.getRandomLogical(); 
        end
        
        
        % CSStatus (not homed)
        
        function l = getCsStatusWaferCoarseNotHomed(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getCsStatusReticleCoarseNotHomed(this)
            l = this.getRandomLogical(); 
        end
        
        
        function l = getCsStatusWaferFineNotHomed(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getCsStatusReticleFineNotHomed(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getCsStatusLsiCoarseNotHomed(this)
            l = this.getRandomLogical(); 
        end
        
        
        
        
        % CSStatus (timebase deviation)
        
        function l = getCsStatusWaferCoarseTimebaseDeviation(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getCsStatusReticleCoarseTimebaseDeviation(this)
            l = this.getRandomLogical(); 
        end
        
        
        function l = getCsStatusWaferFineTimebaseDeviation(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getCsStatusReticleFineTimebaseDeviation(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getCsStatusLsiCoarseTimebaseDeviation(this)
            l = this.getRandomLogical(); 
        end
        
        
        
        function l = getGlobErrorNoClocks(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getGlobErrorWdtFault(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getGlobErrorHwChangeError(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getGlobErrorSysPhaseErrorCtr(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getGlobErrorSysServoBusyCtr(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getGlobErrorSysServoErrorCtr(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getGlobErrorSysRtIntBusyCtr(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getGlobErrorSysRtIntErrorCtr(this)
            l = this.getRandomLogical(); 
        end
        
        % MET50 Errors
        
        % 712 Read / Write Error
        
        function l = getMet50Error7121WriteError(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMet50Error7121ReadError(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMet50Error7122WriteError(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMet50Error7122ReadError(this)
            l = this.getRandomLogical(); 
        end
        
        % Hydra Not Connected
        
        function l = getMet50ErrorHydra1NotConnected(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMet50ErrorHydra2NotConnected(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMet50ErrorHydra3NotConnected(this)
            l = this.getRandomLogical(); 
        end
        
        % Hydra Machine Error
        
        function l = getMet50ErrorHydra1MachineError(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMet50ErrorHydra2MachineError(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMet50ErrorHydra3MachineError(this)
            l = this.getRandomLogical(); 
        end
        
        % 712 Not Connected
        
        function l = getMet50Error7121NotConnected(this)
            l = this.getRandomLogical(); 
           
        end
        
        function l = getMet50Error7122NotConnected(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMet50ErrorModBusNotConnected(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMet50ErrorHsStatus(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMet50ErrorDmiStatus(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMet50ErrorCAppNotRunning(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMet50ErrorMoxaNotConnected(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMet50ErrorTemperatureWarning(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMet50ErrorTemperatureError(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getMet50ErrorProximitySwitchWaferXLsi(this)
            l = this.getRandomLogical(); 
            
        end
        
        % IO Info
        function l = getIoInfoLockWaferPosition(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getIoInfoLockReticlePosition(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getIoInfoEnableSystemIsZero(this)
            l = this.getRandomLogical(); 
        end
        
        
        function l = getIoInfoAtWaferTransferPosition(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getIoInfoAtReticleTransferPosition(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getIoInfoWaferPositionLocked(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getIoInfoReticlePositionLocked(this)
            l = this.getRandomLogical(); 
        end
        
        function l = getIoInfoSystemEnabledIsZero(this)
            l = this.getRandomLogical(); 
        end
        
        
                        
        %% Setters
        
        % &1a stops cs1, &2a stops cs2, etc. HOWEVER, stopping doordinate 
        % system 1, 2, 3, etc. prematurely
        % will set CSxReady = -2, -4, -8, -16, -32, respectively so need
        % to change the value of CSxReady before issuing a new CommandCode
        
        % CSxReady=1 readys the system for new commands.  
        % CSxReady=-1 has the benefit of not saying ready.  While the
        % system is moving, CSxReady = 0.  CSxReady = 1 only after a move
        % completes
        % update destinatin
        % CommandCode=24 moves cs2 to destinations
            
        % Expire the cache for all sets
            
        % @param {double 1x1} dVal - mm
        
        function setXYZTiltXTiltYWaferCoarse(this, dX, dY, dZ, dTiltX, dTiltY)
            this.dXWaferCoarse = dX;
            this.dYWaferCoarse = dY;
            this.dZWaferCoarse = dZ;
            this.dTiltXWaferCoarse = dTiltX;
            this.dTiltYWaferCoarse = dTiltY;
            
        end
        
        
        function setXWaferCoarse(this, dVal)
            this.dXWaferCoarse = dVal;
            
        end
        
        % @param {double 1x1} dVal - mm
        function setYWaferCoarse(this, dVal)
            this.dYWaferCoarse = dVal;
        end
        
        % @param {double 1x1} dVal - um
        function setZWaferCoarse(this, dVal)
            this.dZWaferCoarse = dVal;
        end
        
        % @param {double 1x1} dVal - urad
        function setTiltXWaferCoarse(this, dVal)
            this.dTiltXWaferCoarse = dVal;
        end
        
        % @param {double 1x1} dVal - urad
        function setTiltYWaferCoarse(this, dVal)
            this.dTiltYWaferCoarse = dVal;
        end
        
        % @param {double 1x1} dVal - um
        function setZWaferFine(this, dVal)
            this.dZWaferFine = dVal;
        end
              
        
        function setXYZTiltXTiltYReticleCoarse(this, dX, dY, dZ, dTiltX, dTiltY)
            this.dXReticleCoarse = dX;
            this.dYReticleCoarse = dY;
            this.dZReticleCoarse = dZ;
            this.dTiltXReticleCoarse = dTiltX;
            this.dTiltYReticleCoarse = dTiltY;
            
        end
        
        
        % @param {double 1x1} dVal - mm
        function setXReticleCoarse(this, dVal)
           this.dXReticleCoarse = dVal;
        end
        
        % @param {double 1x1} dVal - mm
        function setYReticleCoarse(this, dVal)
            this.dYReticleCoarse = dVal;
        end
        
        % @param {double 1x1} dVal - um
        function setZReticleCoarse(this, dVal)
            this.dZReticleCoarse = dVal;
        end
        
        % @param {double 1x1} dVal - urad
        function setTiltXReticleCoarse(this, dVal)
            this.dTiltXReticleCoarse = dVal;
        end
        
        % @param {double 1x1} dVal - urad
        function setTiltYReticleCoarse(this, dVal)
            this.dTiltYReticleCoarse = dVal;
        end
        
        
        % @param {double 1x1} dVal - um
        function setXReticleFine(this, dVal)
            this.dXReticleFine = dVal;
        end
        
        % @param {double 1x1} dVal - um
        function setYReticleFine(this, dVal)
            this.dYReticleFine = dVal;
        end
        
        
        % @param {double 1x1} dVal - mm
        function setXLsiCoarse(this, dVal)
            this.dXLsiCoarse = dVal;

        end
        
        
        function setMotMinWaferCoarseX(this, dVal)
            this.dMotMinWaferCoarseX = dVal;
                
        end
        
        function setMotMinWaferCoarseY(this, dVal)
            this.dMotMinWaferCoarseY = dVal;
                
        end
        
        function setMotMinReticleCoarseX(this, dVal)
            this.dMotMinReticleCoarseX = dVal;
        end
        
        function setMotMinReticleCoarseY(this, dVal)
            this.dMotMinReticleCoarseY = dVal; 
        end
        
        function setMotMinLsiCoarseX(this, dVal)
            this.dMotMinLsiX = dVal;
        end
                

        function stopAll(this)
            
            
        end
        
        function setDemandAccelTimeWaferCoarse(this, dVal)
            this.dAccelWaferCoarse = dVal;
        end
        % @param {double 1x1} time in milliseconds to reach max speed
        function setDemandAccelTimeReticleCoarse(this, dVal)
            this.dAccelReticleCoarse = dVal;
        end
        
        function d = getDemandAccelTimeWaferCoarse(this)
            d = this.dAccelWaferCoarse;
        end
        function d = getDemandAccelTimeReticleCoarse(this)
            d = this.dAccelReticleCoarse;
        end
        
        
        function setDemandAccelTimeBlendedWaferCoarse(this, dVal)
            this.dAccelBlendedWaferCoarse = dVal;
        end
        % @param {double 1x1} time in milliseconds to reach max speed
        function setDemandAccelTimeBlendedReticleCoarse(this, dVal)
            this.dAccelBlendedReticleCoarse = dVal;
        end
        
        function d = getDemandAccelTimeBlendedWaferCoarse(this)
            d = this.dAccelBlendedWaferCoarse;
        end
        function d = getDemandAccelTimeBlendedReticleCoarse(this)
            d = this.dAccelBlendedReticleCoarse;
        end
        
        
        % units of accel are m/s/s
        % Reasonable values are 
        %  50 um/s/s, pass in 50e-6
        %  250 um/s/s, pass in 250e-6
        % under the hood, uses InvDmax, which is the inverse of this value
        % and has units of s2/m
        function setDecelMaxOfMotor(this, u8Motor, dVal)
            this.dInvDecelMaxOfMotor(u8Motor) = 1/dVal;
        end
        
        % see above
        function setAccelMaxOfMotor(this, u8Motor, dVal)
            this.dInvAccelMaxOfMotor(u8Motor) = 1/dVal;
        end
        
        function d = getDecelMaxOfMotor(this, u8Motor)
            d = 1./this.dInvDecelMaxOfMotor(u8Motor);
        end
        
        % see above
        function d = getAccelMaxOfMotor(this, u8Motor)
            d = 1./this.dInvAccelMaxOfMotor(u8Motor);
        end
        
        % units are m/s.  So a value like 0.02 is 20 mm/s
        function setSpeedMaxOfMotor(this, u8Motor, dVal)
            this.dSpeedMaxOfMotor(u8Motor) = dVal;
        end
        
        function d = getSpeedMaxOfMotor(this, u8Motor)
            d = this.dSpeedMaxOfMotor(u8Motor);
        end
        
        %%%
        
        function d = getVelHydraWaferX(this)
            d = this.dVelHydraWaferX;
        end
        
        function d = getVelHydraWaferY(this)
            d = this.dVelHydraWaferY;
        end
        
        function d = getAccelHydraWaferX(this)
            d = this.dAccelHydraWaferX;
        end
        
        function d = getAccelHydraWaferY(this)
            d = this.dAccelHydraWaferY;
        end
        
        function d = getDecelHydraWaferX(this)
            d = this.dDecelHydraWaferX;
        end
        
        function d = getDecelHydraWaferY(this)
            d = this.dDecelHydraWaferY;
        end
        
        %% Set
        
        function setVelHydraWaferX(this, dVal)
            this.dVelHydraWaferX = dVal;
        end
        
        function setVelHydraWaferY(this, dVal)
            this.dVelHydraWaferY = dVal;
        end
        
        function setAccelHydraWaferX(this, dVal)
            this.dAccelHydraWaferX = dVal;
        end
        
        function setAccelHydraWaferY(this, dVal)
            this.dAccelHydraWaferY = dVal;
        end
        
        function setDecelHydraWaferX(this, dVal)
            this.dDecelHydraWaferX = dVal;
        end
        
        function setDecelHydraWaferY(this, dVal)
            this.dDecelHydraWaferY = dVal;
        end
        
        
        function d = getDemandSpeedWaferCoarse(this)
            d = this.dDemandSpeedWaferCoarse;
        end
        
        function d = getDemandSpeedReticleCoarse(this)
            d = this.dDemandSpeedReticleCoarse;
        end
        
        function setDemandSpeedWaferCoarse(this, dVal)
            this.dDemandSpeedWaferCoarse = dVal;
        end
        function setDemandSpeedReticleCoarse(this, dVal)
            this.dDemandSpeedReticleCoarse = dVal;
            
        end
        

        
        
    end
    
    methods (Access = private)
        
        function l = getRandomLogical(this)
            l = randn(1) >= 0;
        end
        
    end
    
    
    
    
end

