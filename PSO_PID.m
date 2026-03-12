function [z]=PSO_PID(x)
assignin('caller','Kp',x(1));    %粒子依次赋值给Kp
assignin('caller','Ti',x(2));    %粒子依次赋值给Ti
assignin('caller','Td',x(3));    %粒子依次赋值给Td
assignin('caller','Ts',x(4));    %粒子依次赋值给TS
simout=sim('PID',[0,20]);    %使用命令行运行控制系统模型
ts=simout.yout{1}.Values;
l=length(ts.Time);
z=getdatasamples(ts,l);
end
