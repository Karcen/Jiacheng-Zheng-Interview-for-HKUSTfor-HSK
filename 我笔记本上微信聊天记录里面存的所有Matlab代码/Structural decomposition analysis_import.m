% 可再生电力价值链metal import SDA


cd 2010
n=49; %地区数量
m=163;%部门数量
mn=m*n;


E0=xlsread('Intensity.csv','intensity','B2:B7988'); %行向量或列向量
F0=xlsread('Finaldemand.csv','finaldemand','B2:MF7988');%完整的最终需求矩阵
A0=xlsread('a_matrix.csv','a_matrix','B2:KUF7988');%完整的中间投矩阵
%注意删掉标签

cd ..
cd 2015
E1=xlsread('Intensity.csv','intensity','B2:B7988'); %行向量或列向量
F1=xlsread('Finaldemand.csv','finaldemand','B2:MF7988');%完整的最终需求矩阵
A1=xlsread('a_matrix.csv','a_matrix','B2:KUF7988');%完整的中间投入矩阵
%---------------------------------------data input
Fx=zeros(mn,n);
for i=1:n
    Fx(:,i)=sum(F0(:,(i-1)*7+1:i*7),2);
end    
F0=Fx;

Fa=F0; % Fa 是去掉对角线地区的最终需求
for i=1:n
    Fa((i-1)*m+1:i*m,i)=0;
end
Fa=diag(sum(Fa,2)); %每个地区�?终产品出�? mn对角矩阵

% Fb=sum(F0,2)'; %每个地区本地消费和出口的�?终产�? mn行向�?
% Ftemp1=zeros(n,mn);
%     for i=1:n
%          Ftemp1(i,:)=(sum(Fb,2))';
%     end
% %每个地区�?终需�? (包含供给本地的和出口�?)

E=reshape(E0,m,n)';
Etemp=zeros(n,mn);
for i=1:n
    Etemp(i,(i-1)*m+1:i*m)=Etemp(i,(i-1)*m+1:i*m)+E(i,:);
end
E0=Etemp;
% 变量1：得到E是n*mn矩阵，每行对应列的位置是�?个国家的直接强度

Acell=mat2cell(A0,ones(1,n)*m,mn); %A0切为n*1个cell
Atemp=zeros(m,mn,n);
for i=1:n
    Atemp(:,:,i)=cell2mat(Acell(i,1));
end   
H0=sum(Atemp,3); 
    
Htemp=zeros(mn,mn); 
for i=1:n
    Htemp((i-1)*m+1:i*m,:)=H0;
end 
H0=Htemp;
% 变量2：H为m*mn的矩�?

T0=A0./H0; 
T0(isnan(T0)==1)=0;
% 变量3：mn*mn的矩�?
% A0=T0.*Htemp;% �?要验证？？？？？

Fcell=mat2cell(F0,ones(1,n)*m,n); %把完整的F切为n*1个cell
Ftemp=zeros(m,n,n);
for i=1:n
    Ftemp(:,:,i)=cell2mat(Fcell(i,1));
end   
Qtemp=sum(Ftemp,3);

% Q0=zeros(n,mn);
% for i=1:n
%     Q0(i,(i-1)*m+1:i*m)=(Qtemp(:,i))';
% end   


Qtemp1=zeros(mn,n); 
for i=1:n
    Qtemp1((i-1)*m+1:i*m,:)=Qtemp;
end 
Q0=Qtemp1;
% 变量4：n*nm的矩�?

D0=F0./Q0; 
D0(isnan(D0)==1)=0;
% 变量5�?(mn,n)矩阵
% �?要验证F0=Q0.*D0;
%---------------------------------------生成变量


%---------------------------------------源数据输�?
Fx=zeros(mn,n);
for i=1:n
    Fx(:,i)=sum(F1(:,(i-1)*7+1:i*7),2);
end    
F1=Fx;

Fa=F1; % Fa 是去掉对角线地区的最终需�?
for i=1:n
    Fa((i-1)*m+1:i*m,i)=0;
end
Fa=diag(sum(Fa,2)); %每个地区�?终产品出�? mn对角矩阵

% Fb=sum(F0,2)'; %每个地区本地消费和出口的�?终产�? mn行向�?
% Ftemp1=zeros(n,mn);
%     for i=1:n
%          Ftemp1(i,:)=(sum(Fb,2))';
%     end
% %每个地区�?终需�? (包含供给本地的和出口�?)

E=reshape(E1,m,n)';
Etemp=zeros(n,mn);
for i=1:n
    Etemp(i,(i-1)*m+1:i*m)=Etemp(i,(i-1)*m+1:i*m)+E(i,:);
end
E1=Etemp;
% 变量1：得到E是n*mn矩阵，每行对应列的位置是�?个国家的直接强度

Acell=mat2cell(A1,ones(1,n)*m,mn); %A0切为n*1个cell
Atemp=zeros(m,mn,n);
for i=1:n
    Atemp(:,:,i)=cell2mat(Acell(i,1));
end   
H1=sum(Atemp,3); 
    
Htemp=zeros(mn,mn); 
for i=1:n
    Htemp((i-1)*m+1:i*m,:)=H1;
end 
H1=Htemp;
% 变量2：H为m*mn的矩�?

T1=A1./H1; 
T1(isnan(T1)==1)=0;
% 变量3：mn*mn的矩�?
% A0=T0.*Htemp;% �?要验证？？？？？

Fcell=mat2cell(F1,ones(1,n)*m,n); %把完整的F切为n*1个cell
Ftemp=zeros(m,n,n);
for i=1:n
    Ftemp(:,:,i)=cell2mat(Fcell(i,1));
end   
Qtemp=sum(Ftemp,3);

% Q0=zeros(n,mn);
% for i=1:n
%     Q0(i,(i-1)*m+1:i*m)=(Qtemp(:,i))';
% end   


Qtemp1=zeros(mn,n); 
for i=1:n
    Qtemp1((i-1)*m+1:i*m,:)=Qtemp;
end 
Q1=Qtemp1;
% 变量4：n*nm的矩�?

D1=F1./Q1; 
D1(isnan(D1)==1)=0;
% 变量5�?(mn,n)矩阵
% �?要验证F0=Q0.*D0;
%-----------------------------------------------



n=49; %地区数量
m=163;%部门数量
mn=m*n;

En=E0;
Ew=E0;
Tn=T0;
Tw=T0;
Hn=H0;
Hw=H0;
Dn=D0;
Dw=D0;
Qn=Q0;
Qw=Q0;

