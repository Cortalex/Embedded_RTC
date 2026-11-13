assert(data.size > 0, 'No samples acquired');
t = data.time - data.time(1);
counter = data.signals{1}(1,:);

k_conversion  = 60/(3840*0.01);

ang_speed1 = data.signals{1}(1,:)*k_conversion;
ang_speed2 = data.signals{1}(2,:)*k_conversion;
voltage1 = data.signals{2}(1,:);
voltage2 = data.signals{2}(2,:);
figure;
plot(t, ang_speed1, t, ang_speed2, t, voltage1);
xlabel('Time [s]'); grid on;
legend('Measurement 1', 'Measurement 2');
%save('trial01.mat', 'data');