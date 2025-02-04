clear
x=1000;

if x<200
    y=x;
elseif x>=200 && x<500
    y=x.*(1-0.03);
elseif x>=500 && x<1000
    y=x.*(1-0.05);
elseif x>=1000 && x<2500
    y=x.*(1-0.08);
elseif x>=2500 && x<5000
    y=x.*(10-0.1);
else 
    y=x.*(1-0.14);
end

disp("The price is "+y +"yuan")


%%
clear
k=1000;
n=50;
x=zeros(n,1);
x(1,1)=50;
group=2;

switch group
    case 1
        r=0.5;
    case 2
        r=1.5;
    otherwise
        r=2.3;
end
for i=1:n-1

    x(i+1,1)=x(i,1)+r*x(i,1)*(1-x(i,1)/k);

end
disp(x)

x=amount(2);
plot(1:n,x);

%% 

x=5; y=6; z=0;
a=1.2;
switch fix(a/10) %  fix 向0方向取整，ceil向上取整，floor向下取整
    case 0
        z=x+y;
    case 1
        z=x*y;
    case 2
        z=x-y;
    otherwise
        z=x./y;
end
 z

 %%

 price=3000;
price=fix(price./1);
  switch price
      case num2cell(0:199)
          price=price;
      case num2cell(200,499)
          price=price*(1-0.03);
      case num2cell(500,999)
          price=price*(1-0.05);
      case num2cell(1000,2499)
          price=price*(1-0.08);
      case num2cell(2500,4999)
          price=price*(1-0.1);
      otherwise
          price=price*(1-0.14);

  end

  disp(price)

  %%
  clear 
  for i=1:3
      y=rand(1,4);
      disp(y)
  end

  %%
clear 
  for i=1:10
   YHKF(:,i)=180+2.5*randn(31,1);
   HZYB(:,i)=178+2*randn(14,1);
   HZEB(:,i)=175+1.5*randn(24,1);
  end
hall=[
YHKF
HZYB
HZEB
];
  


%%

clear
y=0;
n=99999;
for i=1:n
    y=y+1./i.^2;
end

%%
clear
ave=180;
sig=sqrt(5);

height=ave+sig*randn(100);

% h180=[];
% h170=[];
% 
% h180=[h180;h(i)]
for i=1:100
if height(i)>=180
    height_180_above(i)=height(i);
else
    height_180_below(i)=height(i);
end
end


%% 模拟考试一
clear all
Linf=28.26;
k=0.4;
t0=-0.67;

for t=1:7
    Lt(t)=Linf*(1-exp(-k*(t-t0)));
end

%% 模拟考试二
clear all
Linf=28.26;
k=0.4;
t0=-0.67;

for t=1:7
    Lt(t)=Linf*(1-exp(-k*(t-t0)));
end


F1=Lt(1)+0.5*randn(20,1);
F2=Lt(2)+0.5*randn(40,1);
F3=Lt(3)+0.5*randn(50,1);
F4=Lt(4)+0.5*randn(50,1);
F5=Lt(5)+0.5*randn(30,1);
F6=Lt(6)+0.5*randn(30,1);
F7=Lt(7)+0.5*randn(20,1);

F=[F1; F2; F3; F4; F5; F6; F7];

%% 模拟考试三
clear all
Linf=28.26;
k=0.4;
t0=-0.67;

for t=1:7
    Lt(t)=Linf*(1-exp(-k*(t-t0)));
end

for i=1:10
F1(:,i)=Lt(1)+0.5*randn(20,1);
F2(:,i)=Lt(2)+0.5*randn(40,1);
F3(:,i)=Lt(3)+0.5*randn(50,1);
F4(:,i)=Lt(4)+0.5*randn(50,1);
F5(:,i)=Lt(5)+0.5*randn(30,1);
F6(:,i)=Lt(6)+0.5*randn(30,1);
F7(:,i)=Lt(7)+0.5*randn(20,1);

end 

F=[F1; F2; F3; F4; F5; F6; F7];

plot(1:10,F1,'--.','LineWidth',2)
xlabel('Year')
ylabel('Amount')
axis([1 5 10 500])
legend('rate=2.1','rate=2.2')
grid on


%% 模拟考试4
clear all
a=2;
b=3;
c=5;

x=[1.2 3.3 5.0];

for i=1:length(x)
    if 0.5>=x(i) & x(i)<1.5
        y(i)=a*x(i)^2+b*x(i)+c;
    elseif 1.5<=x(i) & x(i)<3.5
        y(i)=a*(sin(b))^c+x(i);
    else
        y(i)=log(abs(b+c/x(i)));
    end
end


%%
[a,b]=fcircle(5);