result1=zeros(n,1);
for k = 1:n
    i = (k-1)*m+1;
    index1 = zeros(n,mn);
    index1(k,:)= 1;
    index2 = zeros(mn,mn);
    index2( :,i:i+m-1)=1;
    index3 = zeros(mn,mn);
    index3(i:i+m-1,:) = 1;
    index3(:,i:i+m-1) = 1;
    index4 = zeros(mn,n);
    index4(i:i+m-1,:)=1;
    index4(:,k)=1;
    index5=zeros(mn,n);
    index5(:,k)=1;

    E=En.*index1+Ew.*(ones(n,mn)-index1); %n*mn矩阵,加号前面表示国内的，加号后面是国外的
    H=Hn.*index2+Hw.*(ones(mn,mn)-index2); %H为m*mn的矩�???
    T=Tn.*index3+Tw.*(ones(mn,mn)-index3) ; %mn*mn的矩�???
    D=Dn.*index4+Dw.*(ones(mn,n)-index4) ; %mn*n矩阵
    Q=Qn.*index5+Qw.*(ones(mn,n)-index5); %m*n的矩�???

    L=inv(eye(mn)-(T.*H)); % A0=T0.*H0
    V=E*L; % SI中等�?4的n*mn V矩阵
    V_a=ones(n,mn)*diag(sum(V))-V;%每一行是全球隐含强度去除当地强度 
    Fa=Q.*D; % Fa 每列是地区的�?终需�?
    
    Axx=T.*H; %投入系数矩阵
    X=L*(sum(Q.*D,2)); %总产出mn*1
    Xtemp=zeros(mn,mn);
    for i=1:mn
        Xtemp(i,:)=X';
    end
    Z=Axx.*Xtemp; %中间流动矩阵
    Ztemp=zeros(mn,n);%每个地区中间�?求合并为1�?
    for i=1:n
        Ztemp(:,i)=sum(Z(:,(i-1)*m+1:i*m),2);
    end   
    
    Utool=zeros(mn,n); %构建工具矩阵，把Faa中非可再生能源部门变�??0
    for i=1:n
        Utool((i-1)*163+99:(i-1)*163+106,:)=1;
        Utool((i-1)*163+101,:)=0;
    end
    Eaa=(Fa+Ztemp).*Utool;
    Eaa=sum(V_a'.*Eaa);%每个地区进口隐含金属
    result1(k,:)=Eaa(:,k);
end 
 
EEE0=result1;


En=E1;
Ew=E1;
Tn=T1;
Tw=T1;
Hn=H1;
Hw=H1;
Dn=D1;
Dw=D1;
Qn=Q1;
Qw=Q1;

result1=zeros(n,1);
for k = 1:n
    i = (k-1)*m+1;
    index1 = zeros(n,mn);
    index1(k,:)= 1;
    index2 = zeros(mn,mn);
    index2( :,i:i+m-1)=1;
    index3 = zeros(mn,mn);
    index3(i:i+m-1,:) = 1;
    index3(:,i:i+m-1) = 1;
    index4 = zeros(mn,n);
    index4(i:i+m-1,:)=1;
    index4(:,k)=1;
    index5=zeros(mn,n);
    index5(:,k)=1;

    E=En.*index1+Ew.*(ones(n,mn)-index1); %n*mn矩阵,加号前面表示国内的，加号后面是国外的
    H=Hn.*index2+Hw.*(ones(mn,mn)-index2); %H为m*mn的矩�???
    T=Tn.*index3+Tw.*(ones(mn,mn)-index3) ; %mn*mn的矩�???
    D=Dn.*index4+Dw.*(ones(mn,n)-index4) ; %mn*n矩阵
    Q=Qn.*index5+Qw.*(ones(mn,n)-index5); %m*n的矩�???

    L=inv(eye(mn)-(T.*H)); % A0=T0.*H0
    V=E*L; % SI中等�?4的n*mn V矩阵
    V_a=ones(n,mn)*diag(sum(V))-V;%每一行是全球隐含强度去除当地强度 
    Fa=Q.*D; % Fa 每列是地区的�?终需�?
    
    Axx=T.*H; %投入系数矩阵
    X=L*(sum(Q.*D,2)); %总产出mn*1
    Xtemp=zeros(mn,mn);
    for i=1:mn
        Xtemp(i,:)=X';
    end
    Z=Axx.*Xtemp; %中间流动矩阵
    Ztemp=zeros(mn,n);%每个地区中间�?求合并为1�?
    for i=1:n
        Ztemp(:,i)=sum(Z(:,(i-1)*m+1:i*m),2);
    end   
    
    Utool=zeros(mn,n); %构建工具矩阵，把Faa中非可再生能源部门变�??0
    for i=1:n
        Utool((i-1)*163+99:(i-1)*163+106,:)=1;
        Utool((i-1)*163+101,:)=0;
    end
    Eaa=(Fa+Ztemp).*Utool;
    Eaa=sum(V_a'.*Eaa);%每个地区进口隐含金属
    result1(k,:)=Eaa(:,k);
end 
EEE1=result1;
E_N11=EEE1;

En=E0;
Ew=E1;
Tn=T1;
Tw=T1;
Hn=H1;
Hw=H1;
Dn=D1;
Dw=D1;
Qn=Q1;
Qw=Q1;
 
result1=zeros(n,1);
for k = 1:n
    i = (k-1)*m+1;
    index1 = zeros(n,mn);
    index1(k,:)= 1;
    index2 = zeros(mn,mn);
    index2( :,i:i+m-1)=1;
    index3 = zeros(mn,mn);
    index3(i:i+m-1,:) = 1;
    index3(:,i:i+m-1) = 1;
    index4 = zeros(mn,n);
    index4(i:i+m-1,:)=1;
    index4(:,k)=1;
    index5=zeros(mn,n);
    index5(:,k)=1;

    E=En.*index1+Ew.*(ones(n,mn)-index1); %n*mn矩阵,加号前面表示国内的，加号后面是国外的
    H=Hn.*index2+Hw.*(ones(mn,mn)-index2); %H为m*mn的矩�???
    T=Tn.*index3+Tw.*(ones(mn,mn)-index3) ; %mn*mn的矩�???
    D=Dn.*index4+Dw.*(ones(mn,n)-index4) ; %mn*n矩阵
    Q=Qn.*index5+Qw.*(ones(mn,n)-index5); %m*n的矩�???

    L=inv(eye(mn)-(T.*H)); % A0=T0.*H0
    V=E*L; % SI中等�?4的n*mn V矩阵
    V_a=ones(n,mn)*diag(sum(V))-V;%每一行是全球隐含强度去除当地强度 
    Fa=Q.*D; % Fa 每列是地区的�?终需�?
    
    Axx=T.*H; %投入系数矩阵
    X=L*(sum(Q.*D,2)); %总产出mn*1
    Xtemp=zeros(mn,mn);
    for i=1:mn
        Xtemp(i,:)=X';
    end
    Z=Axx.*Xtemp; %中间流动矩阵
    Ztemp=zeros(mn,n);%每个地区中间�?求合并为1�?
    for i=1:n
        Ztemp(:,i)=sum(Z(:,(i-1)*m+1:i*m),2);
    end   
    
    Utool=zeros(mn,n); %构建工具矩阵，把Faa中非可再生能源部门变�??0
    for i=1:n
        Utool((i-1)*163+99:(i-1)*163+106,:)=1;
        Utool((i-1)*163+101,:)=0;
    end
    Eaa=(Fa+Ztemp).*Utool;
    Eaa=sum(V_a'.*Eaa);%每个地区进口隐含金属
    result1(k,:)=Eaa(:,k);
end 
E_N12=result1;

E_W11=E_N12;

En=E0;
Ew=E0;
Tn=T1;
Tw=T1;
Hn=H1;
Hw=H1;
Dn=D1;
Dw=D1;
Qn=Q1;
Qw=Q1;
 
result1=zeros(n,1);
for k = 1:n
    i = (k-1)*m+1;
    index1 = zeros(n,mn);
    index1(k,:)= 1;
    index2 = zeros(mn,mn);
    index2( :,i:i+m-1)=1;
    index3 = zeros(mn,mn);
    index3(i:i+m-1,:) = 1;
    index3(:,i:i+m-1) = 1;
    index4 = zeros(mn,n);
    index4(i:i+m-1,:)=1;
    index4(:,k)=1;
    index5=zeros(mn,n);
    index5(:,k)=1;

    E=En.*index1+Ew.*(ones(n,mn)-index1); %n*mn矩阵,加号前面表示国内的，加号后面是国外的
    H=Hn.*index2+Hw.*(ones(mn,mn)-index2); %H为m*mn的矩�???
    T=Tn.*index3+Tw.*(ones(mn,mn)-index3) ; %mn*mn的矩�???
    D=Dn.*index4+Dw.*(ones(mn,n)-index4) ; %mn*n矩阵
    Q=Qn.*index5+Qw.*(ones(mn,n)-index5); %m*n的矩�???

    L=inv(eye(mn)-(T.*H)); % A0=T0.*H0
    V=E*L; % SI中等�?4的n*mn V矩阵
    V_a=ones(n,mn)*diag(sum(V))-V;%每一行是全球隐含强度去除当地强度 
    Fa=Q.*D; % Fa 每列是地区的�?终需�?
    
    Axx=T.*H; %投入系数矩阵
    X=L*(sum(Q.*D,2)); %总产出mn*1
    Xtemp=zeros(mn,mn);
    for i=1:mn
        Xtemp(i,:)=X';
    end
    Z=Axx.*Xtemp; %中间流动矩阵
    Ztemp=zeros(mn,n);%每个地区中间�?求合并为1�?
    for i=1:n
        Ztemp(:,i)=sum(Z(:,(i-1)*m+1:i*m),2);
    end   
    
    Utool=zeros(mn,n); %构建工具矩阵，把Faa中非可再生能源部门变�??0
    for i=1:n
        Utool((i-1)*163+99:(i-1)*163+106,:)=1;
        Utool((i-1)*163+101,:)=0;
    end
    Eaa=(Fa+Ztemp).*Utool;
    Eaa=sum(V_a'.*Eaa);%每个地区进口隐含金属
    result1(k,:)=Eaa(:,k);
end 
E_W12=result1;
T_N11=E_W12;

En=E0;
Ew=E0;
Tn=T0;
Tw=T1;
Hn=H1;
Hw=H1;
Dn=D1;
Dw=D1;
Qn=Q1;
Qw=Q1;
 
result1=zeros(n,1);
for k = 1:n
    i = (k-1)*m+1;
    index1 = zeros(n,mn);
    index1(k,:)= 1;
    index2 = zeros(mn,mn);
    index2( :,i:i+m-1)=1;
    index3 = zeros(mn,mn);
    index3(i:i+m-1,:) = 1;
    index3(:,i:i+m-1) = 1;
    index4 = zeros(mn,n);
    index4(i:i+m-1,:)=1;
    index4(:,k)=1;
    index5=zeros(mn,n);
    index5(:,k)=1;

    E=En.*index1+Ew.*(ones(n,mn)-index1); %n*mn矩阵,加号前面表示国内的，加号后面是国外的
    H=Hn.*index2+Hw.*(ones(mn,mn)-index2); %H为m*mn的矩�???
    T=Tn.*index3+Tw.*(ones(mn,mn)-index3) ; %mn*mn的矩�???
    D=Dn.*index4+Dw.*(ones(mn,n)-index4) ; %mn*n矩阵
    Q=Qn.*index5+Qw.*(ones(mn,n)-index5); %m*n的矩�???

    L=inv(eye(mn)-(T.*H)); % A0=T0.*H0
    V=E*L; % SI中等�?4的n*mn V矩阵
    V_a=ones(n,mn)*diag(sum(V))-V;%每一行是全球隐含强度去除当地强度 
    Fa=Q.*D; % Fa 每列是地区的�?终需�?
    
    Axx=T.*H; %投入系数矩阵
    X=L*(sum(Q.*D,2)); %总产出mn*1
    Xtemp=zeros(mn,mn);
    for i=1:mn
        Xtemp(i,:)=X';
    end
    Z=Axx.*Xtemp; %中间流动矩阵
    Ztemp=zeros(mn,n);%每个地区中间�?求合并为1�?
    for i=1:n
        Ztemp(:,i)=sum(Z(:,(i-1)*m+1:i*m),2);
    end   
    
    Utool=zeros(mn,n); %构建工具矩阵，把Faa中非可再生能源部门变�??0
    for i=1:n
        Utool((i-1)*163+99:(i-1)*163+106,:)=1;
        Utool((i-1)*163+101,:)=0;
    end
    Eaa=(Fa+Ztemp).*Utool;
    Eaa=sum(V_a'.*Eaa);%每个地区进口隐含金属
    result1(k,:)=Eaa(:,k);
end 
T_N12=result1;
T_W11=T_N12;


En=E0;
Ew=E0;
Tn=T0;
Tw=T0;
Hn=H1;
Hw=H1;
Dn=D1;
Dw=D1;
Qn=Q1;
Qw=Q1;
 
result1=zeros(n,1);
for k = 1:n
    i = (k-1)*m+1;
    index1 = zeros(n,mn);
    index1(k,:)= 1;
    index2 = zeros(mn,mn);
    index2( :,i:i+m-1)=1;
    index3 = zeros(mn,mn);
    index3(i:i+m-1,:) = 1;
    index3(:,i:i+m-1) = 1;
    index4 = zeros(mn,n);
    index4(i:i+m-1,:)=1;
    index4(:,k)=1;
    index5=zeros(mn,n);
    index5(:,k)=1;

    E=En.*index1+Ew.*(ones(n,mn)-index1); %n*mn矩阵,加号前面表示国内的，加号后面是国外的
    H=Hn.*index2+Hw.*(ones(mn,mn)-index2); %H为m*mn的矩�???
    T=Tn.*index3+Tw.*(ones(mn,mn)-index3) ; %mn*mn的矩�???
    D=Dn.*index4+Dw.*(ones(mn,n)-index4) ; %mn*n矩阵
    Q=Qn.*index5+Qw.*(ones(mn,n)-index5); %m*n的矩�???

    L=inv(eye(mn)-(T.*H)); % A0=T0.*H0
    V=E*L; % SI中等�?4的n*mn V矩阵
    V_a=ones(n,mn)*diag(sum(V))-V;%每一行是全球隐含强度去除当地强度 
    Fa=Q.*D; % Fa 每列是地区的�?终需�?
    
    Axx=T.*H; %投入系数矩阵
    X=L*(sum(Q.*D,2)); %总产出mn*1
    Xtemp=zeros(mn,mn);
    for i=1:mn
        Xtemp(i,:)=X';
    end
    Z=Axx.*Xtemp; %中间流动矩阵
    Ztemp=zeros(mn,n);%每个地区中间�?求合并为1�?
    for i=1:n
        Ztemp(:,i)=sum(Z(:,(i-1)*m+1:i*m),2);
    end   
    
    Utool=zeros(mn,n); %构建工具矩阵，把Faa中非可再生能源部门变�??0
    for i=1:n
        Utool((i-1)*163+99:(i-1)*163+106,:)=1;
        Utool((i-1)*163+101,:)=0;
    end
    Eaa=(Fa+Ztemp).*Utool;
    Eaa=sum(V_a'.*Eaa);%每个地区进口隐含金属
    result1(k,:)=Eaa(:,k);
end 
T_W12=result1;
H_N11=T_W12;

En=E0;
Ew=E0;
Tn=T0;
Tw=T0;
Hn=H0;
Hw=H1;
Dn=D1;
Dw=D1;
Qn=Q1;
Qw=Q1;
 
result1=zeros(n,1);
for k = 1:n
    i = (k-1)*m+1;
    index1 = zeros(n,mn);
    index1(k,:)= 1;
    index2 = zeros(mn,mn);
    index2( :,i:i+m-1)=1;
    index3 = zeros(mn,mn);
    index3(i:i+m-1,:) = 1;
    index3(:,i:i+m-1) = 1;
    index4 = zeros(mn,n);
    index4(i:i+m-1,:)=1;
    index4(:,k)=1;
    index5=zeros(mn,n);
    index5(:,k)=1;

    E=En.*index1+Ew.*(ones(n,mn)-index1); %n*mn矩阵,加号前面表示国内的，加号后面是国外的
    H=Hn.*index2+Hw.*(ones(mn,mn)-index2); %H为m*mn的矩�???
    T=Tn.*index3+Tw.*(ones(mn,mn)-index3) ; %mn*mn的矩�???
    D=Dn.*index4+Dw.*(ones(mn,n)-index4) ; %mn*n矩阵
    Q=Qn.*index5+Qw.*(ones(mn,n)-index5); %m*n的矩�???

    L=inv(eye(mn)-(T.*H)); % A0=T0.*H0
    V=E*L; % SI中等�?4的n*mn V矩阵
    V_a=ones(n,mn)*diag(sum(V))-V;%每一行是全球隐含强度去除当地强度 
    Fa=Q.*D; % Fa 每列是地区的�?终需�?
    
    Axx=T.*H; %投入系数矩阵
    X=L*(sum(Q.*D,2)); %总产出mn*1
    Xtemp=zeros(mn,mn);
    for i=1:mn
        Xtemp(i,:)=X';
    end
    Z=Axx.*Xtemp; %中间流动矩阵
    Ztemp=zeros(mn,n);%每个地区中间�?求合并为1�?
    for i=1:n
        Ztemp(:,i)=sum(Z(:,(i-1)*m+1:i*m),2);
    end   
    
    Utool=zeros(mn,n); %构建工具矩阵，把Faa中非可再生能源部门变�??0
    for i=1:n
        Utool((i-1)*163+99:(i-1)*163+106,:)=1;
        Utool((i-1)*163+101,:)=0;
    end
    Eaa=(Fa+Ztemp).*Utool;
    Eaa=sum(V_a'.*Eaa);%每个地区进口隐含金属
    result1(k,:)=Eaa(:,k);
end 
H_N12=result1;
H_W11=H_N12;

En=E0;
Ew=E0;
Tn=T0;
Tw=T0;
Hn=H0;
Hw=H0;
Dn=D1;
Dw=D1;
Qn=Q1;
Qw=Q1;
 
result1=zeros(n,1);
for k = 1:n
    i = (k-1)*m+1;
    index1 = zeros(n,mn);
    index1(k,:)= 1;
    index2 = zeros(mn,mn);
    index2( :,i:i+m-1)=1;
    index3 = zeros(mn,mn);
    index3(i:i+m-1,:) = 1;
    index3(:,i:i+m-1) = 1;
    index4 = zeros(mn,n);
    index4(i:i+m-1,:)=1;
    index4(:,k)=1;
    index5=zeros(mn,n);
    index5(:,k)=1;

    E=En.*index1+Ew.*(ones(n,mn)-index1); %n*mn矩阵,加号前面表示国内的，加号后面是国外的
    H=Hn.*index2+Hw.*(ones(mn,mn)-index2); %H为m*mn的矩�???
    T=Tn.*index3+Tw.*(ones(mn,mn)-index3) ; %mn*mn的矩�???
    D=Dn.*index4+Dw.*(ones(mn,n)-index4) ; %mn*n矩阵
    Q=Qn.*index5+Qw.*(ones(mn,n)-index5); %m*n的矩�???

    L=inv(eye(mn)-(T.*H)); % A0=T0.*H0
    V=E*L; % SI中等�?4的n*mn V矩阵
    V_a=ones(n,mn)*diag(sum(V))-V;%每一行是全球隐含强度去除当地强度 
    Fa=Q.*D; % Fa 每列是地区的�?终需�?
    
    Axx=T.*H; %投入系数矩阵
    X=L*(sum(Q.*D,2)); %总产出mn*1
    Xtemp=zeros(mn,mn);
    for i=1:mn
        Xtemp(i,:)=X';
    end
    Z=Axx.*Xtemp; %中间流动矩阵
    Ztemp=zeros(mn,n);%每个地区中间�?求合并为1�?
    for i=1:n
        Ztemp(:,i)=sum(Z(:,(i-1)*m+1:i*m),2);
    end   
    
    Utool=zeros(mn,n); %构建工具矩阵，把Faa中非可再生能源部门变�??0
    for i=1:n
        Utool((i-1)*163+99:(i-1)*163+106,:)=1;
        Utool((i-1)*163+101,:)=0;
    end
    Eaa=(Fa+Ztemp).*Utool;
    Eaa=sum(V_a'.*Eaa);%每个地区进口隐含金属
    result1(k,:)=Eaa(:,k);
end 
H_W12=result1;
D_N11=H_W12;

 
En=E0;
Ew=E0;
Tn=T0;
Tw=T0;
Hn=H0;
Hw=H0;
Dn=D0;
Dw=D1;
Qn=Q1;
Qw=Q1;
 
result1=zeros(n,1);
for k = 1:n
    i = (k-1)*m+1;
    index1 = zeros(n,mn);
    index1(k,:)= 1;
    index2 = zeros(mn,mn);
    index2( :,i:i+m-1)=1;
    index3 = zeros(mn,mn);
    index3(i:i+m-1,:) = 1;
    index3(:,i:i+m-1) = 1;
    index4 = zeros(mn,n);
    index4(i:i+m-1,:)=1;
    index4(:,k)=1;
    index5=zeros(mn,n);
    index5(:,k)=1;

    E=En.*index1+Ew.*(ones(n,mn)-index1); %n*mn矩阵,加号前面表示国内的，加号后面是国外的
    H=Hn.*index2+Hw.*(ones(mn,mn)-index2); %H为m*mn的矩�???
    T=Tn.*index3+Tw.*(ones(mn,mn)-index3) ; %mn*mn的矩�???
    D=Dn.*index4+Dw.*(ones(mn,n)-index4) ; %mn*n矩阵
    Q=Qn.*index5+Qw.*(ones(mn,n)-index5); %m*n的矩�???

    L=inv(eye(mn)-(T.*H)); % A0=T0.*H0
    V=E*L; % SI中等�?4的n*mn V矩阵
    V_a=ones(n,mn)*diag(sum(V))-V;%每一行是全球隐含强度去除当地强度 
    Fa=Q.*D; % Fa 每列是地区的�?终需�?
    
    Axx=T.*H; %投入系数矩阵
    X=L*(sum(Q.*D,2)); %总产出mn*1
    Xtemp=zeros(mn,mn);
    for i=1:mn
        Xtemp(i,:)=X';
    end
    Z=Axx.*Xtemp; %中间流动矩阵
    Ztemp=zeros(mn,n);%每个地区中间�?求合并为1�?
    for i=1:n
        Ztemp(:,i)=sum(Z(:,(i-1)*m+1:i*m),2);
    end   
    
    Utool=zeros(mn,n); %构建工具矩阵，把Faa中非可再生能源部门变�??0
    for i=1:n
        Utool((i-1)*163+99:(i-1)*163+106,:)=1;
        Utool((i-1)*163+101,:)=0;
    end
    Eaa=(Fa+Ztemp).*Utool;
    Eaa=sum(V_a'.*Eaa);%每个地区进口隐含金属
    result1(k,:)=Eaa(:,k);
end 
D_N12=result1;
D_W11=D_N12;


En=E0;
Ew=E0;
Tn=T0;
Tw=T0;
Hn=H0;
Hw=H0;
Dn=D0;
Dw=D0;
Qn=Q1;
Qw=Q1;
 
result1=zeros(n,1);
for k = 1:n
    i = (k-1)*m+1;
    index1 = zeros(n,mn);
    index1(k,:)= 1;
    index2 = zeros(mn,mn);
    index2( :,i:i+m-1)=1;
    index3 = zeros(mn,mn);
    index3(i:i+m-1,:) = 1;
    index3(:,i:i+m-1) = 1;
    index4 = zeros(mn,n);
    index4(i:i+m-1,:)=1;
    index4(:,k)=1;
    index5=zeros(mn,n);
    index5(:,k)=1;

    E=En.*index1+Ew.*(ones(n,mn)-index1); %n*mn矩阵,加号前面表示国内的，加号后面是国外的
    H=Hn.*index2+Hw.*(ones(mn,mn)-index2); %H为m*mn的矩�???
    T=Tn.*index3+Tw.*(ones(mn,mn)-index3) ; %mn*mn的矩�???
    D=Dn.*index4+Dw.*(ones(mn,n)-index4) ; %mn*n矩阵
    Q=Qn.*index5+Qw.*(ones(mn,n)-index5); %m*n的矩�???

    L=inv(eye(mn)-(T.*H)); % A0=T0.*H0
    V=E*L; % SI中等�?4的n*mn V矩阵
    V_a=ones(n,mn)*diag(sum(V))-V;%每一行是全球隐含强度去除当地强度 
    Fa=Q.*D; % Fa 每列是地区的�?终需�?
    
    Axx=T.*H; %投入系数矩阵
    X=L*(sum(Q.*D,2)); %总产出mn*1
    Xtemp=zeros(mn,mn);
    for i=1:mn
        Xtemp(i,:)=X';
    end
    Z=Axx.*Xtemp; %中间流动矩阵
    Ztemp=zeros(mn,n);%每个地区中间�?求合并为1�?
    for i=1:n
        Ztemp(:,i)=sum(Z(:,(i-1)*m+1:i*m),2);
    end   
    
    Utool=zeros(mn,n); %构建工具矩阵，把Faa中非可再生能源部门变�??0
    for i=1:n
        Utool((i-1)*163+99:(i-1)*163+106,:)=1;
        Utool((i-1)*163+101,:)=0;
    end
    Eaa=(Fa+Ztemp).*Utool;
    Eaa=sum(V_a'.*Eaa);%每个地区进口隐含金属
    result1(k,:)=Eaa(:,k);
end 
D_W12=result1;
Q_N11=D_W12;

En=E0;
Ew=E0;
Tn=T0;
Tw=T0;
Hn=H0;
Hw=H0;
Dn=D0;
Dw=D0;
Qn=Q0;
Qw=Q1;
 
result1=zeros(n,1);
for k = 1:n
    i = (k-1)*m+1;
    index1 = zeros(n,mn);
    index1(k,:)= 1;
    index2 = zeros(mn,mn);
    index2( :,i:i+m-1)=1;
    index3 = zeros(mn,mn);
    index3(i:i+m-1,:) = 1;
    index3(:,i:i+m-1) = 1;
    index4 = zeros(mn,n);
    index4(i:i+m-1,:)=1;
    index4(:,k)=1;
    index5=zeros(mn,n);
    index5(:,k)=1;

    E=En.*index1+Ew.*(ones(n,mn)-index1); %n*mn矩阵,加号前面表示国内的，加号后面是国外的
    H=Hn.*index2+Hw.*(ones(mn,mn)-index2); %H为m*mn的矩�???
    T=Tn.*index3+Tw.*(ones(mn,mn)-index3) ; %mn*mn的矩�???
    D=Dn.*index4+Dw.*(ones(mn,n)-index4) ; %mn*n矩阵
    Q=Qn.*index5+Qw.*(ones(mn,n)-index5); %m*n的矩�???

    L=inv(eye(mn)-(T.*H)); % A0=T0.*H0
    V=E*L; % SI中等�?4的n*mn V矩阵
    V_a=ones(n,mn)*diag(sum(V))-V;%每一行是全球隐含强度去除当地强度 
    Fa=Q.*D; % Fa 每列是地区的�?终需�?
    
    Axx=T.*H; %投入系数矩阵
    X=L*(sum(Q.*D,2)); %总产出mn*1
    Xtemp=zeros(mn,mn);
    for i=1:mn
        Xtemp(i,:)=X';
    end
    Z=Axx.*Xtemp; %中间流动矩阵
    Ztemp=zeros(mn,n);%每个地区中间�?求合并为1�?
    for i=1:n
        Ztemp(:,i)=sum(Z(:,(i-1)*m+1:i*m),2);
    end   
    
    Utool=zeros(mn,n); %构建工具矩阵，把Faa中非可再生能源部门变�??0
    for i=1:n
        Utool((i-1)*163+99:(i-1)*163+106,:)=1;
        Utool((i-1)*163+101,:)=0;
    end
    Eaa=(Fa+Ztemp).*Utool;
    Eaa=sum(V_a'.*Eaa);%每个地区进口隐含金属
    result1(k,:)=Eaa(:,k);
end 
Q_N12=result1;
Q_W11=Q_N12;
Q_W12=EEE0;


En=E1;
Ew=E0;
Tn=T0;
Tw=T0;
Hn=H0;
Hw=H0;
Dn=D0;
Dw=D0;
Qn=Q0;
Qw=Q0;
 
result1=zeros(n,1);
for k = 1:n
    i = (k-1)*m+1;
    index1 = zeros(n,mn);
    index1(k,:)= 1;
    index2 = zeros(mn,mn);
    index2( :,i:i+m-1)=1;
    index3 = zeros(mn,mn);
    index3(i:i+m-1,:) = 1;
    index3(:,i:i+m-1) = 1;
    index4 = zeros(mn,n);
    index4(i:i+m-1,:)=1;
    index4(:,k)=1;
    index5=zeros(mn,n);
    index5(:,k)=1;

    E=En.*index1+Ew.*(ones(n,mn)-index1); %n*mn矩阵,加号前面表示国内的，加号后面是国外的
    H=Hn.*index2+Hw.*(ones(mn,mn)-index2); %H为m*mn的矩�???
    T=Tn.*index3+Tw.*(ones(mn,mn)-index3) ; %mn*mn的矩�???
    D=Dn.*index4+Dw.*(ones(mn,n)-index4) ; %mn*n矩阵
    Q=Qn.*index5+Qw.*(ones(mn,n)-index5); %m*n的矩�???

    L=inv(eye(mn)-(T.*H)); % A0=T0.*H0
    V=E*L; % SI中等�?4的n*mn V矩阵
    V_a=ones(n,mn)*diag(sum(V))-V;%每一行是全球隐含强度去除当地强度 
    Fa=Q.*D; % Fa 每列是地区的�?终需�?
    
    Axx=T.*H; %投入系数矩阵
    X=L*(sum(Q.*D,2)); %总产出mn*1
    Xtemp=zeros(mn,mn);
    for i=1:mn
        Xtemp(i,:)=X';
    end
    Z=Axx.*Xtemp; %中间流动矩阵
    Ztemp=zeros(mn,n);%每个地区中间�?求合并为1�?
    for i=1:n
        Ztemp(:,i)=sum(Z(:,(i-1)*m+1:i*m),2);
    end   
    
    Utool=zeros(mn,n); %构建工具矩阵，把Faa中非可再生能源部门变�??0
    for i=1:n
        Utool((i-1)*163+99:(i-1)*163+106,:)=1;
        Utool((i-1)*163+101,:)=0;
    end
    Eaa=(Fa+Ztemp).*Utool;
    Eaa=sum(V_a'.*Eaa);%每个地区进口隐含金属
    result1(k,:)=Eaa(:,k);
end 
E_N21=result1;
E_N22=EEE0;

En=E1;
Ew=E1;
Tn=T0;
Tw=T0;
Hn=H0;
Hw=H0;
Dn=D0;
Dw=D0;
Qn=Q0;
Qw=Q0;
 
result1=zeros(n,1);
for k = 1:n
    i = (k-1)*m+1;
    index1 = zeros(n,mn);
    index1(k,:)= 1;
    index2 = zeros(mn,mn);
    index2( :,i:i+m-1)=1;
    index3 = zeros(mn,mn);
    index3(i:i+m-1,:) = 1;
    index3(:,i:i+m-1) = 1;
    index4 = zeros(mn,n);
    index4(i:i+m-1,:)=1;
    index4(:,k)=1;
    index5=zeros(mn,n);
    index5(:,k)=1;

    E=En.*index1+Ew.*(ones(n,mn)-index1); %n*mn矩阵,加号前面表示国内的，加号后面是国外的
    H=Hn.*index2+Hw.*(ones(mn,mn)-index2); %H为m*mn的矩�???
    T=Tn.*index3+Tw.*(ones(mn,mn)-index3) ; %mn*mn的矩�???
    D=Dn.*index4+Dw.*(ones(mn,n)-index4) ; %mn*n矩阵
    Q=Qn.*index5+Qw.*(ones(mn,n)-index5); %m*n的矩�???

    L=inv(eye(mn)-(T.*H)); % A0=T0.*H0
    V=E*L; % SI中等�?4的n*mn V矩阵
    V_a=ones(n,mn)*diag(sum(V))-V;%每一行是全球隐含强度去除当地强度 
    Fa=Q.*D; % Fa 每列是地区的�?终需�?
    
    Axx=T.*H; %投入系数矩阵
    X=L*(sum(Q.*D,2)); %总产出mn*1
    Xtemp=zeros(mn,mn);
    for i=1:mn
        Xtemp(i,:)=X';
    end
    Z=Axx.*Xtemp; %中间流动矩阵
    Ztemp=zeros(mn,n);%每个地区中间�?求合并为1�?
    for i=1:n
        Ztemp(:,i)=sum(Z(:,(i-1)*m+1:i*m),2);
    end   
    
    Utool=zeros(mn,n); %构建工具矩阵，把Faa中非可再生能源部门变�??0
    for i=1:n
        Utool((i-1)*163+99:(i-1)*163+106,:)=1;
        Utool((i-1)*163+101,:)=0;
    end
    Eaa=(Fa+Ztemp).*Utool;
    Eaa=sum(V_a'.*Eaa);%每个地区进口隐含金属
    result1(k,:)=Eaa(:,k);
end 
E_W21=result1;
E_W22=E_N21;

En=E1;
Ew=E1;
Tn=T1;
Tw=T0;
Hn=H0;
Hw=H0;
Dn=D0;
Dw=D0;
Qn=Q0;
Qw=Q0;
 
result1=zeros(n,1);
for k = 1:n
    i = (k-1)*m+1;
    index1 = zeros(n,mn);
    index1(k,:)= 1;
    index2 = zeros(mn,mn);
    index2( :,i:i+m-1)=1;
    index3 = zeros(mn,mn);
    index3(i:i+m-1,:) = 1;
    index3(:,i:i+m-1) = 1;
    index4 = zeros(mn,n);
    index4(i:i+m-1,:)=1;
    index4(:,k)=1;
    index5=zeros(mn,n);
    index5(:,k)=1;

    E=En.*index1+Ew.*(ones(n,mn)-index1); %n*mn矩阵,加号前面表示国内的，加号后面是国外的
    H=Hn.*index2+Hw.*(ones(mn,mn)-index2); %H为m*mn的矩�???
    T=Tn.*index3+Tw.*(ones(mn,mn)-index3) ; %mn*mn的矩�???
    D=Dn.*index4+Dw.*(ones(mn,n)-index4) ; %mn*n矩阵
    Q=Qn.*index5+Qw.*(ones(mn,n)-index5); %m*n的矩�???

    L=inv(eye(mn)-(T.*H)); % A0=T0.*H0
    V=E*L; % SI中等�?4的n*mn V矩阵
    V_a=ones(n,mn)*diag(sum(V))-V;%每一行是全球隐含强度去除当地强度 
    Fa=Q.*D; % Fa 每列是地区的�?终需�?
    
    Axx=T.*H; %投入系数矩阵
    X=L*(sum(Q.*D,2)); %总产出mn*1
    Xtemp=zeros(mn,mn);
    for i=1:mn
        Xtemp(i,:)=X';
    end
    Z=Axx.*Xtemp; %中间流动矩阵
    Ztemp=zeros(mn,n);%每个地区中间�?求合并为1�?
    for i=1:n
        Ztemp(:,i)=sum(Z(:,(i-1)*m+1:i*m),2);
    end   
    
    Utool=zeros(mn,n); %构建工具矩阵，把Faa中非可再生能源部门变�??0
    for i=1:n
        Utool((i-1)*163+99:(i-1)*163+106,:)=1;
        Utool((i-1)*163+101,:)=0;
    end
    Eaa=(Fa+Ztemp).*Utool;
    Eaa=sum(V_a'.*Eaa);%每个地区进口隐含金属
    result1(k,:)=Eaa(:,k);
end 
T_N21=result1;
T_N22=E_W21;

En=E1;
Ew=E1;
Tn=T1;
Tw=T1;
Hn=H0;
Hw=H0;
Dn=D0;
Dw=D0;
Qn=Q0;
Qw=Q0;
 
result1=zeros(n,1);
for k = 1:n
    i = (k-1)*m+1;
    index1 = zeros(n,mn);
    index1(k,:)= 1;
    index2 = zeros(mn,mn);
    index2( :,i:i+m-1)=1;
    index3 = zeros(mn,mn);
    index3(i:i+m-1,:) = 1;
    index3(:,i:i+m-1) = 1;
    index4 = zeros(mn,n);
    index4(i:i+m-1,:)=1;
    index4(:,k)=1;
    index5=zeros(mn,n);
    index5(:,k)=1;

    E=En.*index1+Ew.*(ones(n,mn)-index1); %n*mn矩阵,加号前面表示国内的，加号后面是国外的
    H=Hn.*index2+Hw.*(ones(mn,mn)-index2); %H为m*mn的矩�???
    T=Tn.*index3+Tw.*(ones(mn,mn)-index3) ; %mn*mn的矩�???
    D=Dn.*index4+Dw.*(ones(mn,n)-index4) ; %mn*n矩阵
    Q=Qn.*index5+Qw.*(ones(mn,n)-index5); %m*n的矩�???

    L=inv(eye(mn)-(T.*H)); % A0=T0.*H0
    V=E*L; % SI中等�?4的n*mn V矩阵
    V_a=ones(n,mn)*diag(sum(V))-V;%每一行是全球隐含强度去除当地强度 
    Fa=Q.*D; % Fa 每列是地区的�?终需�?
    
    Axx=T.*H; %投入系数矩阵
    X=L*(sum(Q.*D,2)); %总产出mn*1
    Xtemp=zeros(mn,mn);
    for i=1:mn
        Xtemp(i,:)=X';
    end
    Z=Axx.*Xtemp; %中间流动矩阵
    Ztemp=zeros(mn,n);%每个地区中间�?求合并为1�?
    for i=1:n
        Ztemp(:,i)=sum(Z(:,(i-1)*m+1:i*m),2);
    end   
    
    Utool=zeros(mn,n); %构建工具矩阵，把Faa中非可再生能源部门变�??0
    for i=1:n
        Utool((i-1)*163+99:(i-1)*163+106,:)=1;
        Utool((i-1)*163+101,:)=0;
    end
    Eaa=(Fa+Ztemp).*Utool;
    Eaa=sum(V_a'.*Eaa);%每个地区进口隐含金属
    result1(k,:)=Eaa(:,k);
end 
T_W21=result1;
T_W22=T_N21;


En=E1;
Ew=E1;
Tn=T1;
Tw=T1;
Hn=H1;
Hw=H0;
Dn=D0;
Dw=D0;
Qn=Q0;
Qw=Q0;
 
result1=zeros(n,1);
for k = 1:n
    i = (k-1)*m+1;
    index1 = zeros(n,mn);
    index1(k,:)= 1;
    index2 = zeros(mn,mn);
    index2( :,i:i+m-1)=1;
    index3 = zeros(mn,mn);
    index3(i:i+m-1,:) = 1;
    index3(:,i:i+m-1) = 1;
    index4 = zeros(mn,n);
    index4(i:i+m-1,:)=1;
    index4(:,k)=1;
    index5=zeros(mn,n);
    index5(:,k)=1;

    E=En.*index1+Ew.*(ones(n,mn)-index1); %n*mn矩阵,加号前面表示国内的，加号后面是国外的
    H=Hn.*index2+Hw.*(ones(mn,mn)-index2); %H为m*mn的矩�???
    T=Tn.*index3+Tw.*(ones(mn,mn)-index3) ; %mn*mn的矩�???
    D=Dn.*index4+Dw.*(ones(mn,n)-index4) ; %mn*n矩阵
    Q=Qn.*index5+Qw.*(ones(mn,n)-index5); %m*n的矩�???

    L=inv(eye(mn)-(T.*H)); % A0=T0.*H0
    V=E*L; % SI中等�?4的n*mn V矩阵
    V_a=ones(n,mn)*diag(sum(V))-V;%每一行是全球隐含强度去除当地强度 
    Fa=Q.*D; % Fa 每列是地区的�?终需�?
    
    Axx=T.*H; %投入系数矩阵
    X=L*(sum(Q.*D,2)); %总产出mn*1
    Xtemp=zeros(mn,mn);
    for i=1:mn
        Xtemp(i,:)=X';
    end
    Z=Axx.*Xtemp; %中间流动矩阵
    Ztemp=zeros(mn,n);%每个地区中间�?求合并为1�?
    for i=1:n
        Ztemp(:,i)=sum(Z(:,(i-1)*m+1:i*m),2);
    end   
    
    Utool=zeros(mn,n); %构建工具矩阵，把Faa中非可再生能源部门变�??0
    for i=1:n
        Utool((i-1)*163+99:(i-1)*163+106,:)=1;
        Utool((i-1)*163+101,:)=0;
    end
    Eaa=(Fa+Ztemp).*Utool;
    Eaa=sum(V_a'.*Eaa);%每个地区进口隐含金属
    result1(k,:)=Eaa(:,k);
end 
H_N21=result1;
H_N22=T_W21;

En=E1;
Ew=E1;
Tn=T1;
Tw=T1;
Hn=H1;
Hw=H1;
Dn=D0;
Dw=D0;
Qn=Q0;
Qw=Q0;
 
result1=zeros(n,1);
for k = 1:n
    i = (k-1)*m+1;
    index1 = zeros(n,mn);
    index1(k,:)= 1;
    index2 = zeros(mn,mn);
    index2( :,i:i+m-1)=1;
    index3 = zeros(mn,mn);
    index3(i:i+m-1,:) = 1;
    index3(:,i:i+m-1) = 1;
    index4 = zeros(mn,n);
    index4(i:i+m-1,:)=1;
    index4(:,k)=1;
    index5=zeros(mn,n);
    index5(:,k)=1;

    E=En.*index1+Ew.*(ones(n,mn)-index1); %n*mn矩阵,加号前面表示国内的，加号后面是国外的
    H=Hn.*index2+Hw.*(ones(mn,mn)-index2); %H为m*mn的矩�???
    T=Tn.*index3+Tw.*(ones(mn,mn)-index3) ; %mn*mn的矩�???
    D=Dn.*index4+Dw.*(ones(mn,n)-index4) ; %mn*n矩阵
    Q=Qn.*index5+Qw.*(ones(mn,n)-index5); %m*n的矩�???

    L=inv(eye(mn)-(T.*H)); % A0=T0.*H0
    V=E*L; % SI中等�?4的n*mn V矩阵
    V_a=ones(n,mn)*diag(sum(V))-V;%每一行是全球隐含强度去除当地强度 
    Fa=Q.*D; % Fa 每列是地区的�?终需�?
    
    Axx=T.*H; %投入系数矩阵
    X=L*(sum(Q.*D,2)); %总产出mn*1
    Xtemp=zeros(mn,mn);
    for i=1:mn
        Xtemp(i,:)=X';
    end
    Z=Axx.*Xtemp; %中间流动矩阵
    Ztemp=zeros(mn,n);%每个地区中间�?求合并为1�?
    for i=1:n
        Ztemp(:,i)=sum(Z(:,(i-1)*m+1:i*m),2);
    end   
    
    Utool=zeros(mn,n); %构建工具矩阵，把Faa中非可再生能源部门变�??0
    for i=1:n
        Utool((i-1)*163+99:(i-1)*163+106,:)=1;
        Utool((i-1)*163+101,:)=0;
    end
    Eaa=(Fa+Ztemp).*Utool;
    Eaa=sum(V_a'.*Eaa);%每个地区进口隐含金属
    result1(k,:)=Eaa(:,k);
end 
H_W21 =result1;
H_W22=H_N21;

En=E1;
Ew=E1;
Tn=T1;
Tw=T1;
Hn=H1;
Hw=H1;
Dn=D1;
Dw=D0;
Qn=Q0;
Qw=Q0;
 
result1=zeros(n,1);
for k = 1:n
    i = (k-1)*m+1;
    index1 = zeros(n,mn);
    index1(k,:)= 1;
    index2 = zeros(mn,mn);
    index2( :,i:i+m-1)=1;
    index3 = zeros(mn,mn);
    index3(i:i+m-1,:) = 1;
    index3(:,i:i+m-1) = 1;
    index4 = zeros(mn,n);
    index4(i:i+m-1,:)=1;
    index4(:,k)=1;
    index5=zeros(mn,n);
    index5(:,k)=1;

    E=En.*index1+Ew.*(ones(n,mn)-index1); %n*mn矩阵,加号前面表示国内的，加号后面是国外的
    H=Hn.*index2+Hw.*(ones(mn,mn)-index2); %H为m*mn的矩�???
    T=Tn.*index3+Tw.*(ones(mn,mn)-index3) ; %mn*mn的矩�???
    D=Dn.*index4+Dw.*(ones(mn,n)-index4) ; %mn*n矩阵
    Q=Qn.*index5+Qw.*(ones(mn,n)-index5); %m*n的矩�???

    L=inv(eye(mn)-(T.*H)); % A0=T0.*H0
    V=E*L; % SI中等�?4的n*mn V矩阵
    V_a=ones(n,mn)*diag(sum(V))-V;%每一行是全球隐含强度去除当地强度 
    Fa=Q.*D; % Fa 每列是地区的�?终需�?
    
    Axx=T.*H; %投入系数矩阵
    X=L*(sum(Q.*D,2)); %总产出mn*1
    Xtemp=zeros(mn,mn);
    for i=1:mn
        Xtemp(i,:)=X';
    end
    Z=Axx.*Xtemp; %中间流动矩阵
    Ztemp=zeros(mn,n);%每个地区中间�?求合并为1�?
    for i=1:n
        Ztemp(:,i)=sum(Z(:,(i-1)*m+1:i*m),2);
    end   
    
    Utool=zeros(mn,n); %构建工具矩阵，把Faa中非可再生能源部门变�??0
    for i=1:n
        Utool((i-1)*163+99:(i-1)*163+106,:)=1;
        Utool((i-1)*163+101,:)=0;
    end
    Eaa=(Fa+Ztemp).*Utool;
    Eaa=sum(V_a'.*Eaa);%每个地区进口隐含金属
    result1(k,:)=Eaa(:,k);
end 
D_N21=result1;
D_N22 =H_W21;

En=E1;
Ew=E1;
Tn=T1;
Tw=T1;
Hn=H1;
Hw=H1;
Dn=D1;
Dw=D1;
Qn=Q0;
Qw=Q0;
 
result1=zeros(n,1);
for k = 1:n
    i = (k-1)*m+1;
    index1 = zeros(n,mn);
    index1(k,:)= 1;
    index2 = zeros(mn,mn);
    index2( :,i:i+m-1)=1;
    index3 = zeros(mn,mn);
    index3(i:i+m-1,:) = 1;
    index3(:,i:i+m-1) = 1;
    index4 = zeros(mn,n);
    index4(i:i+m-1,:)=1;
    index4(:,k)=1;
    index5=zeros(mn,n);
    index5(:,k)=1;

    E=En.*index1+Ew.*(ones(n,mn)-index1); %n*mn矩阵,加号前面表示国内的，加号后面是国外的
    H=Hn.*index2+Hw.*(ones(mn,mn)-index2); %H为m*mn的矩�???
    T=Tn.*index3+Tw.*(ones(mn,mn)-index3) ; %mn*mn的矩�???
    D=Dn.*index4+Dw.*(ones(mn,n)-index4) ; %mn*n矩阵
    Q=Qn.*index5+Qw.*(ones(mn,n)-index5); %m*n的矩�???

    L=inv(eye(mn)-(T.*H)); % A0=T0.*H0
    V=E*L; % SI中等�?4的n*mn V矩阵
    V_a=ones(n,mn)*diag(sum(V))-V;%每一行是全球隐含强度去除当地强度 
    Fa=Q.*D; % Fa 每列是地区的�?终需�?
    
    Axx=T.*H; %投入系数矩阵
    X=L*(sum(Q.*D,2)); %总产出mn*1
    Xtemp=zeros(mn,mn);
    for i=1:mn
        Xtemp(i,:)=X';
    end
    Z=Axx.*Xtemp; %中间流动矩阵
    Ztemp=zeros(mn,n);%每个地区中间�?求合并为1�?
    for i=1:n
        Ztemp(:,i)=sum(Z(:,(i-1)*m+1:i*m),2);
    end   
    
    Utool=zeros(mn,n); %构建工具矩阵，把Faa中非可再生能源部门变�??0
    for i=1:n
        Utool((i-1)*163+99:(i-1)*163+106,:)=1;
        Utool((i-1)*163+101,:)=0;
    end
    Eaa=(Fa+Ztemp).*Utool;
    Eaa=sum(V_a'.*Eaa);%每个地区进口隐含金属
    result1(k,:)=Eaa(:,k);
end 
D_W21=result1;
D_W22=D_N21;



En=E1;
Ew=E1;
Tn=T1;
Tw=T1;
Hn=H1;
Hw=H1;
Dn=D1;
Dw=D1;
Qn=Q1;
Qw=Q0;
 
result1=zeros(n,1);
for k = 1:n
    i = (k-1)*m+1;
    index1 = zeros(n,mn);
    index1(k,:)= 1;
    index2 = zeros(mn,mn);
    index2( :,i:i+m-1)=1;
    index3 = zeros(mn,mn);
    index3(i:i+m-1,:) = 1;
    index3(:,i:i+m-1) = 1;
    index4 = zeros(mn,n);
    index4(i:i+m-1,:)=1;
    index4(:,k)=1;
    index5=zeros(mn,n);
    index5(:,k)=1;

    E=En.*index1+Ew.*(ones(n,mn)-index1); %n*mn矩阵,加号前面表示国内的，加号后面是国外的
    H=Hn.*index2+Hw.*(ones(mn,mn)-index2); %H为m*mn的矩�???
    T=Tn.*index3+Tw.*(ones(mn,mn)-index3) ; %mn*mn的矩�???
    D=Dn.*index4+Dw.*(ones(mn,n)-index4) ; %mn*n矩阵
    Q=Qn.*index5+Qw.*(ones(mn,n)-index5); %m*n的矩�???

    L=inv(eye(mn)-(T.*H)); % A0=T0.*H0
    V=E*L; % SI中等�?4的n*mn V矩阵
    V_a=ones(n,mn)*diag(sum(V))-V;%每一行是全球隐含强度去除当地强度 
    Fa=Q.*D; % Fa 每列是地区的�?终需�?
    
    Axx=T.*H; %投入系数矩阵
    X=L*(sum(Q.*D,2)); %总产出mn*1
    Xtemp=zeros(mn,mn);
    for i=1:mn
        Xtemp(i,:)=X';
    end
    Z=Axx.*Xtemp; %中间流动矩阵
    Ztemp=zeros(mn,n);%每个地区中间�?求合并为1�?
    for i=1:n
        Ztemp(:,i)=sum(Z(:,(i-1)*m+1:i*m),2);
    end   
    
    Utool=zeros(mn,n); %构建工具矩阵，把Faa中非可再生能源部门变�??0
    for i=1:n
        Utool((i-1)*163+99:(i-1)*163+106,:)=1;
        Utool((i-1)*163+101,:)=0;
    end
    Eaa=(Fa+Ztemp).*Utool;
    Eaa=sum(V_a'.*Eaa);%每个地区进口隐含金属
    result1(k,:)=Eaa(:,k);
end 
Q_N21 =result1;
Q_N22=D_W21;
Q_W21=EEE1;
Q_W22=Q_N21;


E_N1=E_N11./E_N12; 
E_N2=E_N21./E_N22;
E_W1=E_W11./E_W12;
E_W2=E_W21./E_W22;
 
T_N1= T_N11./T_N12;
T_N2= T_N21./T_N22;
T_W1=T_W11./T_W12;
T_W2=T_W21./T_W22;
 
H_N1=H_N11./H_N12;
H_N2=H_N21./H_N22;
H_W1=H_W11./H_W12;
H_W2=H_W21./H_W22;
 
D_N1=D_N11./D_N12;
D_N2=D_N21./D_N22;
D_W1=D_W11./D_W12;
D_W2=D_W21./D_W22;
 
Q_N1=Q_N11./Q_N12;
Q_N2=Q_N21./Q_N22;
Q_W1=Q_W11./Q_W12;
Q_W2=Q_W21./Q_W22;

E_N=sqrt(E_N1.*E_N2);
E_W=sqrt(E_W1.*E_W2);
T_N=sqrt(T_N1.*T_N2);
T_W=sqrt(T_W1.*T_W2);
H_N=sqrt(H_N1.*H_N2);
H_W=sqrt(H_W1.*H_W2);
D_N=sqrt(D_N1.*D_N2);
D_W=sqrt(D_W1.*D_W2);
Q_N=sqrt(Q_N1.*Q_N2);
Q_W=sqrt(Q_W1.*Q_W2);

B=E_N.*E_W.* T_N.*T_W.*H_N.*H_W.*D_N.*D_W.*Q_N.*Q_W;


xlswrite("IMPORT_SDA.xlsx",E_N,'EN');
xlswrite("IMPORT_SDA.xlsx",E_W,'EW');
xlswrite("IMPORT_SDA.xlsx",T_N,'TN');
xlswrite("IMPORT_SDA.xlsx",T_W,'TW');
xlswrite("IMPORT_SDA.xlsx",H_N,'HN');
xlswrite("IMPORT_SDA.xlsx",H_W,'HW');
xlswrite("IMPORT_SDA.xlsx",D_N,'DN');
xlswrite("IMPORT_SDA.xlsx",D_W,'DW');
xlswrite("IMPORT_SDA.xlsx",Q_N,'QN');
xlswrite("IMPORT_SDA.xlsx",Q_W,'QW');

xlswrite("IMPORT_SDA.xlsx",B,'B');

xlswrite("IMPORT_SDA.xlsx",EEE0,'2010_import');
xlswrite("IMPORT_SDA.xlsx",EEE1,'2015_import');




% results=zeros(49,1,13);
% results(:,:,1)=E_N;
% results(:,:,2)=E_W;
% results(:,:,3)=T_N;
% results(:,:,4)=T_W;
% results(:,:,5)=H_N;
% results(:,:,6)=H_W;
% results(:,:,7)=D_N;
% results(:,:,8)=D_W;
% results(:,:,9)=Q_N;
% results(:,:,10)=Q_W;
% results(:,:,11)=B;
% results(:,:,12)=EEE0;
% results(:,:,13)=EEE1;

% save("2010-2015_IMPORT.mat",'results');
