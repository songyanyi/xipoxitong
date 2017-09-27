%风速对系统状态的影响
clc
clear
v = 10:5:40;
figure(1)
for i = 1:length(v)
    [ax(:, i), ay(:, i), atheta(:, i)] = bestpointANDfig(v(i));
    plot(ax(:, i), ay(:, i),'-', 'color', rand(3, 1))
    hold on
end
legend('location', 'best')
xlabel('风向')
ylabel('系统状态')
title('风力大小对系统状态的影响')

figure(2)
for i = 1:length(v)
    plot(atheta(:, i), '-', 'color', rand(3, 1))
    hold on
end
legend('location', 'best')
xlabel('风向')
ylabel('系统各部分水平夹角')
title('风力大小对系统各部分水平夹角的影响')

