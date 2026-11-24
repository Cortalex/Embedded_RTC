tangent_method_params_id

s = tf('s');

% Estimated models (FOPTD transfer functions)
P1 = (mu1 / (1 + T_1*s)) * exp(-tau_1*s);
P2 = (mu2 / (1 + T_2*s)) * exp(-tau_2*s);

% PI controllers (Ziegler-Nichols open-loop tuning)
C1 = Kp1 + Ki1/s;
C2 = Kp2 + Ki2/s;

% Closed-loop systems
W1 = feedback(C1 * P1, 1);
W2 = feedback(C2 * P2, 1);

% Plot closed-loop step response (unit step speed reference)
figure('Color', 'w', 'Name', 'Closed-Loop Step Response');
step(W1, 'b', W2, 'r', 2.0); % Simulate for 2 seconds
grid on;
legend('Motor 1 Closed-Loop', 'Motor 2 Closed-Loop', 'Location', 'southeast');
title('Closed-Loop Step Response with PI Controller (Ziegler-Nichols)');
ylabel('Normalized Speed \omega(t) / \omega_{ref}');
xlabel('Time [s]');