function f = GA_mn(x)
%此函数用于进行重物球质量调节的目标函数
% 
% 此程序用于求解下面问题
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 在问题1的假设下，
% 计算海面风速为36m/s时钢桶和各节钢管的倾斜角度、
% 锚链形状和浮标的游动区域。
% 请调节重物球的质量，使得钢桶的倾斜角度不超过5度，
% 锚链在锚点与海床的夹角不超过16度。
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

m_qiu = x(1);
n=x(2);

m_II = 28.12;
H = 18;

x0 = 20;
y0_fig = linspace(-0.00001, -2, 100);
for i = 1:length(y0_fig)
    [ynn, xnn, thetann] = For3D(x0, y0_fig(i), m_qiu, n, m_II);
    yn_fig(i) =  ynn(end);
    xn_fig(i) =  xnn(end);
    thetan_fig(i) =  thetann(end-1);
end

[~, ind1] = min(abs(yn_fig - (-H)));
besty0 = y0_fig(ind1);
bestx0 = x0 - xn_fig(ind1);

%计算bestx0, besty0情况下的系统信息及系统图形
[~, ~, besttheta] = For3D(bestx0, besty0, m_qiu, n, m_II);

alpha1 = pi/2 - besttheta(5);
alpha2 = besttheta(end-1);

f = pi*bestx0^2 + 10*abs(besty0) +1000*alpha1;
end









