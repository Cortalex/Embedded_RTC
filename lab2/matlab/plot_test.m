

t  = data.time - data.time(1);
w1 = data.signals{1}(1, :);
w2 = data.signals{1}(2, :);
u1 = data.signals{2}(1, :);
u2 = data.signals{2}(2, :);

figure('Color', 'w', 'Position', [100, 100, 800, 500]);

ax1 = subplot(2, 1, 1);
plot(t, w1, 'LineWidth', 1.5); hold on;
plot(t, w2, 'LineWidth', 1.5);
ylabel('Angular Speed [rad/s]');
title('Motor Response');
legend('Motor 1 (\omega_1)', 'Motor 2 (\omega_2)', 'Location', 'best');
grid on;

ax2 = subplot(2, 1, 2);
plot(t, u1, '-',  'LineWidth', 1.5); hold on;
plot(t, u2, '-', 'LineWidth', 1.5);
xlabel('Time [s]');
ylabel('Control Voltage [V]');
legend('Motor 1 (u_1)', 'Motor 2 (u_2)', 'Location', 'best');
grid on;

linkaxes([ax1, ax2], 'x');
xlim([0, t(end)]);
