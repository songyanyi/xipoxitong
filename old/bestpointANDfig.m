function [ax, ay, atheta] = bestpointANDfig(v_wind)
%此函数用图解法求最优h
% 
%bestpointANDfig(12)
%bestpointANDfig(24)
%bestpointANDfig(36)
% 此程序用于求解下面问题
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 某型传输节点选用II型电焊锚链22.05m，
% 选用的重物球的质量为1200kg。
% 现将该型传输节点布放在水深18m、
% 海床平坦、海水密度为1.025×103kg/m3的海域。
% 若海水静止，分别计算海面风速为12m/s和24m/s时钢桶和
% 各节钢管的倾斜角度、锚链形状、浮标的吃水深度和游动区域
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

H = 18;

x0 = 20;

y0_fig = linspace(-0.00001, -2, 2000);
for i = 1:length(y0_fig)
    [ynn, xnn, thetann] = For2D(x0, y0_fig(i), v_wind);
    yn_fig(i) =  ynn(end);
    xn_fig(i) =  xnn(end);
    thetan_fig(i) =  thetann(end-1);
end

[~, ind1] = min(abs(yn_fig - (-H)));
besty0 = y0_fig(ind1);
bestx0 = x0 - xn_fig(ind1);

%计算bestx0, besty0情况下的系统信息及系统图形
[besty, bestx, besttheta] = For2D(bestx0, besty0, v_wind);

if nargout > 0
    ax = bestx;
    ay = besty;
    atheta = besttheta;
else
    format long
    disp('最优横坐标为：')
    bestx0

    disp('最优纵坐标为：')
    besty0

    disp('最优吃水深度为：')
    abs(besty0)

    disp('钢管钢桶水平倾角为：')
    besttheta(1:5)
    
    figure
    plot(bestx, besty)
    xlabel('风力方向')
    ylabel('竖直方向')
    title(['最优吃水力度', num2str(abs(besty0)), '时的系泊系统曲线'])
    text(bestx(1)-1, besty(1), [num2str(bestx(1)),',',num2str(besty(1))])

    figure
    plot(y0_fig, yn_fig, 'r*-')
    xlabel('吃水深度')
    ylabel('锚链末端坐标')
    title('锚链末端随吃水深度的变化曲线图')
    
    figure
    plot(y0_fig, thetan_fig, 'r*-')
    xlabel('吃水深度')
    ylabel('锚链末端水平夹角')
    title('锚链末端水平夹角随吃水深度的变化曲线图')    
end
end









