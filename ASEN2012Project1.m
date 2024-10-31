% Project 1 ASEN 2012
clc;
clear;
close all;

%% Read in  data files
% in form Time(s), X(nmi), Y(nmi)
rawdata_A = readmatrix("Data_TCAS_A.csv");
rawdata_B = readmatrix("Data_TCAS_B.csv");

%% find the fit lines for each aircraft, in x and y (4 lines)
[a] = polyfit(rawdata_A(:,1),rawdata_A(:,2),1); % x
[b] = polyfit(rawdata_A(:,1),rawdata_A(:,3),1); % y

[c] = polyfit(rawdata_B(:,1),rawdata_B(:,2),1); % x
[d] = polyfit(rawdata_B(:,1),rawdata_B(:,3),1); % y
%% Assign the variables of the distance equation
u_A = a(1);
x0_A = a(2);

v_A = b(1);
y0_A = b(2);

u_B = c(1);
x0_B = c(2);

v_B = d(1);
y0_B = d(2);




%% Use the derived closest approach equation to find time of closest approach

t_ca = ( -(x0_B-x0_A)*(u_B-u_A)-(y0_B-y0_A)*(v_B-v_A) ) / ( (u_B-u_A)^(2)+(v_B-v_A)^(2) );
