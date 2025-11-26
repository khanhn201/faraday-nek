data = dlmread('surface_height.dat', ',');

t = data(:,2);
h = data(:,3);

% Plot
figure;
plot(t, h, 'LineWidth', 1.5);
xlabel('t (t*omega)/2pi');
ylabel('h');
title('Surface Height vs Time');
grid on;
