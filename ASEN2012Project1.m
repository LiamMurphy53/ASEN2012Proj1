%% Project 1 ASEN2012
clc;
clear;
close all;

%% Read in  data files
% in form Time(s), X(nmi), Y(nmi)
rawdata_A = readmatrix("Data_TCAS_A.csv");
rawdata_B = readmatrix("Data_TCAS_B.csv");

%% Plot the two on the same graph, without respect to time

figure(1);
plot(rawdata_A(:,2),rawdata_A(:,3));
hold on;
plot(rawdata_B(:,2),rawdata_B(:,3));

% fit line to data A
[d,S] = polyfit(rawdata_A(:,2),rawdata_A(:,3),1);
eq_A = @(x) d(1)*x+d(2);
x = linspace(rawdata_A(1,2),rawdata_A(length(rawdata_A),2),100);
plot(x,eq_A(x));

%fit line to data B
[e,T] = polyfit(rawdata_B(:,2),rawdata_B(:,3),1);
eq_B = @(x) e(1)*x+e(2);
x = linspace(rawdata_B(1,2),rawdata_B(length(rawdata_A),2),100);
plot(x,eq_B(x));
