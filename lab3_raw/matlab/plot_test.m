t_max = 3.0;   % Time window [s] to focus on transient & overshoot (Inf for full run)
w_ref = NaN;   % Optional speed reference [rad/s] (e.g. 12, 15, -6; NaN to hide)

t   = data.time - data.time(1);
idx = t <= t_max;
assert(any(idx), 'No samples within [0, t_max].');

t  = t(idx);
w1 = data.signals{1}(1, idx);
w2 = data.signals{1}(2, idx);
u1 = data.signals{2}(1, idx);
u2 = data.signals{2}(2, idx);

figure('Color', 'w', 'Position', [100, 100, 800, 500]);

ax1 = subplot(2, 1, 1);
plot(t, w1, '-', 'Color', [0, 0.447, 0.741], 'LineWidth', 1.6); hold on;
plot(t, w2, '-', 'Color', [0.85, 0.325, 0.098], 'LineWidth', 1.6);
if ~isnan(w_ref)
    yline(w_ref, 'k--', 'LineWidth', 1.1);
    legend('Motor 1 (\omega_1)', 'Motor 2 (\omega_2)', 'Reference', 'Location', 'best');
else
    legend('Motor 1 (\omega_1)', 'Motor 2 (\omega_2)', 'Location', 'best');
end
ylabel('Angular Speed [rad/s]');
title('Motor Response');
grid on;
yl1 = ylim(ax1);
ylim(ax1, yl1 + [-0.05, 0.08] * diff(yl1));

ax2 = subplot(2, 1, 2);
plot(t, u1, '-', 'Color', [0, 0.447, 0.741], 'LineWidth', 1.2); hold on;
plot(t, u2, '-', 'Color', [0.85, 0.325, 0.098, 0.8], 'LineWidth', 1.2);
xlabel('Time [s]');
ylabel('Control Voltage [V]');
legend('Motor 1 (u_1)', 'Motor 2 (u_2)', 'Location', 'best');
grid on;
yl2 = ylim(ax2);
ylim(ax2, yl2 + [-0.08, 0.08] * diff(yl2));

linkaxes([ax1, ax2], 'x');
xlim([0, t(end)]);
