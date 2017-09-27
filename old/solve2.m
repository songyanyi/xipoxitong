
v_wind = 36;
bestpointANDfig(v_wind)
[ax, ay, atheta] = bestpointANDfig(v_wind);
alpha1 = pi/2-atheta(5);
alpha2 = atheta(end-1);
%% 绘制m和y0 ，x0 ，alpha1之间的关系图
%利用函数mANDhxalpha进行分析
clc
clear besty0 bestx0 alpha1 alpha2

m = linspace(1000, 6000, 100);
for i = 1:length(m)
    [besty0(i), bestx0(i), alpha1(i), alpha2(i)] = mANDhxalpha(m(i));
end

figure(1)
plot(m, -besty0, 'r*-')
xlabel('重物球质量')
ylabel('吃水深度')
title('吃水深度随重物球质量变化曲线')

figure(2)
plot(m, bestx0, 'c<-')
xlabel('重物球质量')
ylabel('浮漂距离')
title('浮漂距离随重物球质量变化曲线')

figure(3)
plot(m, alpha1, 'bo-')
xlabel('重物球质量')
ylabel('钢桶竖直方向夹角')
title('钢桶竖直方向夹角随重物球质量变化曲线')

figure(4)
plot(m, alpha2, 'gs-')
xlabel('重物球质量')
ylabel('锚链底端水平方向夹角')
title('锚链底端水平方向夹角随重物球质量变化曲线')

%% 确定m的取值范围
%alpha1 2要满足要求
alpha1_max = 5/90*(pi/2);
alpha2_max = 16/90*(pi/2);

[~, ind1] = min(abs(alpha1 - alpha1_max));
m1 = m(ind1);
[~, ind2] = min(abs(alpha2 - alpha2_max));
m2 = m(ind2);

  % s.t.  max{m1, m2}  <  m  
  
%%  IENSGAii 求解最优m，使得pi*x^2、和、alpha1小，且alpha1，2在范围内
clear
clc

fitnessfcn = @multi_GA_m;   
nvars = 1;                     
lb = [1000];                  
ub = [6000];                     
A = []; b = [];                 
Aeq = []; beq = [];             
options = gaoptimset('ParetoFraction', 0.3, 'PopulationSize', 100, 'Generations', 150, 'StallGenLimit', 150, 'PlotFcns', {@gaplotpareto, @gaplotbestf});

[x, fval] = gamultiobj(fitnessfcn, nvars, A, b, Aeq, beq, lb, ub, options);













