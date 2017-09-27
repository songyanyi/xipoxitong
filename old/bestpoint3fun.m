function f = bestpoint3fun(y0, H, x0, v_wind, m_qiu, I, L, xitong_figure)
%此函数用于构建fzero函数的输入，以求解yn = -H。
%

[y, ~, ~, ~, ~] = For2D(y0, x0, v_wind, m_qiu, I, L, xitong_figure);
yn = y(end);
f = yn - (-H);