%% 
clear 
x=100;
[a,b]=fcircle(x)


%% 出院回校第一次上课
L=[3 4 5]
for L=L
    W=0.005*L^3.05
end


t=0:pi/50:2*91;
x=8*cos(t);
y=4*sqrt(2)*sin(t);
z=-4*sqrt(2)*sin(t);
plot3(x,y,z,'P');
xlabel('X')
ylabel('Y')
zlabel('Z')
grid on

%%
x=1:5;
y=11:17;
[X,Y]=meshgrid(x,y)

%%
x=0:0.1:2*pi;
[X,Y]=meshgrid(x);
Z=sin(X).*sin(Y);
surf(X,Y,Z);
colorbar

%%
f=@(x,y)x^2+y^2;
f(2,4)

%%
clear all
oid = 'OceanWatch_aqua_chla_monthly_20020701_20180301_NYS.nc';

% 读取 NetCDF 数据
ncinfo(oid)
tim = ncread(oid, 'time');
latt = ncread(oid, 'latitude');
long = ncread(oid, 'longitude');
chla = ncread(oid, 'chla');

% 提取前4个月的 Chlorophyll 数据
chla1 = chla(:, :, 1);
chla2 = chla(:, :, 2);
chla3 = chla(:, :, 3);
chla4 = chla(:, :, 4);

% 创建经纬度网格
[Nlt, Nlg] = meshgrid(latt, long);

% 加载海岸线数据
% load coast

% 创建子图 1
subplot(2, 2, 1);
pcolor(Nlg, Nlt, chla1);
shading interp;
hold on;
% plot(long, latt, 'k'); % 添加海岸线
title('Chla Month 1');
colorbar;

% 创建子图 2
subplot(2, 2, 2);
pcolor(Nlg, Nlt, chla2);
shading interp;
hold on;
% plot(long, latt, 'k'); % 添加海岸线
title('Chla Month 2');
colorbar;

% 创建子图 3
subplot(2, 2, 3);
pcolor(Nlg, Nlt, chla3);
shading interp;
hold on;
% plot(long, latt, 'k'); % 添加海岸线
title('Chla Month 3');
colorbar;

% 创建子图 4
subplot(2, 2, 4);
pcolor(Nlg, Nlt, chla4);
shading interp;
hold on;
% plot(long, latt, 'k'); % 添加海岸线
title('Chla Month 4');
colorbar;

%%
clear all
f=[13 9 10 11 12 8]';
b=[800 900]';
beq=[400 600 500]';
Lbnd=[0 0 0 0 0 0]';
A=[0.4 1.1 1 0 0 0
   0 0 0 0.5 1.2 1.3];
Aeq



[x,fval,exitflag]

%%模拟考试4
clear all
Aa=0.003;
Ab=2.9;

Ba=0.006;
Bb=3.1;

Ca=0.005;
Cb=3.2;

time=4:0.2:18;

  for j=1:71
    Wa(j)=Aa*(4+j*0.2)^Ab;
    Wb(j)=Ba*(4+j*0.2)^Bb;
    Wc(j)=Ca*(4+j*0.2)^Cb;
    end


plot(time,Wa,'ks','LineWidth',2,'MarkerFace','Black');
hold on
plot(time,Wb,'bv','LineWidth',2, 'MarkerFace','Blue');
hold on
plot(time,Wc,'g*','LineWidth',2,'MakerFace','green');
% length(time)
xlabel('Length');
ylabel('Weight')
legend('aFish','bFish','cFish')
grid on


%%模拟考试5
clear all
Linf1=28.26;
K1=0.40;
t01=-0.67;

Linf2=28.00;
K2=0.39;
t02=-0.56;

Linf3=27.67;
K3=0.30;
t03=-0.66;

Linf4=28.27;
K4=0.38;
t04=-0.73;

Linf5=27.96;
K5=0.42;
t05=-0.63;

time=0:11;

for t = 1:12
    Lt1(t) = Linf1 * (1 - exp(-K1 * (t - t01)));
    Lt2(t) = Linf2 * (1 - exp(-K2 * (t - t02)));
    Lt3(t) = Linf3 * (1 - exp(-K3 * (t - t03)));
    Lt4(t) = Linf4 * (1 - exp(-K4 * (t - t04)));
    Lt5(t) = Linf5 * (1 - exp(-K5 * (t - t05)));
end

h1=plot(time,Lt1,'gs','MarkerFace','green');
hold on;
h2=plot(time,Lt2,'yo');
hold on;
h3=plot(time,Lt3,'bv');
hold on;
h4=plot(time,Lt4,'m.');
hold on;
h5=plot(time,Lt5, 'rp');

