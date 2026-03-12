%初始化
clc
clear
fit=[];
pbest=[];
gbest=[];
gbest_plot=[];
x=rand(10,4).*20;
v=rand(10,4).*20;
c1=2;
c2=2;
Kp=rand*15;
Ts=rand*15;
Ti=rand*15;
Td=rand*15;
iter=100;
tic
for k=1:1:iter
%评价适应度
    for i=1:1:10
        fit(i)=PSO_PID(x(i,:)); 
    end
%更新个体最优
    if k==1
        pbest=x;
    else
        for i=1:1:10
            if fit(i)<PSO_PID(pbest(i,:))
                pbest(i,:)=x(i,:);
            end
        end
    end
%更新群体最优
    [M,best]=min(fit);
    if k==1
        gbest=x(best,:);
    else
        if M<PSO_PID(gbest)
            gbest=x(best,:);
        end
    end
    gbest_plot=[gbest_plot,PSO_PID(gbest)];
%更新速度
    for i=1:1:10
        vnew=1.*v(i,:)+c1.*rand.*(pbest(i,:)-x(i,:))+c2.*rand.*(gbest-x(i,:));
        v(i,:)=vnew;
    end
%处理速度越界
  for i=1:1:10
        for j=1:1:4
            if v(i,j)>20
                v(i,j)=20;
            end
            if v(i,j)<-20
                v(i,j)=-20;
            end
        end
  end
%更新位置并处理位置越界
x=x+v;
    for i=1:1:10
        for j=1:1:4
            if x(i,j)>50
                x(i,j)=50;
            end
            if x(i,j)<0
                x(i,j)=0.01;
            end
        end
    end
outmsg = [ '迭代次数 #' , num2str(k) , ' ITAE= ' , num2str(PSO_PID(gbest))  ];
disp(outmsg)
end
time=toc;
disp(['x最佳取值',gbest]);
disp(['最小值',PSO_PID(gbest)]);
disp(['求解耗时',num2str(time)]);
x_label=1:1:iter;
figure
plot(x_label,gbest_plot);
title('PSO迭代过程')
xlabel('迭代次数')
ylabel('群体最小值')


