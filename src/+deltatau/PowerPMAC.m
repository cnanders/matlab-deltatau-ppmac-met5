classdef PowerPMAC < handle
        

    properties (Constant)
        
        
    end
    
    properties
        
        % {struct 1x1} structure with lots of information about the 
        % ssh connection.  See vendor/fileexchange/ssh2_v2_m1_r6/ssh_setup
        stSSH
        
    end
    
    properties (Access = private)
        
        % ssh config
        % --------------------------------
        
        % {char 1xm} ssh host
        cHost = '192.168.0.200'
        
        % {char 1xm} ssh username
        cUsername = 'root';
        
        % {char 1xm} ssh password
        cPassword = 'deltatau';
        
        dTimeout = 5
    end
    
    methods
        
        function this = PowerPMAC(varargin)
                        
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
               this.stSSH = ssh2_config(this.cHost, this.cUsername, this.cPassword);
               this.startAsciiInterpreter();
            catch ME
                rethrow(ME)
            end
        end
        
        function startAsciiInterpreter(this)
            this.stSSH = ssh2_command(this.stSSH, 'gpascii -2');             
        end

        function connect(this)
            this.msg('connect()');
            % tcpclient does not need fopen()
            this.clearBytesAvailable();
        end
        
        function disconnect(this)
            this.msg('disconnect()');
            ss2_close(this.stSSH);
            
        end
        
        function delete(this)
            this.msg('delete()');
            this.disconnect();
        end
        
        
        function setWorkingModeUndefined(this)
            cCmd = sprintf('newWorkingMode=0');
            this.command(cCmd);
        end
        
        function setWorkingModeActivate(this)
            cCmd = sprintf('newWorkingMode=1');
            this.command(cCmd);
        end
        
        function setWorkingModeShutdown(this)
            cCmd = sprintf('newWorkingMode=2');
            this.command(cCmd);
        end
        
        function setWorkingModeRunSetup(this)
            cCmd = sprintf('newWorkingMode=3');
            this.command(cCmd);
            
        end
        
        function setWorkingModeRunExposure(this)
            cCmd = sprintf('newWorkingMode=4');
            this.command(cCmd);
        end
        
        function setWorkingModeRun(this)
            cCmd = sprintf('newWorkingMode=5');
            this.command(cCmd);
        end
        
        function setWorkingModeLsiRun(this)
            cCmd = sprintf('newWorkingMode=6');
            this.command(cCmd);
        end
        
        function setWorkingModeWaferTransfer(this)
            cCmd = sprintf('newWorkingMode=7');
            this.command(cCmd);
        end
        
        function setWorkingModeReticleTransfer(this)
            cCmd = sprintf('newWorkingMode=8');
            this.command(cCmd);
        end
        
        % Returns the working mode formatted as a double
        function d = getActiveWorkingMode(this)
            cCmd = sprintf('actWorkingMode');
            d = this.queryDouble(cCmd);
        end
        
        %% Getters
        
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
            cCmd = 'RepCS4X';
            d = this.queryDouble(cCmd);
        end
        
        % Returns mm
        function d = getLsiCoarseX(this)
            cCmd = 'RepCS5X';
            d = this.queryDouble(cCmd);
        end
        
        % Returns locical {1x1}
        function l = getWaferCoarseXIsMoving(this)
            l = logical(bitand(this.getMotor1To8Status(), hex2dec('1')));
        end
        
        function l = getWaferCoarseYIsMoving(this)
            l = logical(bitand(this.getMotor1To8Status(), hex2dec('2')));
        end
        
        function l = getReticleCoarseXIsMoving(this)
            l = logical(bitand(this.getMotor1To8Status(), hex2dec('4')));
        end
        
        function l = getReticleCoarseYIsMoving(this)
            l = logical(bitand(this.getMotor1To8Status(), hex2dec('8')));
        end
        
        function l = getLsiCoarseXIsMoving(this)
            l = logical(bitand(this.getMotor1To8Status(), hex2dec('10')));
        end
        
        function l = getWaferCoarseZIsMoving(this)
            l = logical(bitand(this.getMotor1To8Status(), hex2dec('20')));
        end
        
        function l = getWaferCoarseTipIsMoving(this)
            l = logical(bitand(this.getMotor1To8Status(), hex2dec('40')));
        end
        
        function l = getWaferCoarseTiltIsMoving(this)
            l = logical(bitand(this.getMotor1To8Status(), hex2dec('80')));
        end
        
        function l = getWaferFineZIsMoving(this)
            l = logical(bitand(this.getMotor9To14Status(), hex2dec('1')));
        end
        
        function l = getReticleCoarseZIsMoving(this)
            l = logical(bitand(this.getMotor9To14Status(), hex2dec('2')));
        end
        
        function l = getReticleCoarseTipIsMoving(this)
            l = logical(bitand(this.getMotor9To14Status(), hex2dec('4')));
        end
        
        function l = getReticleCoarseTiltIsMoving(this)
            l = logical(bitand(this.getMotor9To14Status(), hex2dec('8')));
        end
        
        function l = getReticleFineXIsMoving(this)
            l = logical(bitand(this.getMotor9To14Status(), hex2dec('10')));
        end
        
        function l = getReticleFineYIsMoving(this)
            l = logical(bitand(this.getMotor9To14Status(), hex2dec('20')));
        end
        
        % Returns the Motor 1 to Motor 8 32-bit integer status
        % See page 20 of the manual for more info.  The returned value
        % can be bitand ed to get moving, open loop, on neg limit, and on
        % pos limit of motors 1 - 8.  Motor number assignments are on page
        % 8 of the PPMAC_LBNL_2_6.doc
        function u32 = getMotor1To8Status(this)
            cCmd = 'PMACMotorStatus1';
            u32 = this.queryInt32(cCmd);
        end
        
        % See getMotor1To8Status
        function u32 = getMotor9To14Status(this)
            cCmd = 'PMACMotorStatus2';
            u32 = this.queryInt32(cCmd);
        end
        
        
        %% Setters
        
        % @param {double 1x1} dVal - mm
        function setWaferCoarseX(this, dVal)
            cCmd = sprintf('DestCS1X=%1.6f', dVal);
            this.command(cCmd);
            this.command('CommandCode=14');
        end
        
        % @param {double 1x1} dVal - mm
        function setWaferCoarseY(this, dVal)
            cCmd = sprintf('DestCS1Y=%1.6f', dVal);
            this.command(cCmd);
            this.command('CommandCode=14');
        end
        
        % @param {double 1x1} dVal - um
        function setWaferCoarseZ(this, dVal)
            cCmd = sprintf('DestCS1Z=%1.6f', dVal);
            this.command(cCmd);
            this.command('CommandCode=14');
        end
        
        % @param {double 1x1} dVal - urad
        function setWaferCoarseTip(this, dVal)
            cCmd = sprintf('DestCS1A=%1.6f', dVal);
            this.command(cCmd);
            this.command('CommandCode=14');
        end
        
        % @param {double 1x1} dVal - urad
        function setWaferCoarseTilt(this, dVal)
            cCmd = sprintf('DestCS1B=%1.6f', dVal);
            this.command(cCmd);
            this.command('CommandCode=14');
        end
        
        % @param {double 1x1} dVal - um
        function setWaferFineZ(this, dVal)
            cCmd = sprintf('DestCS3Z=%1.6f', dVal);
            this.command(cCmd);
            this.command('CommandCode=34');
        end
                
        % @param {double 1x1} dVal - mm
        function setReticleCoarseX(this, dVal)
            cCmd = sprintf('DestCS2X=%1.6f', dVal);
            this.command(cCmd);
            this.command('CommandCode=24');
        end
        
        % @param {double 1x1} dVal - mm
        function setReticleCoarseY(this, dVal)
            cCmd = sprintf('DestCS2Y=%1.6f', dVal);
            this.command(cCmd);
            this.command('CommandCode=24');
        end
        
        % @param {double 1x1} dVal - um
        function setReticleCoarseZ(this, dVal)
            cCmd = sprintf('DestCS2Z=%1.6f', dVal);
            this.command(cCmd);
            this.command('CommandCode=24');
        end
        
        % @param {double 1x1} dVal - urad
        function setReticleCoarseTip(this, dVal)
            cCmd = sprintf('DestCS2A=%1.6f', dVal);
            this.command(cCmd);
            this.command('CommandCode=24');
        end
        
        % @param {double 1x1} dVal - urad
        function setReticleCoarseTilt(this, dVal)
            cCmd = sprintf('DestCS2B=%1.6f', dVal);
            this.command(cCmd);
            this.command('CommandCode=24');
        end
        
        
        % @param {double 1x1} dVal - um
        function setReticleFineX(this, dVal)
            cCmd = sprintf('DestCS4X=%1.6f', dVal);
            this.command(cCmd);
            this.command('CommandCode=44');
        end
        
        % @param {double 1x1} dVal - um
        function setReticleFineY(this, dVal)
            cCmd = sprintf('DestCS4X=%1.6f', dVal);
            this.command(cCmd);
            this.command('CommandCode=44');
            
        end
        
        
        % @param {double 1x1} dVal - mm
        function setLsiCoarseX(this, dVal)
            cCmd = sprintf('DestCS5X=%1.6f', dVal);
            this.command(cCmd);
            this.command('CommandCode=54');
        end
        
                   
        
        
        % Send a command and get the result back as ASCII
        function c = queryChar(this, cCmd)
            [this.stSSH, c] = ssh2_command(this.stSSH, cCmd);
        end
        
        % Send a command and get the result formated as a double
        function d = queryDouble(this, cCmd)
            c = this.queryChar(cCmd);
            % strip leading '#' char
            % c = c(1:end);
            d = str2double(c);
        end
        
        % Send a command and get the result formatted as a 32-bit int
        function u32 = queryInt32(this, cCmd)
           c = this.queryChar(cCmd);
           u32 = str2num(c);
        end
        
        % Send a command
        function command(this, cCmd)
            this.stSSH = ssh2_command(this.stSSH, cCmd);
        end
        
        
    end
    
    
    methods (Access = protected)
        
        function l = hasProp(this, c)
            
            l = false;
            if ~isempty(findprop(this, c))
                l = true;
            end
            
        end
        
    end
    
end

