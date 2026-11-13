assert(data.size > 0, 'No samples acquired');
t = data.time - data.time(1);
w1 = data.signals{1}(1,:);
w2 = data.signals{1}(2,:);
u1 = data.signals{2}(1,:);
u2 = data.signals{2}(2,:);
save('motor_trial01.mat', 'data');