xlabel('Length')
ylabel('Lt')
legend([h1, h2, h3, h4, h5], 'Group1','Group2','Group3','Group4','Group5')


plot(1:10,1:10,'rs','MarkerFace','red')

%%

cat = @(x, y) [x^2 + y^2; x * y];
y=cat(2,2);

cat2=@(v) deal(v(1)^2 + v(2)^2, v(1) * v(2));
[output11,output22]=cat2([2,2]);
% Define the function with one input (vector) and one or more outputs
my_func = @(v) deal(v(1)^2 + v(2)^2, v(1) * v(2)); % deal是Matlab内置函数，用于分配和传递多个输出变量
% V(1),V(2)是访问V里面第一和第二个元素
% Call the function with a vector input
input_vector = [3, 4];

% Retrieve multiple outputs
[output1, output2] = my_func(input_vector); % 注意，如果直接写数字是 my_func([3,4])，有[]；

% Display the results
disp(['Output 1 (Sum of squares): ', num2str(output1)]);
disp(['Output 2 (Product): ', num2str(output2)]);


% Define a generalized function for N inputs and M outputs
my_func = @(v) deal(sum(v), prod(v), mean(v));

% Example input vector
input_vector = [2, 3, 4];

% Retrieve multiple outputs
[sum_result, prod_result, mean_result] = my_func(input_vector);

% Display the results
disp(['Sum: ', num2str(sum_result)]);
disp(['Product: ', num2str(prod_result)]);
disp(['Mean: ', num2str(mean_result)]);


%%
clear all
% f=[13
%     9
%     10
%     11
%     12
%     8
%     ];

f=[13 9 10 11 12 8]'; % min f(x)每个x前面的系数

A=[0.4 1.1 1 0 0 0
   0 0 0 0.5 1.2 1.3]; % 不等式约束各变量前系数

b=[800 900]';

Aeq=[1 0 0 1 0 0
    0 1 0 0 1 0
    0 0 1 0 0 1]; % 等式约束各变量前系数

beq=[400 600 500]';

Lbnd=[0 0 0 0 0 0]'; % 变量下界

Ubnd=[]; % 变量上界


[x,fval,existflag]=linprog(f,A,b,Aeq,beq,Lbnd,Ubnd);


%%
clear all 
f=[-5 -4 -6]';
A=[1 -1 1
    3 2 4
    3 2 0];
b=[20 42 30]';

Lbnd=[0 0 0]';

Ubnd=[];

[x,fval,existflag]=linprog(f,A,b,[],[],Lbnd,Ubnd);

%%
clear all
profit=[6 7]';

A=[2 3
    4 1];
b=[16 12]';

Lbnd=[0 0];
Ubnd=[];

[x,fval,existflag]=linprog(-profit,A,b,[],[],Lbnd,Ubnd);

%% 
clear all
z=[2 3 -5]';
A=[-2 5 -1
    1 3 1];
b=[-10 12]';

Aeq=[1 1 1];
beq=7;
  
Lbnd=[0 0 0]';
Ubnd=[];

[x,fval,existflag]=linprog(-z,A,b,Aeq,beq,Lbnd,Ubnd);

%% 
clear all
f=[40 36]';
A=[-200 -120];
b=[-1800]';

Lbnd=[0 0]';
Ubnd=[];

[x,fval,existflag]=linprog(f,A,b,[],[],Lbnd,Ubnd);

%%
clear all
f=[3 -1 -1]';
A=[1 -2 1
    4 -1 -2];
b=[11 -3]';
Aeq=[-2 0 1];
beq=1;
Lbnd=[0 0 0]';
Ubnd=[]';
[x,fval,existflag]=linprog(-f,A,b,Aeq,beq,Lbnd,Ubnd);

%% 
clear all
f=[3 2 -1]';
A=[4 -3 -1
    1 -1 2];
b=[-4 10]';
Aeq=[-2 2 -1];
beq=-1;
Lbnd=[0 0 0]';
Ubnd=[]';
[x,fval,existflag]=linprog(-f,A,b,Aeq,beq,Lbnd,Ubnd);

%%
clear all
f=[6 6.5]';
intcon=[1,2]';
A=[20 50
    50 40];
b=[120 150]';
Lbnd=[0 0 0]';

[x,fval,existflag]=intlinprog(-f,intcon,A,b,[],[],Lbnd,[]);

%%
clear all
f=[20 10]';
intcon=[1 2]';
A=[5 4
    2 5];
b=[24 13]';
Lbnd=[0 0]';

[x,fval,existflag]=intlinprog(-f,intcon,A,b,[],[],Lbnd,[]);

