% test_algos.m
clc,clear all,close all,dbstop if error
dbstop('if', 'error', 'MATLAB:badsubscript')
clear obv_adx

vars = whos;
vars = vars([vars.persistent]);
varName = {vars.name};
clear(varName{:});

load stkfiles.mat
nn = length(stk);
len = length(cl(:,1));
odk = 21;
dP = 7;
sK = 7;
rrfxlen = 10;

out = callSPRSI_optim(hi,lo,cl,stk);


% end
% data plots
k = 12;
