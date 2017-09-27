function [besty0, bestx0, alpha1, alpha2] = vANDhxalpha(v2)
%此函数用于分析重物球质量与besty0，bestx0, alpha1, alpha2之间的关系
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

H = 18;
x0 = 20;
m_qiu = 1000;
n = 200;
m_II = 3.2;
v1=24;


y0_fig = linspace(-0.00001, -2, 100);
for i = 1:length(y0_fig)
    [ynn, xnn, thetann] = For3Dv(x0, y0_fig(i), m_qiu, n, m_II, v1,v2);
    yn_fig(i) =  ynn(end);
    xn_fig(i) =  xnn(end);
    thetan_fig(i) =  thetann(end-1);
end

[~, ind1] = min(abs(yn_fig - (-H)));
besty0 = y0_fig(ind1);
bestx0 = x0 - xn_fig(ind1);

%计算bestx0, besty0情况下的系统信息及系统图形
[~, ~, besttheta] = For3Dv(bestx0, besty0, m_qiu, n, m_II, v1,v2);

alpha1 = pi/2 - besttheta(5);
alpha2 = besttheta(end-1);

end









