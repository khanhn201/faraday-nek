clear;close all; clc
omega = 10.5718;
mag = 0.04474;
l = 0.05;
v = omega*mag;

data = dlmread('surface_height.dat', ',');

% t = data(:,1)*omega/(2*pi);
t = data(:,1)*(l/v)*omega/(2*pi); % Paper plot t*omega/(2pi)
h = data(:,2);

% Plot
fig = figure;
% plot(t+97.5, h, 'LineWidth', 1.5, 'DisplayName','Present work');
plot(t+pi*26, h, 'LineWidth', 1.5, 'DisplayName','Present work');
% plot(t+pi*21.5, h, 'LineWidth', 1.5, 'DisplayName','Present work (smaller IC)');
xlabel('t');ylabel('h');
title('Surface Height vs Time');
grid on;

hold on
% Reference data
dataref = load('plot_fig9.csv');
plot(dataref(:,1),dataref(:,2)+0.98,'--','LineWidth',1.5, 'DisplayName','Reference Fig.9')
xlim([100,125]);
legend('Location','best');

% exportgraphics(fig,'1026_plot_height.png','ContentType','vector')