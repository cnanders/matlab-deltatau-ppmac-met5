clear all
clc

%% Initial config

[cDirThis, cName, cExt] = fileparts(mfilename('fullpath'));

% Add ssh
addpath(genpath(fullfile(cDirThis, '..', 'vendor', 'fileexchange', 'ssh2_v2_m1_r6')));

cHost = '192.168.20.23'; % chris mpb at LBNL
cUser = 'root';
cPass = 'deltatau';

ssh2_conn = ssh2_config(cHost, cUser, cPass);

%% IGNORE HOST RESPONSE
% for the fastest connections, one can send the commands and not readback
% the host response. 
ssh2_conn.command_ignore_response = 0;

%%
[ssh2_conn, response] = ssh2_command(ssh2_conn, 'pwd', 1);
response
% response = ssh2_command_response(ssh2_conn);

%%
[ssh2_conn, response] = ssh2_command(ssh2_conn, 'echo Huge amounts of ftext and booyah and awesome on STDOUT;');
response

%%
ssh2_conn = ssh2_command(ssh2_conn, 'echo Huge amounts of ftext and booyah and awesome on STDOUT;');
response = ssh2_command_response(ssh2_conn)


%%
ssh2_conn.command_ignore_response = 0;
[ssh2_conn, response] = ssh2_command(ssh2_conn, 'gpascii -2');
response
% response = ssh2_command_response(ssh2_conn);


%%
[ssh2_conn, response] = ssh2_command(ssh2_conn, 'ActWorkingMode');

%% Don't ignore response and ask for ActWorkingMode
ssh2_conn.command_ignore_response = 0;
[ssh2_conn, response] = ssh2_command(ssh2_conn, 'ActWorkingMode');



%% Close the connection
ssh2_conn = ssh2_close(ssh2_conn);


