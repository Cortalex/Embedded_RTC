%% === Extract signals from data ===
Ts = 0.01;       % Sampling period [s]
t = data.time - data.time(1);             % Time vector [s]
k_conversion = 60 / (3840 * Ts);         % Conversion factor from encoder ticks to rad/s

% Angular speed signals [rpm]
w1 = data.signals{1}(1, :) * k_conversion; % Motor 1
w2 = data.signals{1}(2, :) * k_conversion; % Motor 2

% Applied control voltages [V]
u1 = data.signals{2}(1, :);               % Motor 1
u2 = data.signals{2}(2, :);               % Motor 2

%% === Low-pass filter design (continuous -> discrete via Tustin) ===

% === Filter parameters ===
fc = 0.7;        % Cutoff frequency [Hz]

sysF = tf(2*pi*fc, [1, 2*pi*fc]);
sysF_d = c2d(sysF, Ts, 'tustin');
[numF, denF] = tfdata(sysF_d, 'v');

% === Filter the speed signals ===
w1 = filter(numF, denF, w1);
w2 = filter(numF, denF, w2);

%% start evaluating the mean from t = 4

t_start = 4.0;
t_end = t(end) -1.0;

idx_regime = (t >= t_start) & (t <= t_end);

w1_regime = mean(w1(idx_regime))
w2_regime = mean(w2(idx_regime))

u1_regime = mean(u1(idx_regime))
u2_regime = mean(u2(idx_regime))


% computing μ 

mu1 = w1_regime / u1_regime
mu2 = w2_regime / u2_regime

%% Evaluating using the First Order Transfer Function Approximation (63.2% Method)

w1_63_2 = 0.632 * w1_regime
w2_63_2 = 0.632 * w2_regime


idx_1 = find(w1 >= w1_63_2, 1, 'first');

T_1 = 0.0;
T_2 = 0.0;

% checking the closest match between found idx and idx-1

if((w1(idx_1) - w1_63_2) > (w1_63_2 - w1(idx_1 - 1)))
    T_1 = t(idx_1 -1);
else
    T_1 = t(idx_1);
end

idx_2 = find(w2 >= w2_63_2, 1, 'first');

if((w2(idx_2) - w2_63_2) > (w2_63_2 - w2(idx_2 - 1)))
    T_2 = t(idx_2 -1);
else
    T_2 = t(idx_2);
end

T_1
T_2