%% 
clear all
f=[5 5.1 5.4 5.5 0.2 0.2 0.2]';
intcon=[1:7]';
A=[1 0 0 0 0 0 0
    0 1 0 0 0 0 0
    0 0 1 0 0 0 0
    0 0 0 1 0 0 0];
b=[30 40 45 20]';
Aeq=[1 0 0 0 -1 0 0
    0 1 0 0 1 -1 0
    0 0 1 0 0 1 -1
    0 0 0 1 0 0 1];
beq=[15 25 35 25]';
Lbnd=[0 0 0 0 0 0 0]';
Ubnd=[]';

[x,fval,existflag]=intlinprog(f,intcon,A,b,Aeq,beq,Lbnd,Ubnd);

%%
clear all
f=[540 200 180 350 60 150 280 450 320 120]';
intcon=[1:10]';
A=[6 3 4 5 1 2 3 5 4 2];
b=[30]';
Lbnd=[0 0 0 0 0 0 0 0 0 0]';
Ubnd=[1 1 1 1 1 1 1 1 1 1]';

[x,fval,existflag]=intlinprog(-f,intcon,A,b,[],[],Lbnd,Ubnd);

%%
%%
clear all
f=[66.8 75.6 87 58.6 57.2 66 66.4 53 78 67.8 84.6 59.4 70 74.2 69.6 57.2 67.4 71 83.8 62.4]';
intcon=[1:20]';
A=[1	1	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
   0	0	0	0	1	1	1	1	0	0	0	0	0	0	0	0	0	0	0	0
   0	0	0	0	0	0	0	0	1	1	1	1	0	0	0	0	0	0	0	0
   0	0	0	0	0	0	0	0	0	0	0	0	1	1	1	1	0	0	0	0
   0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	1	1

];
b=[1 1 1 1 1]';

Aeq=[1	0	0	0	1	0	0	0	1	0	0	0	1	0	0	0	1	0	0	0
     0	1	0	0	0	1	0	0	0	1	0	0	0	1	0	0	0	1	0	0
     0	0	1	0	0	0	1	0	0	0	1	0	0	0	1	0	0	0	1	0
     0	0	0	1	0	0	0	1	0	0	0	1	0	0	0	1	0	0	0	1

];
beq=[1 1 1 1]';

Lbnd=[0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0
]';
Ubnd=[1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1
]';

[x,fval,existflag]=intlinprog(f,intcon,A,b,Aeq,beq,Lbnd,Ubnd);

%%
clear all
f=[15 18 21 24 19 23 33 18 26 17 16 19 19 21 23 17]';
intcon=[1:16]';
Aeq=[1	1	1	1	0	0	0	0	1	0	0	0	1	0	0	0
0	0	0	0	1	1	1	1	0	1	0	0	0	0	0	0
0	0	1	0	0	0	0	0	1	1	1	1	0	0	0	0
0	0	0	0	0	0	0	0	0	0	0	0	1	1	1	1
1	0	0	0	1	0	0	0	1	0	0	0	1	0	0	0
0	1	0	0	0	1	0	0	0	1	0	0	0	1	0	0
0	0	1	0	0	0	1	0	0	0	1	0	0	0	1	0
0	0	0	1	0	0	0	1	0	0	0	1	0	0	0	1
];
beq=[1 1 1 1 1 1 1 1]';
Lbnd=[0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0]';
Ubnd=[1	1	1	1	1	1	1	1	1	1	1	1	1	1	1	1]';
[x,fval,existflag]=intlinprog(f,intcon,[],[],Aeq,beq,Lbnd,Ubnd);

%%
f=@(x) [-x(1)*x(2)*x(3)];
x0=[2 2 2]';
Lbnd=[0 0 0]';
Ubnd=[];
[x,fval,existflag]=fmincon(f,x0,[],[],[],[],Lbnd,Ubnd,@rec);

%%
clear all
x0=[0,2]';
A=[0,1];
b=2';
Aeq=[];
beq=[]';
Lbnd=[]';
Ubnd=[10,2]';

[x,fval,existflag]=fmincon(@zuixiaohua,x0,A,b,Aeq,beq,Lbnd,Ubnd,@xianzhi);

%%
clear all
x0=[1,2]';
A=[];
b=[]';
Aeq=[];
beq=[]';
Lbnd=[]';
Ubnd=[]';

[x,fval,existflag]=fmincon(@youhuahanshu,x0,A,b,Aeq,beq,Lbnd,Ubnd,@changfangtixianzhi);

%%
clear all
x0=[2,2]';
A=[];
b=[];
Aeq=[1,-2];
beq=-1;
Lbnd=[];
Ubnd=[];

[x,fval,existflag]=fmincon(@hanshu,x0,A,b,Aeq,beq,Lbnd,Ubnd,@disanti);

