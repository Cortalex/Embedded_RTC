%close all
%clear
%clc

%% === Filter parameters ===
fc = 0.7;        % Cutoff frequency [Hz]
Ts = 0.01;       % Sampling period [s]

%% === Extract signals from data ===
t = data.time - data.time(1);             % Time vector [s]
k_conversion = 60 / (3840 * Ts);         % Conversion factor from encoder ticks to RPM

% Angular speed signals [rpm]
y1 = data.signals{1}(1, :) * k_conversion; % Motor 1
y2 = data.signals{1}(2, :) * k_conversion; % Motor 2

% Applied control voltages [V]
u1 = data.signals{2}(1, :);               % Motor 1
u2 = data.signals{2}(2, :);               % Motor 2

%% === Low-pass filter design (continuous -> discrete via Tustin) ===
sysF = tf(2*pi*fc, [1, 2*pi*fc]);
sysF_d = c2d(sysF, Ts, 'tustin');
[numF, denF] = tfdata(sysF_d, 'v');

%% === Filter the speed signals ===
y1_f = filter(numF, denF, y1);
y2_f = filter(numF, denF, y2);

%% === Prepend negative time baseline at rest (preserves real t = 0 timestamp) ===
t_pre_duration = 0.5;                   % Duration of baseline before the step [s]
t_pre = -t_pre_duration : Ts : -Ts;     % Negative time interval at rest (u = 0, speed = 0)

t_plot = [t_pre, t];
u1_plot = [zeros(size(t_pre)), u1];
u2_plot = [zeros(size(t_pre)), u2];
y1_plot = [zeros(size(t_pre)), y1];
y2_plot = [zeros(size(t_pre)), y2];
y1_f_plot = [zeros(size(t_pre)), y1_f];
y2_f_plot = [zeros(size(t_pre)), y2_f];

%% === Plot: Step response with dual vertical axes (yyaxis) ===
figure('Name', 'Motor Step Response', 'Color', 'w', 'Position', [100, 100, 900, 650]);

% --- Subplot 1: Motor 1 ---
ax1 = subplot(2, 1, 1);
yyaxis left
plot(t_plot, y1_plot, '-', 'Color', [0.7 0.7 0.7], 'LineWidth', 1.0); hold on;
plot(t_plot, y1_f_plot, '-', 'Color', [0.1 0.6 0.2], 'LineWidth', 1.8);
ylabel('Speed \omega_1 [rpm]', 'FontWeight', 'bold');
grid on;

yyaxis right
plot(t_plot, u1_plot, '-', 'Color', 'r', 'LineWidth', 1.5);
ylabel('Voltage u_1 [V]', 'FontWeight', 'bold');
ylim([0, max(u1)*1.25 + 0.5]);

title(sprintf('Motor 1: Step Response (f_c = %.1f Hz, T_s = %.3f s)', fc, Ts), ...
      'FontSize', 12, 'FontWeight', 'bold');
legend({'Raw speed', 'Filtered speed', 'Input voltage'}, 'Location', 'best');

% --- Subplot 2: Motor 2 ---
ax2 = subplot(2, 1, 2);
yyaxis left
plot(t_plot, y2_plot, '-', 'Color', [0.7 0.7 0.7], 'LineWidth', 1.0); hold on;
plot(t_plot, y2_f_plot, '-', 'Color', [0 0.45 0.74], 'LineWidth', 1.8);
ylabel('Speed \omega_2 [rpm]', 'FontWeight', 'bold');
xlabel('Time [s]', 'FontSize', 11, 'FontWeight', 'bold');
grid on;

yyaxis right
plot(t_plot, u2_plot, '-', 'Color', 'r', 'LineWidth', 1.5);
ylabel('Voltage u_2 [V]', 'FontWeight', 'bold');
ylim([0, max(u2)*1.25 + 0.5]);

title(sprintf('Motor 2: Step Response (f_c = %.1f Hz, T_s = %.3f s)', fc, Ts), ...
      'FontSize', 12, 'FontWeight', 'bold');
legend({'Raw speed', 'Filtered speed', 'Input voltage'}, 'Location', 'best');

% Synchronize horizontal axis zoom and pan
linkaxes([ax1, ax2], 'x');
xlim(ax1, [-t_pre_duration, t(end)]);
