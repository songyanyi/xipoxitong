function [besty0, bestx0, alpha1, alpha2] = HANDhxalpha(H)

x0 = 20;
m_qiu = 1000;
n = 200;
m_II = 3.2;
v1=24;
v2 = 0.75;

y0_fig = linspace(-0.00001, -2, 100);
for i = 1:length(y0_fig)
    [ynn, xnn, thetann] = For3Dv(x0, y0_fig(i), m_qiu, n, m_II, v1, v2);
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









