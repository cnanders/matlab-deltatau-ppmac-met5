classdef PowerPmac < handle
        

    properties (Constant)
        
        
    end
    
    properties
        
        % {(java) DeltaTauComm 1x1} 
        jDeltaTauComm
        
    end
    
    properties (Access = private)
        
        % ssh config
        % --------------------------------
        
        % {char 1xm} ssh host
        cHostname = '192.168.0.200'
        
        % {char 1xm} ssh username
        cUsername = 'root';
        
        % {char 1xm} ssh password
        cPassword = 'deltatau';
        
        dTimeout = 5
        
        ticMotorStatus1
        ticMotorStatus2
        ticEncoderError1
        ticEncoderError2
        ticMotorError1
        ticMotorError2 % same page
        ticCSError1
        ticCSStatus1
        ticGlobError
        ticMET50Error
        ticIOInfo
        
        tocMin = 1;
        
        
        % storage for status data to serve if asked for 
        % more often than every tocMin seconds
        
        motorStatus1
        motorStatus2
        encoderError1
        encoderError2
        motorError1
        motorError2 % same page
        csError1
        csStatus1
        globError
        met50Error
        ioInfo
        
        
        
    end
    
    methods
        
        function this = PowerPmac(varargin)
                        
            for k = 1 : 2: length(varargin)
                this.msg(sprintf('passed in %s', varargin{k}));
                if this.hasProp( varargin{k})
                    this.msg(sprintf('settting %s', varargin{k}));
                    this.(varargin{k}) = varargin{k + 1};
                end
            end
        end
        
        function init(this)
            try
               this.jDeltaTauComm = DeltaTauComm(this.cHostname, this.cUsername, this.cPassword);
               % this.startAsciiInterpreter();
               
            catch ME
                rethrow(ME)
            end
        end
        
        %{
        function startAsciiInterpreter(this)
            this.jDeltaTauComm.gpasciiInit(); 
            this.jDeltaTauComm.gpasciiShortAnswers();
        end
        %}

        function connect(this)
            this.msg('connect()');
        end
        
        function disconnect(this)
            this.msg('disconnect()');
            this.jDeltaTauComm.close();
            
        end
        
        function delete(this)
            this.msg('delete()');
            this.disconnect();
        end
        
        
        function setWorkingModeUndefined(this)
            cCmd = sprintf('NewWorkingMode=0');
            this.command(cCmd);
        end
        
        function setWorkingModeActivate(this)
            cCmd = sprintf('NewWorkingMode=1');
            this.command(cCmd);
        end
        
        function setWorkingModeShutdown(this)
            cCmd = sprintf('NewWorkingMode=2');
            this.command(cCmd);
        end
        
        function setWorkingModeRunSetup(this)
            cCmd = sprintf('NewWorkingMode=3');
            this.command(cCmd);
            
        end
        
        function setWorkingModeRunExposure(this)
            cCmd = sprintf('NewWorkingMode=4');
            this.command(cCmd);
        end
        
        function setWorkingModeRun(this)
            cCmd = sprintf('NewWorkingMode=5');
            this.command(cCmd);
        end
        
        function setWorkingModeLsiRun(this)
            cCmd = sprintf('NewWorkingMode=6');
            this.command(cCmd);
        end
        
        function setWorkingModeWaferTransfer(this)
            cCmd = sprintf('NewWorkingMode=7');
            this.command(cCmd);
        end
        
        function setWorkingModeReticleTransfer(this)
            cCmd = sprintf('NewWorkingMode=8');
            this.command(cCmd);
        end
        
        % Returns the working mode formatted as a double
        function d = getActiveWorkingMode(this)
            cCmd = sprintf('ActWorkingMode');
            d = this.queryDouble(cCmd);
        end
        
        % Returns the working mode formatted as a double
        function d = getNewWorkingMode(this)
            cCmd = sprintf('NewWorkingMode');
            d = this.queryDouble(cCmd);
        end
        
        
        %% Getters
        
        % These return true immediately after this coordinate system
        % is instructed to move to a new destinataino and return false
        % once the destination is achieved or after stopAll() is called
        
        function l = getWaferCoarseXYZTipTiltStarted(this)
           cCmd = 'CS1Started';
           l = logical(this.queryInt32(cCmd));
        end
        
        function l = getReticleCoarseXYZTipTiltStarted(this)
           cCmd = 'CS2Started';
           l = logical(this.queryInt32(cCmd));
        end
        
        function l = getWaferFineZStarted(this)
           cCmd = 'CS3Started';
           l = logical(this.queryInt32(cCmd));
        end
        
        function l = getReticleFineXYStarted(this)
           cCmd = 'CS4Started';
           l = logical(this.queryInt32(cCmd));
        end
        
        function l = getLSICoarseXStarted(this)
           cCmd = 'CS5Started';
           l = logical(this.queryInt32(cCmd));
        end
        
        % Returns mm
        function d = getWaferCoarseX(this)
            cCmd = 'RepCS1X';
            d = this.queryDouble(cCmd);
        end
        
        % Returns mm
        function d = getWaferCoarseY(this)
            cCmd = 'RepCS1Y';
            d = this.queryDouble(cCmd);
        end
        
        % Returns um
        function d = getWaferCoarseZ(this)
            cCmd = 'RepCS1Z';
            d = this.queryDouble(cCmd);
        end
        
        % Returns urad
        function d = getWaferCoarseTip(this)
            cCmd = 'RepCS1A';
            d = this.queryDouble(cCmd);
        end
        
        % Returns urad
        function d = getWaferCoarseTilt(this)
            cCmd = 'RepCS1B';
            d = this.queryDouble(cCmd);
        end
        
        % Returns um
        function d = getWaferFineZ(this)
            cCmd = 'RepCS3Z';
            d = this.queryDouble(cCmd);
        end
        
        % returns Volts
        function d = getReticleCap1V(this)
           cCmd = 'DriftCap1_V';
           d = this.queryDouble(cCmd);
        end
        
        % returns Volts
        function d = getReticleCap2V(this)
           cCmd = 'DriftCap2_V';
           d = this.queryDouble(cCmd);
        end
        
        % returns Volts
        function d = getReticleCap3V(this)
           cCmd = 'DriftCap3_V';
           d = this.queryDouble(cCmd);
        end
        
        % returns Volts
        function d = getReticleCap4V(this)
           cCmd = 'DriftCap4_V';
           d = this.queryDouble(cCmd);
            
        end
        
        
        
        % Returns mm
        function d = getReticleCoarseX(this)
            cCmd = 'RepCS2X';
            d = this.queryDouble(cCmd);
        end
        
        % Returns mm
        function d = getReticleCoarseY(this)
            cCmd = 'RepCS2Y';
            d = this.queryDouble(cCmd);
        end
        
        % Returns um
        function d = getReticleCoarseZ(this)
            cCmd = 'RepCS2Z';
            d = this.queryDouble(cCmd);
        end
        
        % Returns urad
        function d = getReticleCoarseTip(this)
            cCmd = 'RepCS2A';
            d = this.queryDouble(cCmd);
        end
        
        % Returns urad
        function d = getReticleCoarseTilt(this)
            cCmd = 'RepCS2B';
            d = this.queryDouble(cCmd);
        end
        
        % Returns um
        function d = getReticleFineX(this)
            cCmd = 'RepCS4X';
            d = this.queryDouble(cCmd);
        end
        
        % Returns um
        function d = getReticleFineY(this)
            cCmd = 'RepCS4Y';
            d = this.queryDouble(cCmd);
        end
        
        % Returns mm
        function d = getLsiCoarseX(this)
            cCmd = 'RepCS5X';
            d = this.queryDouble(cCmd);
        end
        
       %{
                
        % If seen, the corresponding Hydra should be power cycled
                
        % Shows that the servo loop inside 712 controller is not
        % enabled. This can be done with newWorkingMode = wm_ACTIVATE
        
       
        
       
        
        %}
        
        function l = getMotorErrorWaferCoarseXHoming(this)
            l = logical(bitand(this.getMotorError1(), hex2dec('100')));
        end
        
        function l = getMotorErrorWaferCoarseYHoming(this)
            l = logical(bitand(this.getMotorError1(), hex2dec('300')));
        end
        
        function l = getMotorErrorReticleCoarseXHoming(this)
            l = logical(bitand(this.getMotorError1(), hex2dec('400')));
        end
        
        function l = getMotorErrorReticleCoarseYHoming(this)
            l = logical(bitand(this.getMotorError1(), hex2dec('800')));
        end
        
        function l = getMotorErrorLsiCoarseXHoming(this)
            l = logical(bitand(this.getMotorError1(), hex2dec('1000')));
        end
        
        
        % Hydra 1
        function l = getMotorErrorWaferCoarseX(this)
            l = logical(bitand(this.getMotorError1(), hex2dec('10000')));
        end
        
        function l = getMotorErrorWaferCoarseY(this)
            l = logical(bitand(this.getMotorError1(), hex2dec('20000')));
        end
        
        % Hyrda 2
        function l = getMotorErrorReticleCoarseX(this)
            l = logical(bitand(this.getMotorError1(), hex2dec('40000')));
        end
        
        function l = getMotorErrorReticleCoarseY(this)
            l = logical(bitand(this.getMotorError1(), hex2dec('80000')));
        end
        
        % Hydra 3
        function l = getMotorErrorLsiCoarseX(this)
            l = logical(bitand(this.getMotorError1(), hex2dec('100000')));
        end
                
               
        function l = getMotorErrorWaferCoarseZ(this)
            l = logical(bitand(this.getMotorError1(), hex2dec('200000')));
        end
        
        function l = getMotorErrorWaferCoarseTip(this)
            l = logical(bitand(this.getMotorError1(), hex2dec('400000')));
        end
        
        function l = getMotorErrorWaferCoarseTilt(this)
            l = logical(bitand(this.getMotorError1(), hex2dec('800000')));
        end
        
        function l = getMotorErrorWaferFineZ(this)
            l = logical(bitand(this.getMotorError2(), hex2dec('10000')));
        end
        
        
        function l = getMotorErrorReticleCoarseZ(this)
            l = logical(bitand(this.getMotorError2(), hex2dec('20000')));
        end
        
        function l = getMotorErrorReticleCoarseTip(this)
            l = logical(bitand(this.getMotorError2(), hex2dec('40000')));
        end
        
        function l = getMotorErrorReticleCoarseTilt(this)
            l = logical(bitand(this.getMotorError2(), hex2dec('80000')));
        end
        
        function l = getMotorErrorReticleFineX(this)
            l = logical(bitand(this.getMotorError2(), hex2dec('100000')));
        end
        
        function l = getMotorErrorReticleFineY(this)
            l = logical(bitand(this.getMotorError2(), hex2dec('200000')));
        end
         
                 
         
        function l = getMotorErrorWaferCoarseXAltera(this)
            l = logical(bitand(this.getMotorError1(), hex2dec('1000000')));
        end
        
        function l = getMotorErrorWaferCoarseYAltera(this)
            l = logical(bitand(this.getMotorError1(), hex2dec('2000000')));
        end
        
        function l = getMotorErrorReticleCoarseXAltera(this)
            l = logical(bitand(this.getMotorError1(), hex2dec('4000000')));
        end
        
        function l = getMotorErrorReticleCoarseYAltera(this)
            l = logical(bitand(this.getMotorError1(), hex2dec('8000000')));
        end
        
        function l = getMotorErrorLsiCoarseXAltera(this)
            l = logical(bitand(this.getMotorError1(), hex2dec('10000000')));
        end
        
        
        %% MotorStatus1
        
        % Returns locical {1x1}
        function l = getMotorStatusWaferCoarseXIsMoving(this)
            l = logical(bitand(this.getMotorStatus1(), hex2dec('1')));
        end
        
        function l = getMotorStatusWaferCoarseYIsMoving(this)
            l = logical(bitand(this.getMotorStatus1(), hex2dec('2')));
        end
        
        function l = getMotorStatusReticleCoarseXIsMoving(this)
            l = logical(bitand(this.getMotorStatus1(), hex2dec('4')));
        end
        
        function l = getMotorStatusReticleCoarseYIsMoving(this)
            l = logical(bitand(this.getMotorStatus1(), hex2dec('8')));
        end
        
        function l = getMotorStatusLsiCoarseXIsMoving(this)
            % this.msg('getMotorStatusLsiCoarseXIsMoving');
            l = logical(bitand(this.getMotorStatus1(), hex2dec('10')));
        end
        
        function l = getMotorStatusWaferCoarseZIsMoving(this)
            l = logical(bitand(this.getMotorStatus1(), hex2dec('20')));
        end
        
        function l = getMotorStatusWaferCoarseTipIsMoving(this)
            l = logical(bitand(this.getMotorStatus1(), hex2dec('40')));
        end
        
        function l = getMotorStatusWaferCoarseTiltIsMoving(this)
            l = logical(bitand(this.getMotorStatus1(), hex2dec('80')));
        end
        
        
        function l = getMotorStatusOpenLoopWaferCoarseX(this)
            l = logical(bitand(this.getMotorStatus1(), hex2dec('100')));
        end
        function l = getMotorStatusOpenLoopWaferCoarseY(this)
            l = logical(bitand(this.getMotorStatus1(), hex2dec('200')));
        end
        function l = getMotorStatusOpenLoopReticleCoarseX(this)
            l = logical(bitand(this.getMotorStatus1(), hex2dec('400')));
        end
        function l = getMotorStatusOpenLoopReticleCoarseY(this)
            l = logical(bitand(this.getMotorStatus1(), hex2dec('800')));
        end
        
        function l = getMotorStatusOpenLoopLsiCoarseX(this)
            l = logical(bitand(this.getMotorStatus1(), hex2dec('1000')));
        end
        function l = getMotorStatusOpenLoopWaferCoarseZ(this)
            l = logical(bitand(this.getMotorStatus1(), hex2dec('2000')));
        end
        function l = getMotorStatusOpenLoopWaferCoarseTip(this)
            l = logical(bitand(this.getMotorStatus1(), hex2dec('4000')));
        end
        function l = getMotorStatusOpenLoopWaferCoarseTilt(this)
            l = logical(bitand(this.getMotorStatus1(), hex2dec('8000')));
        end
        
        function l = getMotorStatusMinusLimitWaferCoarseX(this)
            l = logical(bitand(this.getMotorStatus1(), hex2dec('10000')));
        end
        function l = getMotorStatusMinusLimitWaferCoarseY(this)
            l = logical(bitand(this.getMotorStatus1(), hex2dec('20000')));
        end
        function l = getMotorStatusMinusLimitReticleCoarseX(this)
            l = logical(bitand(this.getMotorStatus1(), hex2dec('40000')));
        end
        function l = getMotorStatusMinusLimitReticleCoarseY(this)
            l = logical(bitand(this.getMotorStatus1(), hex2dec('80000')));
        end
        
        function l = getMotorStatusMinusLimitLsiCoarseX(this)
            l = logical(bitand(this.getMotorStatus1(), hex2dec('100000')));
        end
        function l = getMotorStatusMinusLimitWaferCoarseZ(this)
            l = logical(bitand(this.getMotorStatus1(), hex2dec('200000')));
        end
        function l = getMotorStatusMinusLimitWaferCoarseTip(this)
            l = logical(bitand(this.getMotorStatus1(), hex2dec('400000')));
        end
        function l = getMotorStatusMinusLimitWaferCoarseTilt(this)
            l = logical(bitand(this.getMotorStatus1(), hex2dec('800000')));
        end
        
        
        function l = getMotorStatusPlusLimitWaferCoarseX(this)
            l = logical(bitand(this.getMotorStatus1(), hex2dec('1000000')));
        end
        function l = getMotorStatusPlusLimitWaferCoarseY(this)
            l = logical(bitand(this.getMotorStatus1(), hex2dec('2000000')));
        end
        function l = getMotorStatusPlusLimitReticleCoarseX(this)
            l = logical(bitand(this.getMotorStatus1(), hex2dec('4000000')));
        end
        function l = getMotorStatusPlusLimitReticleCoarseY(this)
            l = logical(bitand(this.getMotorStatus1(), hex2dec('8000000')));
        end
        
        function l = getMotorStatusPlusLimitLsiCoarseX(this)
            l = logical(bitand(this.getMotorStatus1(), hex2dec('10000000')));
        end
        function l = getMotorStatusPlusLimitWaferCoarseZ(this)
            l = logical(bitand(this.getMotorStatus1(), hex2dec('20000000')));
        end
        function l = getMotorStatusPlusLimitWaferCoarseTip(this)
            l = logical(bitand(this.getMotorStatus1(), hex2dec('40000000')));
        end
        function l = getMotorStatusPlusLimitWaferCoarseTilt(this)
            l = logical(bitand(this.getMotorStatus1(), hex2dec('80000000')));
        end
        
        
        
        
                
        %% MotorStatus2
        
        
        function l = getMotorStatusWaferFineZIsMoving(this)
            l = logical(bitand(this.getMotorStatus2(), hex2dec('1')));
        end
        
        function l = getMotorStatusReticleCoarseZIsMoving(this)
            l = logical(bitand(this.getMotorStatus2(), hex2dec('2')));
        end
        
        function l = getMotorStatusReticleCoarseTipIsMoving(this)
            l = logical(bitand(this.getMotorStatus2(), hex2dec('4')));
        end
        
        function l = getMotorStatusReticleCoarseTiltIsMoving(this)
            l = logical(bitand(this.getMotorStatus2(), hex2dec('8')));
        end
        
        function l = getMotorStatusReticleFineXIsMoving(this)
            l = logical(bitand(this.getMotorStatus2(), hex2dec('10')));
        end
        
        function l = getMotorStatusReticleFineYIsMoving(this)
            l = logical(bitand(this.getMotorStatus2(), hex2dec('20')));
        end
        
        

         
        function l = getMotorStatusOpenLoopWaferFineZ(this)
            l = logical(bitand(this.getMotorStatus2(), hex2dec('100')));
        end
        function l = getMotorStatusOpenLoopReticleCoarseZ(this)
            l = logical(bitand(this.getMotorStatus2(), hex2dec('200')));
        end
        function l = getMotorStatusOpenLoopReticleCoarseTip(this)
            l = logical(bitand(this.getMotorStatus2(), hex2dec('400')));
        end
        function l = getMotorStatusOpenLoopReticleCoarseTilt(this)
            l = logical(bitand(this.getMotorStatus2(), hex2dec('800')));
        end
        
        function l = getMotorStatusOpenLoopReticleFineX(this)
            l = logical(bitand(this.getMotorStatus2(), hex2dec('1000')));
        end
        function l = getMotorStatusOpenLoopReticleFineY(this)
            l = logical(bitand(this.getMotorStatus2(), hex2dec('2000')));
        end
       
        
        function l = getMotorStatusMinusLimitWaferFineZ(this)
            l = logical(bitand(this.getMotorStatus2(), hex2dec('10000')));
        end
        function l = getMotorStatusMinusLimitReticleCoarseZ(this)
            l = logical(bitand(this.getMotorStatus2(), hex2dec('20000')));
        end
        function l = getMotorStatusMinusLimitReticleCoarseTip(this)
            l = logical(bitand(this.getMotorStatus2(), hex2dec('40000')));
        end
        function l = getMotorStatusMinusLimitReticleCoarseTilt(this)
            l = logical(bitand(this.getMotorStatus2(), hex2dec('80000')));
        end
        
        function l = getMotorStatusMinusLimitReticleFineX(this)
            l = logical(bitand(this.getMotorStatus2(), hex2dec('100000')));
        end
        function l = getMotorStatusMinusLimitReticleFineY(this)
            l = logical(bitand(this.getMotorStatus2(), hex2dec('200000')));
        end
        
        
        
        function l = getMotorStatusPlusLimitWaferFineZ(this)
            l = logical(bitand(this.getMotorStatus2(), hex2dec('1000000')));
        end
        function l = getMotorStatusPlusLimitReticleCoarseZ(this)
            l = logical(bitand(this.getMotorStatus2(), hex2dec('2000000')));
        end
        function l = getMotorStatusPlusLimitReticleCoarseTip(this)
            l = logical(bitand(this.getMotorStatus2(), hex2dec('4000000')));
        end
        function l = getMotorStatusPlusLimitReticleCoarseTilt(this)
            l = logical(bitand(this.getMotorStatus2(), hex2dec('8000000')));
        end
        
        function l = getMotorStatusPlusLimitReticleFineX(this)
            l = logical(bitand(this.getMotorStatus2(), hex2dec('10000000')));
        end
        function l = getMotorStatusPlusLimitReticleFineY(this)
            l = logical(bitand(this.getMotorStatus2(), hex2dec('20000000')));
        end
        
        
        
        
        
        
        % EncoderError (loss)
        
        function l = getEncoderErrorLossWaferCoarseX(this)
            l = logical(bitand(this.getEncoderError1(), hex2dec('1')));
        end
        
        function l = getEncoderErrorLossWaferCoarseY(this)
            l = logical(bitand(this.getEncoderError1(), hex2dec('2')));
        end
        function l = getEncoderErrorLossReticleCoarseX(this)
            l = logical(bitand(this.getEncoderError1(), hex2dec('4')));
        end
        function l = getEncoderErrorLossReticleCoarseY(this)
            l = logical(bitand(this.getEncoderError1(), hex2dec('8')));
        end
        function l = getEncoderErrorLossLsiCoarseX(this)
            l = logical(bitand(this.getEncoderError1(), hex2dec('10')));
        end
        
        % EncoderError Error
        
        function l = getEncoderErrorWaferCoarseX(this)
            l = logical(bitand(this.getEncoderError1(), hex2dec('100')));
        end
        
        function l = getEncoderErrorWaferCoarseY(this)
            l = logical(bitand(this.getEncoderError1(), hex2dec('200')));
        end
        function l = getEncoderErrorReticleCoarseX(this)
            l = logical(bitand(this.getEncoderError1(), hex2dec('400')));
        end
        function l = getEncoderErrorReticleCoarseY(this)
            l = logical(bitand(this.getEncoderError1(), hex2dec('800')));
        end
        function l = getEncoderErrorLsiCoarseX(this)
            l = logical(bitand(this.getEncoderError1(), hex2dec('1000')));
        end
        
        
        function l = getEncoderErrorWaferCoarseZ(this)
            l = logical(bitand(this.getEncoderError1(), hex2dec('2000')));
        end
        function l = getEncoderErrorWaferCoarseTip(this)
            l = logical(bitand(this.getEncoderError1(), hex2dec('4000')));
        end
        
        function l = getEncoderErrorWaferCoarseTilt(this)
            l = logical(bitand(this.getEncoderError1(), hex2dec('8000')));
        end
        
        function l = getEncoderErrorWaferFineZ(this)
            l = logical(bitand(this.getEncoderError2(), hex2dec('100')));
        end
        
        function l = getEncoderErrorReticleCoarseZ(this)
            l = logical(bitand(this.getEncoderError2(), hex2dec('200')));
        end
        
        function l = getEncoderErrorReticleCoarseTip(this)
            l = logical(bitand(this.getEncoderError2(), hex2dec('400')));
        end
        
        function l = getEncoderErrorReticleCoarseTilt(this)
            l = logical(bitand(this.getEncoderError2(), hex2dec('800')));
        end
        
        function l = getEncoderErrorReticleFineX(this)
            l = logical(bitand(this.getEncoderError2(), hex2dec('1000')));
        end
        
        function l = getEncoderErrorReticleFineY(this)
            l = logical(bitand(this.getEncoderError2(), hex2dec('2000')));
        end
        
        
        
        
        % CSError (runtime)
        
        function l = getCsErrorWaferCoarseRunTime(this)
            l = logical(bitand(this.getCsError1(), hex2dec('1')));
        end
        
        function l = getCsErrorReticleCoarseRunTime(this)
            l = logical(bitand(this.getCsError1(), hex2dec('2')));
        end
        
        
        function l = getCsErrorWaferFineRunTime(this)
            l = logical(bitand(this.getCsError1(), hex2dec('4')));
        end
        
        function l = getCsErrorReticleFineRunTime(this)
            l = logical(bitand(this.getCsError1(), hex2dec('8')));
        end
        
        function l = getCsErrorLsiCoarseRunTime(this)
            l = logical(bitand(this.getCsError1(), hex2dec('10')));
        end
        
        % CSError (limit stop)
        
        function l = getCsErrorWaferCoarseLimitStop(this)
            l = logical(bitand(this.getCsError1(), hex2dec('100')));
        end
        
        function l = getCsErrorReticleCoarseLimitStop(this)
            l = logical(bitand(this.getCsError1(), hex2dec('200')));
        end
        
        
        function l = getCsErrorWaferFineLimitStop(this)
            l = logical(bitand(this.getCsError1(), hex2dec('400')));
        end
        
        function l = getCsErrorReticleFineLimitStop(this)
            l = logical(bitand(this.getCsError1(), hex2dec('800')));
        end
        
        function l = getCsErrorLsiCoarseLimitStop(this)
            l = logical(bitand(this.getCsError1(), hex2dec('1000')));
        end
        
        
        % CSError (error status)
        
        function l = getCsErrorWaferCoarseErrorStatus(this)
            l = logical(bitand(this.getCsError1(), hex2dec('10000')));
        end
        
        function l = getCsErrorReticleCoarseErrorStatus(this)
            l = logical(bitand(this.getCsError1(), hex2dec('20000')));
        end
        
        
        function l = getCsErrorWaferFineErrorStatus(this)
            l = logical(bitand(this.getCsError1(), hex2dec('40000')));
        end
        
        function l = getCsErrorReticleFineErrorStatus(this)
            l = logical(bitand(this.getCsError1(), hex2dec('80000')));
        end
        
        function l = getCsErrorLsiCoarseErrorStatus(this)
            l = logical(bitand(this.getCsError1(), hex2dec('100000')));
        end
        
        
        % CSError (soft limit)
        
        function l = getCsErrorWaferCoarseSoftLimit(this)
            l = logical(bitand(this.getCsError1(), hex2dec('1000000')));
        end
        
        function l = getCsErrorReticleCoarseSoftLimit(this)
            l = logical(bitand(this.getCsError1(), hex2dec('2000000')));
        end
        
        
        function l = getCsErrorWaferFineSoftLimit(this)
            l = logical(bitand(this.getCsError1(), hex2dec('4000000')));
        end
        
        function l = getCsErrorReticleFineSoftLimit(this)
            l = logical(bitand(this.getCsError1(), hex2dec('8000000')));
        end
        
        function l = getCsErrorLsiCoarseSoftLimit(this)
            l = logical(bitand(this.getCsError1(), hex2dec('10000000')));
        end
        
        
                
        % CSStatus (program running)
        
        function l = getCsStatusWaferCoarseProgramRunning(this)
            l = logical(bitand(this.getCsStatus1(), hex2dec('1')));
        end
        
        function l = getCsStatusReticleCoarseProgramRunning(this)
            l = logical(bitand(this.getCsStatus1(), hex2dec('2')));
        end
        
        
        function l = getCsStatusWaferFineProgramRunning(this)
            l = logical(bitand(this.getCsStatus1(), hex2dec('4')));
        end
        
        function l = getCsStatusReticleFineProgramRunning(this)
            l = logical(bitand(this.getCsStatus1(), hex2dec('8')));
        end
        
        function l = getCsStatusLsiCoarseProgramRunning(this)
            l = logical(bitand(this.getCsStatus1(), hex2dec('10')));
        end
        
        
        % CSStatus (not homed)
        
        function l = getCsStatusWaferCoarseNotHomed(this)
            l = logical(bitand(this.getCsStatus1(), hex2dec('100')));
        end
        
        function l = getCsStatusReticleCoarseNotHomed(this)
            l = logical(bitand(this.getCsStatus1(), hex2dec('200')));
        end
        
        
        function l = getCsStatusWaferFineNotHomed(this)
            l = logical(bitand(this.getCsStatus1(), hex2dec('400')));
        end
        
        function l = getCsStatusReticleFineNotHomed(this)
            l = logical(bitand(this.getCsStatus1(), hex2dec('800')));
        end
        
        function l = getCsStatusLsiCoarseNotHomed(this)
            l = logical(bitand(this.getCsStatus1(), hex2dec('1000')));
        end
        
        
        
        
        % CSStatus (timebase deviation)
        
        function l = getCsStatusWaferCoarseTimebaseDeviation(this)
            l = logical(bitand(this.getCsStatus1(), hex2dec('1000000')));
        end
        
        function l = getCsStatusReticleCoarseTimebaseDeviation(this)
            l = logical(bitand(this.getCsStatus1(), hex2dec('2000000')));
        end
        
        
        function l = getCsStatusWaferFineTimebaseDeviation(this)
            l = logical(bitand(this.getCsStatus1(), hex2dec('4000000')));
        end
        
        function l = getCsStatusReticleFineTimebaseDeviation(this)
            l = logical(bitand(this.getCsStatus1(), hex2dec('8000000')));
        end
        
        function l = getCsStatusLsiCoarseTimebaseDeviation(this)
            l = logical(bitand(this.getCsStatus1(), hex2dec('10000000')));
        end
        
        
        
        function l = getGlobErrorNoClocks(this)
            l = logical(bitand(this.getGlobError(), hex2dec('1')));
        end
        
        function l = getGlobErrorWdtFault(this)
            l = logical(bitand(this.getGlobError(), hex2dec('2')));
        end
        
        function l = getGlobErrorHwChangeError(this)
            l = logical(bitand(this.getGlobError(), hex2dec('4')));
        end
        
        function l = getGlobErrorSysPhaseErrorCtr(this)
            l = logical(bitand(this.getGlobError(), hex2dec('100')));
        end
        
        function l = getGlobErrorSysServoBusyCtr(this)
            l = logical(bitand(this.getGlobError(), hex2dec('400')));
        end
        
        function l = getGlobErrorSysServoErrorCtr(this)
            l = logical(bitand(this.getGlobError(), hex2dec('800')));
        end
        
        function l = getGlobErrorSysRtIntBusyCtr(this)
            l = logical(bitand(this.getGlobError(), hex2dec('1000')));
        end
        
        function l = getGlobErrorSysRtIntErrorCtr(this)
            l = logical(bitand(this.getGlobError(), hex2dec('2000')));
        end
        
        % MET50 Errors
        
        % 712 Read / Write Error
        
        function l = getMet50Error7121WriteError(this)
            l = logical(bitand(this.getMET50Error(), hex2dec('1')));
        end
        
        function l = getMet50Error7121ReadError(this)
            l = logical(bitand(this.getMET50Error(), hex2dec('4')));
        end
        
        function l = getMet50Error7122WriteError(this)
            l = logical(bitand(this.getMET50Error(), hex2dec('2')));
        end
        
        function l = getMet50Error7122ReadError(this)
            l = logical(bitand(this.getMET50Error(), hex2dec('8')));
        end
        
        % Hydra Not Connected
        
        function l = getMet50ErrorHydra1NotConnected(this)
            l = logical(bitand(this.getMET50Error(), hex2dec('10')));
        end
        
        function l = getMet50ErrorHydra2NotConnected(this)
            l = logical(bitand(this.getMET50Error(), hex2dec('20')));
        end
        
        function l = getMet50ErrorHydra3NotConnected(this)
            l = logical(bitand(this.getMET50Error(), hex2dec('40')));
        end
        
        % Hydra Machine Error
        
        function l = getMet50ErrorHydra1MachineError(this)
            l = logical(bitand(this.getMET50Error(), hex2dec('100')));
        end
        
        function l = getMet50ErrorHydra2MachineError(this)
            l = logical(bitand(this.getMET50Error(), hex2dec('200')));
        end
        
        function l = getMet50ErrorHydra3MachineError(this)
            l = logical(bitand(this.getMET50Error(), hex2dec('400')));
        end
        
        % 712 Not Connected
        
        function l = getMet50Error7121NotConnected(this)
           
            l = logical(bitand(this.getMET50Error(), hex2dec('1000')));
        end
        
        function l = getMet50Error7122NotConnected(this)
            l = logical(bitand(this.getMET50Error(), hex2dec('2000')));
        end
        
        function l = getMet50ErrorModBusNotConnected(this)
            l = logical(bitand(this.getMET50Error(), hex2dec('10000')));
        end
        
        function l = getMet50ErrorHsStatus(this)
            l = logical(bitand(this.getMET50Error(), hex2dec('20000')));
        end
        
        function l = getMet50ErrorDmiStatus(this)
            l = logical(bitand(this.getMET50Error(), hex2dec('40000')));
        end
        
        function l = getMet50ErrorCAppNotRunning(this)
            l = logical(bitand(this.getMET50Error(), hex2dec('80000')));
        end
        
        function l = getMet50ErrorMoxaNotConnected(this)
            l = logical(bitand(this.getMET50Error(), hex2dec('100000')));
        end
        
        function l = getMet50ErrorTemperatureWarning(this)
            l = logical(bitand(this.getMET50Error(), hex2dec('200000')));
        end
        
        function l = getMet50ErrorTemperatureError(this)
            l = logical(bitand(this.getMET50Error(), hex2dec('400000')));
        end
        
        function l = getMet50ErrorProximitySwitchWaferXLsi(this)
            
            l = logical(bitand(this.getMET50Error(), hex2dec('800000')));
        end
        
        % IO Info
        function l = getIoInfoLockWaferPosition(this)
            l = logical(bitand(this.getIoInfo(), hex2dec('1')));
        end
        
        function l = getIoInfoLockReticlePosition(this)
            l = logical(bitand(this.getIoInfo(), hex2dec('2')));
        end
        
        function l = getIoInfoEnableSystemIsZero(this)
            l = logical(bitand(this.getIoInfo(), hex2dec('4')));
        end
        
        
        function l = getIoInfoAtWaferTransferPosition(this)
            l = logical(bitand(this.getIoInfo(), hex2dec('100')));
        end
        
        function l = getIoInfoAtReticleTransferPosition(this)
            l = logical(bitand(this.getIoInfo(), hex2dec('200')));
        end
        
        function l = getIoInfoWaferPositionLocked(this)
            l = logical(bitand(this.getIoInfo(), hex2dec('400')));
        end
        
        function l = getIoInfoReticlePositionLocked(this)
            l = logical(bitand(this.getIoInfo(), hex2dec('800')));
        end
        
        function l = getIoInfoSystemEnabledIsZero(this)
            l = logical(bitand(this.getIoInfo(), hex2dec('1000')));
        end
        
        % Returns the Motor 1 to Motor 8 32-bit integer status
        % See page 20 of the manual for more info.  The returned value
        % can be bitand ed to get moving, open loop, on neg limit, and on
        % pos limit of motors 1 - 8.  Motor number assignments are on page
        % 8 of the PPMAC_LBNL_2_6.doc
        function u32 = getMotorStatus1(this)
            
            if ~isempty(this.ticMotorStatus1)
                if (toc(this.ticMotorStatus1) < this.tocMin)
                    u32 = this.motorStatus1;
                    return;
                end
            end
            cCmd = 'PMACMotorStatus1';
            u32 = this.queryInt32(cCmd);
            this.ticMotorStatus1 = tic();
            this.motorStatus1 = u32;
        end
        
        % See getMotorStatus1
        function u32 = getMotorStatus2(this)
            
            if ~isempty(this.ticMotorStatus2)
                if (toc(this.ticMotorStatus2) < this.tocMin)
                    u32 = this.motorStatus2;
                    return;
                end
            end
            
            cCmd = 'PMACMotorStatus2';
            u32 = this.queryInt32(cCmd);
            this.ticMotorStatus2 = tic();
            this.motorStatus2 = u32;
        end
        
        function u32 = getEncoderError1(this)
            
            if ~isempty(this.ticEncoderError1)
                if (toc(this.ticEncoderError1) < this.tocMin)
                    u32 = this.encoderError1;
                    return;
                end
            end
            cCmd = 'PMACEncoderError1';
            u32 = this.queryInt32(cCmd);
            this.ticEncoderError1 = tic();
            this.encoderError1 = u32;
        end
        
        function u32 = getEncoderError2(this)
            if ~isempty(this.ticEncoderError2)
                if (toc(this.ticEncoderError2) < this.tocMin)
                    u32 = this.encoderError2;
                    return;
                end
            end
            cCmd = 'PMACEncoderError2';
            u32 = this.queryInt32(cCmd);
            this.ticEncoderError2 = tic();
            this.encoderError2 = u32;
        end
        
        function u32 = getMotorError1(this)
            if ~isempty(this.ticMotorError1)
                if (toc(this.ticMotorError1) < this.tocMin)
                    u32 = this.motorError1;
                    return;
                end
            end
            cCmd = 'PMACMotorError1';
            u32 = this.queryInt32(cCmd);
            this.ticMotorError1 = tic();
            this.motorError1 = u32;
        end
        
        function u32 = getMotorError2(this)
            if ~isempty(this.ticMotorError2)
                if (toc(this.ticMotorError2) < this.tocMin)
                    u32 = this.motorError2;
                    return;
                end
            end
            cCmd = 'PMACMotorError2';
            u32 = this.queryInt32(cCmd);
            this.ticMotorError2 = tic();
            this.motorError2 = u32;
        end
        
        function u32 = getCsError1(this)
            if ~isempty(this.ticCSError1)
                if (toc(this.ticCSError1) < this.tocMin)
                    u32 = this.csError1;
                    return;
                end
            end
            cCmd = 'PMACCSError1';
            u32 = this.queryInt32(cCmd);
            this.ticCSError1 = tic();
            this.csError1 = u32;
        end
        
        function u32 = getCsStatus1(this)
            if ~isempty(this.ticCSStatus1)
                if (toc(this.ticCSStatus1) < this.tocMin)
                    u32 = this.csStatus1;
                    return;
                end
            end
            cCmd = 'PMACCSStatus1';
            u32 = this.queryInt32(cCmd);
            this.ticCSStatus1 = tic();
            this.csStatus1 = u32;
        end
        
        function u32 = getGlobError(this)
            if ~isempty(this.ticGlobError)
                if (toc(this.ticGlobError) < this.tocMin)
                    u32 = this.globError;
                    return;
                end
            end
            cCmd = 'PMACGlobError';
            u32 = this.queryInt32(cCmd);
            this.ticGlobError = tic();
            this.globError = u32;
        end
        
        function u32 = getMET50Error(this)
            if ~isempty(this.ticMET50Error)
                if (toc(this.ticMET50Error) < this.tocMin)
                    u32 = this.met50Error;
                    return;
                end
            end
            cCmd = 'PMACMET50Error';
            u32 = this.queryInt32(cCmd);
            this.ticMET50Error = tic();
            %{
            cMsg = sprintf(...
                'deltatau.PowerPmac getMet50Error() HEX: %s\n', ...
                dec2hex(u32, 8) ...
            );
            this.msg(cMsg);
            %}
            this.met50Error = u32;
        end
        
        function u32 = getIoInfo(this)
            if ~isempty(this.ticIOInfo)
                if (toc(this.ticIOInfo) < this.tocMin)
                    u32 = this.ioInfo;
                    return;
                end
            end
            cCmd = 'PMACIOInfo';
            u32 = this.queryInt32(cCmd);
            this.ticIOInfo = tic();
            this.ioInfo = u32;
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
            
            
        % @param {double 1x1} dVal - mm
        function setWaferCoarseX(this, dVal)
            cCmd = sprintf('DestCS1X=%1.6f;', dVal);
            this.command(['&1a;', 'CSxReady=-1;', cCmd, 'CommandCode=14']);
        end
        
        % @param {double 1x1} dVal - mm
        function setWaferCoarseY(this, dVal)
            cCmd = sprintf('DestCS1Y=%1.6f;', dVal);
            this.command(['&1a;', 'CSxReady=-1;', cCmd, 'CommandCode=14']);
        end
        
        % @param {double 1x1} dVal - um
        function setWaferCoarseZ(this, dVal)
            cCmd = sprintf('DestCS1Z=%1.6f;', dVal);
            this.command(['&1a;', 'CSxReady=-1;', cCmd, 'CommandCode=14']);
        end
        
        % @param {double 1x1} dVal - urad
        function setWaferCoarseTip(this, dVal)
            cCmd = sprintf('DestCS1A=%1.6f;', dVal);
            this.command(['&1a;', 'CSxReady=-1;', cCmd, 'CommandCode=14']);
        end
        
        % @param {double 1x1} dVal - urad
        function setWaferCoarseTilt(this, dVal)
            cCmd = sprintf('DestCS1B=%1.6f;', dVal);
            this.command(['&1a;', 'CSxReady=-1;', cCmd, 'CommandCode=14']);
        end
        
        % @param {double 1x1} dVal - um
        function setWaferFineZ(this, dVal)
            cCmd = sprintf('DestCS3Z=%1.6f;', dVal);
            this.command(['&3a;', 'CSxReady=-1;', cCmd, 'CommandCode=34']);
        end
                
        % @param {double 1x1} dVal - mm
        function setReticleCoarseX(this, dVal)
            cCmd = sprintf('DestCS2X=%1.6f;', dVal);
            this.command(['&2a;', 'CSxReady=-1;', cCmd, 'CommandCode=24']);
        end
        
        % @param {double 1x1} dVal - mm
        function setReticleCoarseY(this, dVal)
            cCmd = sprintf('DestCS2Y=%1.6f;', dVal);
            this.command(['&2a;', 'CSxReady=-1;', cCmd, 'CommandCode=24']);
        end
        
        % @param {double 1x1} dVal - um
        function setReticleCoarseZ(this, dVal)
            
            cCmd = sprintf('DestCS2Z=%1.6f;', dVal);
            this.command(['&2a;', 'CSxReady=-1;', cCmd, 'CommandCode=24']);
        end
        
        % @param {double 1x1} dVal - urad
        function setReticleCoarseTip(this, dVal)
            
            cCmd = sprintf('DestCS2A=%1.6f;', dVal);
            this.command(['&2a;', 'CSxReady=-1;', cCmd, 'CommandCode=24']);
        end
        
        % @param {double 1x1} dVal - urad
        function setReticleCoarseTilt(this, dVal)
            cCmd = sprintf('DestCS2B=%1.6f;', dVal);
            this.command(['&2a;', 'CSxReady=-1;', cCmd, 'CommandCode=24']);
        end
        
        
        % @param {double 1x1} dVal - um
        function setReticleFineX(this, dVal)
            cCmd = sprintf('DestCS4X=%1.6f;', dVal);
            this.command(['&4a;', 'CSxReady=-1;', cCmd, 'CommandCode=44']);
            
        end
        
        % @param {double 1x1} dVal - um
        function setReticleFineY(this, dVal)
            cCmd = sprintf('DestCS4Y=%1.6f;', dVal);
            this.command(['&4a;', 'CSxReady=-1;', cCmd, 'CommandCode=44']);
            
        end
        
        
        % @param {double 1x1} dVal - mm
        function setLsiCoarseX(this, dVal)
            cCmd = sprintf('DestCS5X=%1.6f;', dVal);
            this.command(['&5a;', 'CSxReady=-1;', cCmd, 'CommandCode=54']);
        end
                
        
        % Send a query command and get the result back as ASCII
        function c = queryChar(this, cCmd)
            c = this.jDeltaTauComm.gpasciiQuery(cCmd);
        end
        
        % Send a query command and get the result formated as a double
        function d = queryDouble(this, cCmd)
            c = this.queryChar(cCmd);
            % strip leading '#' char
            % c = c(1:end);
            
            % If there is a timeout, jDeltaTauComm will return an empty
            % string.  str2double('') returns NaN which is no bueno. 
            if strcmp(c, '')
                d = 0;
            else
                d = str2double(c);
            end
        end
        
        % Send a query command and get the result formatted as a 32-bit int
        function u32 = queryInt32(this, cCmd)
           c = this.queryChar(cCmd);
           u32 = str2num(c);
        end
        
        % Send a "set" command
        function command(this, cCmd)
            fprintf('deletatau.PowerPmac command(%s)\n', cCmd);
            this.jDeltaTauComm.gpasciiCommand(cCmd);
        end
        
        function stopAll(this)
            
            % Issues stop and resets all CSXStarted flags to zero.  In
            % practice, this tells the controller that the previously
            % issued destinations it was trying to reach are now invalid 
            % (since the user hit stop) and we are ready for new commands
            
            cCmd = [...
                'CommandCode=1;', ...
                'CS1Started=0;', ...
                'CS2Started=0;', ...
                'CS3Started=0;', ...
                'CS4Started=0;', ...
                'CS5Started=0;' ...
            ];
            this.jDeltaTauComm.gpasciiCommand(cCmd);
        end
        
        
    end
    
    
    methods (Access = protected)
        
        function l = hasProp(this, c)
            
            l = false;
            if ~isempty(findprop(this, c))
                l = true;
            end
            
        end
        
        function msg(this, cMsg)
            fprintf('deltatau.PowerPmac %s\n', cMsg);
        end

    end
    
end

