tangent_method_params_id

s = tf('s');

% Modelli stimati (approssimazione Padé del delay per simulazione)
P1 = (mu1 / (1 + T_1*s)) * exp(-tau_1*s);
P2 = (mu2 / (1 + T_2*s)) * exp(-tau_2*s);

% Controllori PI (Ziegler-Nichols)
C1 = Kp1 + Ki1/s;
C2 = Kp2 + Ki2/s;

% Sistemi in anello chiuso (Closed Loop)
W1 = feedback(C1 * P1, 1);
W2 = feedback(C2 * P2, 1);

% Plot della risposta a gradino (riferimento unitario di velocità)
figure('Color', 'w', 'Name', 'Closed-Loop Step Response');
step(W1, 'b', W2, 'r', 2.0); % Simula per 2 secondi
grid on;
legend('Motor 1 Closed-Loop', 'Motor 2 Closed-Loop', 'Location', 'southeast');
title('Risposta a Ciclo Chiuso con Controllore PI (Ziegler-Nichols)');
ylabel('Velocità normalizzata \omega(t) / \omega_{ref}');
xlabel('Tempo [s]');