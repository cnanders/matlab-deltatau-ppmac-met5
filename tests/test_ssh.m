clear all
clc

[cDirThis, cName, cExt] = fileparts(mfilename('fullpath'));

% Add ssh
addpath(genpath(fullfile(cDirThis, '..', 'vendor', 'fileexchange', 'ssh2_v2_m1_r6')));

cHost = '198.128.220.144'; % chris mpb at LBNL
cUser = '';
cPass = '';

ssh2_conn = ssh2_config(cHost, cUser, cPass);

[ssh2_conn, response] = ssh2_command(ssh2_conn, 'pwd', 1);
response
% response = ssh2_command_response(ssh2_conn);

[ssh2_conn, response] = ssh2_command(ssh2_conn, 'echo Huge amounts of ftext and booyah and awesome on STDOUT;');
response
% response = ssh2_command_response(ssh2_conn);

ssh2_conn = ssh2_close(ssh2_conn);