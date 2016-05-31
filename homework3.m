% homework3.m
%% �ö��ַ��������ڲ巨��ţ�ٷ������淽�̵ĸ���
%   f(x)=-26+85*x-91*x^2+44*x^3-8*x^4+x^5��
% ���ַ�����������������[0.5,1.0]���������Ϊ1%
% �����ڲ巨������������[0.5,1.0]���������Ϊ0.2%
% ţ�ٷ�������Ϊx0=1.0���������Ϊ0.1%

clc;clear;close all;
f = @(x)-26+85*x-91*x.^2+44*x.^3-8*x.^4+x.^5; %ͨ��'@'����ԭ����
%�����ж�ȡֵ��������
a = f(0.5); b = f(1.0);
if a<b
    xl = 0.5; xu = 1.0;
else
    xl = 1.0; xu = 0.5;
end

%%Method1: Bisection Method

xl1 = zeros(1,10); xu1  = zeros(1,10); xl1(1) = xl; xu1(1) = xu;
xe1 = zeros(1,10);fxe1 = zeros(1,10); ea1 = zeros(1,9); ea1(1) = inf;
for i = 1:9
    xe1(i) = (xl1(i)+xu1(i))/2;	%ȡ��ֵ
    fxe1(i) = f(xe1(i));
    if(i>1)
        ea1(i) = abs((xe1(i)-xe1(i-1))/xe1(i));%����Թ������
    end
    %�պ�Ϊ0���С���������
    if (fxe1(i)==0)||(ea1(i)<=0.01)		
        fxe1(i+1:end) = [];  %������ʣ������
        ea1(i+1:end) = [];
        xu1(i+1:end) = [];
        xl1(i+1:end) = [];
        xe1(i+1:end) = [];
        num1 = 1:i;
        
        %���Ƴ����
        table = figure;
        d = [num1;xl1;xu1;xe1;fxe1;ea1]';
        cnames = {'���','xl','xu','xe','f(xe)','|ea|'};
        t = uitable(table,'Data',d,...
                    'ColumnName',cnames,...
                    'RowName',[],...
                    'FontSize',10.0,...
                    'FontAngle','italic');
        t.Position(3) = t.Extent(3);
        t.Position(4) = t.Extent(4);
        break;
    else if fxe1(i)>0
            xu1(i+1) = xe1(i);	%�������õ�ֵ�������Ըı�������
            xl1(i+1) = xl1(i);
        else
            xl1(i+1) = xe1(i);
            xu1(i+1) = xu1(i);
        end
    end
end

%%Method2: Linear Interpolation Method

xl2 = zeros(1,10); xu2  = zeros(1,10); xl2(1) = xl; xu2(1) = xu;
xe2 = zeros(1,10);fxe2 = zeros(1,10); fxu2 = zeros(1,10); fxl2 = zeros(1,10);
ea2 = zeros(1,9); ea2(1) = inf;

for i = 1:9
fxu2(i) = f(xu2(i)); fxl2(i) = f(xl2(i));
%����߽���
xe2(i) = xl2(i) + (-fxl2(i)/(fxu2(i)-fxl2(i)))*(xu2(i)-xl2(i));  
fxe2(i) = f(xe2(i));
    if(i>1)
        ea2(i) = abs((xe2(i)-xe2(i-1))/xe2(i));
end
    %�պ�Ϊ0���С���������
    if (fxe2(i)==0)||(ea2(i)<=0.002)
        fxu2(i+1:end) = [];	%������ʣ������
        fxl2(i+1:end) = [];
        fxe2(i+1:end) = [];  
        ea2(i+1:end) = [];
        xu2(i+1:end) = [];
        xl2(i+1:end) = [];
        xe2(i+1:end) = [];
        num2 = 1:i;
        
	   %���Ƴ����
        table = figure;
        d = [num2;xl2;xu2;xe2;fxl2;fxu2;fxe2;ea2]';
        cnames = {'���','xl','xu','xe','f(xl)','f(xu)','f(xe)','|ea|'};
        t = uitable(table,'Data',d,...
                    'ColumnName',cnames,...
                    'RowName',[],...
                    'FontSize',10.0,...
                    'FontAngle','italic');
        t.Position(3) = t.Extent(3);
        t.Position(4) = t.Extent(4);
        break;
    else if fxe2(i)>0
            xu2(i+1) = xe2(i);
            xl2(i+1) = xl2(i);
        else
            xl2(i+1) = xe2(i);
            xu2(i+1) = xu2(i);
        end
    end
end

%Method3: Newton-raphson method

x0 = 1.0; x1 = zeros(1,10); x1(1) = x0; 
xe3 = zeros(1,10); ea3 = zeros(1,10);
fx = zeros(1,10); f1x = zeros(1,10);
f1 = @(x)5*x^4 - 32*x^3 + 132*x^2 - 182*x + 85;%�������
for i=1:10
   xe3(i) = x1(i) - f(x1(i))/f1(x1(i));
   x1(i+1) = xe3(i);
   ea3(i) =  abs((xe3(i)-x1(i))/xe3(i));
   fx(i) = f(x1(i)); f1x(i) = f1(x1(i));
   %С���������ʱ
   if ea3(i)<=0.001
       fx(i+1:end) = [];
       f1x(i+1:end) = [];
       x1(i+1:end) = [];
       xe3(i+1:end) = [];
       ea3(i+1:end) = [];
       num3 = 1:i;
       
	   %���Ƴ����
       table = figure;
       d = [num3;x1;fx;f1x;xe3;ea3]';
       cnames = {'���','x','f(x)','f1(x)','xe','|ea|'};
       t = uitable(table,'Data',d,...
                    'ColumnName',cnames,...
                    'RowName',[],...
                    'FontSize',10.0,...
                    'FontAngle','italic');
       t.Position(3) = t.Extent(3);
       t.Position(4) = t.Extent(4);
       break;
   end
end

% ����ͼ��:
x = linspace(0,1.5,20); Fx = f(x);
%����Matlab�е�������̶Է��̽���������ӵõ��ĸ�֪ʵ����[0,1]֮��
root = solve(f);    
figure(4)
plot(x,Fx,'LineWidth',2);hold on; grid on;%f(x)��һ�κ���
plot([0:5],zeros(1,6),'k--');		%����y=0������
%���Ƴ�[0,1]֮��ĸ�
plot(root(1),0,'r^','MarkerSize',10,'MarkerFaceColor','r');
xlabel('x');ylabel('f(x)');title('f(x)= -26+85x-91x^2+44x^3-8x^4+x^5');
axis([0 1.5 -inf inf]);

%�����ǲ�ͬ�����������ٶ�
figure(5)
plot(num1,ea1,'b','LineWidth',2);hold on;
plot(num2,ea2,'g','LineWidth',2);
plot(num3,ea3,'r','LineWidth',2);
legend('���ַ�','�����ڲ巨','ţ�ٷ�');
grid on;
xlabel('��������n');ylabel('|e_a|');title('��ͬ�����������ٶ�');
