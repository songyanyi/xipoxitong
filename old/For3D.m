function [y, x, theta] = For3D(x0, y0, m_qiu, n, m_II)
%
% 此函数用于给定x0和y0后求解系泊系统的状态曲线以及终点坐标 xn,yn
% 输入x0,y0为初始点坐标
% 输出yn,xn为终点坐标
%m_II决定了链型


x(1) = x0; 
y(1) = y0;

h = abs(y(1));%浮标吃水深度

%浮标受力
rho = 1.025*10^3;%海水的密度  kg/m^3
g = 9.8;%重力加速度 N/kg
D = 2;%圆柱浮标地面直径 m
h0 = 2;%圆柱浮标高度 m
m0= 1000;%浮标质量 kg

F0 = rho*g*pi*(D/2)^2*h;%浮标浮力
G0 = m0*g;%浮标重力

H = 18;%水深
v1 = 36;%风速
v2 = 1.5;%水速
F_wind = 0.625*(D*(h0 - h))*v1^2;%风力
Fs1 = 374*(D*h)*v2^2;


theta1 = atan((F0-G0)/(F_wind+Fs1));%钢管1的水平夹角
T1 = sqrt((F0-G0)^2+(F_wind+Fs1)^2);%钢管1的张力

T(1) = T1; theta(1) = theta1;

%钢管受力分析
for i = 1:4
    m(i) = 10;%钢管质量 kg
    G(i) = m(i)*g;%钢管重力
    
    l(i) = 1;%钢管长度 m
    d(i) = 50/1000;%钢管直径 m
    F(i) = rho*g*pi*(d(i)/2)^2*l(i);%钢管浮力
    
    Fs(i) = 374*(l(i)*sin(theta(i))*d(i))*v2^2;
    
    T(i+1) = (  (F(i)-G(i)+T(i)*sin(theta(i)))^2  +...
        (T(i)*cos(theta(i)) + Fs(i))^2    )^(1/2);
    
    theta(i+1) = atan(    (F(i)-G(i)+T(i)*sin(theta(i)))/...
        (T(i)*cos(theta(i))  + Fs(i))   );
    
    %钢管i的坐标（xi,yi）
    y(i+1) = y(i) - l(i)*sin(theta(i));
    x(i+1) = x(i) - l(i)*cos(theta(i));
end

%钢桶受力分析
m_tong = 100;%钢桶的质量 kg
G_tong = m_tong*g;%钢桶重力
% m_qiu = 1200;%重物球质量 kg
G_qiu = m_qiu*g;%重物球重力

l_tong = 1;%钢桶长 m
D_tong = 30/100;%钢桶底长
F_tong = rho*g*pi*(D_tong/2)^2*l_tong;%钢桶浮力

Fs_tong = 374*(l_tong*sin(theta(5))*D_tong)*v2^2;

T_tong = ( (F_tong-G_tong-G_qiu+T(5)*sin(theta(5)))^2 + ...
                (Fs_tong+T(5)*cos(theta(5)))^2)^(1/2);
theta_tong = atan( ((F_tong-G_tong-G_qiu+T(5)*sin(theta(5)))...
                      /(Fs_tong+T(5)*cos(theta(5)))) );
T(6) = T_tong;
theta(6) = theta_tong;

y(6) = y(5) - l_tong*sin(theta(5));
x(6) = x(5) - l_tong*cos(theta(5)); 

%锚链线分析

switch m_II 
    case 3.2
       II = 78/1000;%锚链每节长度 m    
    case 7
       II = 105/1000;%锚链每节长度 m
    case 12.5
       II = 120/1000;
    case 19.5
        II = 150/1000;
    case 28.12
        II = 180/1000;
end

G_mao = II*m_II*g;%单位长度重量

for i = 6 : 6+n-1
    if  theta(i) - 0 >0.001
        T(i+1) = T(i) - G_mao*sin(theta(i));
        theta(i+1) = theta(i) - (G_mao*cos(theta(i)))/(T(i)-G_mao*sin(theta(i))); 
        y(i+1) = y(i) - sin(theta(i))*II;
        x(i+1) = x(i) - cos(theta(i))*II; 
    else 
        T(i+1) = 0;
        theta(i+1) = 0;
        y(i+1) = y(i);
        x(i+1) = x(i) - II;
    end
end

% T = T(1:end-1);
% theta = theta(1:end-1);











