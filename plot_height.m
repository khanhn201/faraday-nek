omega = 10.5718
mag = 0.04474
l = 0.05
v = omega*mag

data = dlmread('surface_height.dat', ',');

t = data(:,1)*(l/v)*omega/(2*pi); % Paper plot t*omega/(2pi)
h = data(:,2);

% Plot
figure;
plot(t, h, 'LineWidth', 1.5);
xlabel('t');
ylabel('h');
title('Surface Height vs Time');
grid on;

