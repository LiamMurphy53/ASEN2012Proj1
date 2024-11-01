%% Project 1 ASEN 2012
clc;
clear;
close all;

%% Read in data files
% in form Time(s), X(nmi), Y(nmi)
rawdata_a = readmatrix("Data_TCAS_A.csv");
rawdata_b = readmatrix("Data_TCAS_B.csv");

%% Plot the two on the same graph, without respect to time
figure(1);
plot(rawdata_a(:,2), rawdata_a(:,3),'o');
hold on;
plot(rawdata_b(:,2), rawdata_b(:,3),'o');
title('Plane A vs Plane B Position');

% fit line to data A
[fit_a, stats_a] = polyfit(rawdata_a(:,2), rawdata_a(:,3), 1);
eq_a = @(x) fit_a(1)*x + fit_a(2);
x = linspace(rawdata_a(1,2), rawdata_a(length(rawdata_a),2), 100);
plot(x, eq_a(x));

% fit line to data B
[fit_b, stats_b] = polyfit(rawdata_b(:,2), rawdata_b(:,3), 1);
eq_b = @(x) fit_b(1)*x + fit_b(2);
x = linspace(rawdata_b(1,2), rawdata_b(length(rawdata_a),2), 100);
plot(x, eq_b(x));

%% Find the fit lines for each aircraft, in x and y (4 lines)

[a, S_a] = polyfit(rawdata_a(:,1), rawdata_a(:,2), 1); % x
[b, S_b] = polyfit(rawdata_a(:,1), rawdata_a(:,3), 1); % y

[c, S_c] = polyfit(rawdata_b(:,1), rawdata_b(:,2), 1); % x
[d, S_d] = polyfit(rawdata_b(:,1), rawdata_b(:,3), 1); % y

%% Assign the variables of the distance equation

u_a = a(1);
x0_a = a(2);

v_a = b(1);
y0_a = b(2);

u_b = c(1);
x0_b = c(2);

v_b = d(1);
y0_b = d(2);

%% Use the derived closest approach equation to find time of closest approach

t_ca = ( -(x0_b - x0_a)*(u_b - u_a) - (y0_b - y0_a)*(v_b - v_a) ) / ( (u_b - u_a)^(2) + (v_b - v_a)^(2) );

%% Aircraft motion models

t = 1:1000;

x_a = @(t) x0_a + u_a*t;
y_a = @(t) y0_a + v_a*t;

x_b = @(t) x0_b + u_b*t;
y_b = @(t) y0_b + v_b*t;

%% Using motion models for distance equation

distance = sqrt((x_b(t_ca) - x_a(t_ca))^2 + (y_b(t_ca) - y_a(t_ca))^2); % Distance in nmi

%% Error Propagation in Time of Closest Approach
%calculating standard error for slope and intercept
time_a = rawdata_a(:, 1);
xi_a = rawdata_a(:,2);
yi_a = rawdata_a(:,3);
N_a = length(time_a);
delta_a = N_a * sum(time_a.^2) - (sum(time_a))^2;

time_b = rawdata_b(:, 1);
xi_b = rawdata_b(:,2);
yi_b = rawdata_b(:,3);
N_b = length(time_b);
delta_b = N_b * sum(time_b.^2) - (sum(time_b))^2;


sigma_y_a = sqrt((1/(N_a - 2)) * sum((yi_a - fit_a(2) - fit_a(1) * xi_a).^2));
sigma_y_b = sqrt((1/(N_b - 2)) * sum((yi_b - fit_b(2) - fit_b(1) * xi_b).^2));


sigma_x0_a = sigma_y_a * sqrt((sum(time_a))/delta_a);
sigma_y0_a = sigma_y_a * sqrt((sum(time_a))/delta_a);
sigma_u_a = sigma_y_a * sqrt(N_a / delta_a);
sigma_v_a = sigma_y_a * sqrt(N_a / delta_a);

sigma_x0_b = sigma_y_b * sqrt((sum(time_b))/delta_b);
sigma_y0_b = sigma_y_b * sqrt((sum(time_b))/delta_b);
sigma_u_b = sigma_y_b * sqrt(N_b / delta_b);
sigma_v_b = sigma_y_b * sqrt(N_b / delta_b);