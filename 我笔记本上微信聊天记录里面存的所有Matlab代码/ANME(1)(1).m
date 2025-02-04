%% import dataset
clear;
G=6; % number of countries
S=3;
N=2; % WE SHOULD USE 2 WHEN WE HAVE 1 SECTOR
z = xlsread('E:\ANME\ANME.xlsx','Sheet1',"C4:H9");
Y = xlsread('E:\ANME\ANME.xlsx','Sheet1',"J4:L9");
X = xlsread('E:\ANME\ANME.xlsx','Sheet1',"C14:H14");
VaD = xlsread('E:\ANME\ANME.xlsx','Sheet1',"C13:H13");
%%
A=z./X;
A(isnan(A))=0;
A(isinf(A))=0;
V=VaD./X;
V(isnan(V))=0;
V(isinf(V))=0;
V_D=zeros(1,G);
    for i=1:G/2
        V_D(2*i-1)=V(2*i-1);
    end
V_F=zeros(1,G);
    for i=1:G/2
        V_F(2*i)=V(2*i);
    end
%% For Y
Y_dia = diag(sum(Y,2));
Y_temp = sum(Y_dia,2);

% Y_D
Y_D=zeros(G,1);
    for i=1:G/2
        Y_D(2*i-1,1)=Y_temp(2*i-1,1);
    end
    
%  Y_LD=Y_D;

 % Y_F
Y_F=zeros(G,1);
    for i=1:S
        Y_F(2*i,1)=Y_temp(2*i,1);
    end
    
Y_LF=Y_F;
  
% Y_L
   start_id=1;
   end_id=N;
   for i=1:S
    Y_L(start_id:end_id,i)=Y(start_id:end_id,i);
    start_id=end_id+1;
    end_id=end_id+N;
   end
   
   % Y_e
   Y_E=Y-Y_L;
   
      % Y_DE
   Y_E_S=sum(Y_E,2);
%    Y_DE2= Y_D-Y_LD;
   Y_DE=zeros(G,1);
    for i=1:S
        Y_DE(2*i-1,1)=Y_E_S(2*i-1,1);
    end
   
      % Y_FE
%       Y_FE2=Y_F-Y_LF;
Y_FE=zeros(G,1);
    for i=1:S
        Y_FE(2*i,1)=Y_E_S(2*i,1);
    end
    % Y_DE
   Y_L_S=sum(Y_L,2);
     Y_LD=zeros(G,1);
    for i=1:S
        Y_LD(2*i-1,1)=Y_L_S(2*i-1,1);
    end
   
      % Y_FE
Y_LF=zeros(G,1);
    for i=1:S
        Y_LF(2*i,1)=Y_L_S(2*i,1);
    end
     
   
%% BLOCK A
A_subMatrices = cell(S,S);
for i = 1:S
    for j = 1:S
        A_subMatrix = A((N*(i-1)+1):(N*i), (N*(j-1)+1):(N*j));
        A_subMatrices {i,j} = A_subMatrix;
    end
end

A_L=zeros(S*N);
start_id=1;
end_id=N;
for i=1:S
A_L(start_id:end_id,start_id:end_id)=A_subMatrices{i,i};
    start_id=end_id+1;
    end_id=end_id+N;
end
A_E=A-A_L;

I1=eye(N); 
L=cell(1,S);   %S个国家（区域）的局部逆矩阵。一个很好的矩阵。
for i=1:1:S
L{i,i}=I1/(I1-A_subMatrices{i,i});
end                 
LM=zeros(S*N);
start_id=1;
end_id=N;
for i=1:S
LM(start_id:end_id,start_id:end_id)=L{i,i};
    start_id=end_id+1;
    end_id=end_id+N;
end

%% Equation 6
B=inv(eye(G,G)-A);
Term.total=diag(V)*B*diag(Y_temp);
Term.T1=diag(V_D)*LM*diag(Y_LD);
% GVC activities
Term.T2=diag(V_D)*LM*diag(Y_DE);
% FDI related activities
Term.T3=diag(V_D)*LM*A_E*B*diag(Y_D);  %% double check this 
Term.T4=diag(V_D)*LM*diag(Y_LF);
Term.T5=diag(V_D)*LM*diag(Y_FE);
Term.T6=diag(V_F)*LM*diag(Y_LD);
Term.T7=diag(V_F)*LM*diag(Y_DE);
Term.T8=diag(V_F)*LM*diag(Y_LF);
Term.T9=diag(V_F)*LM*diag(Y_FE);
% Trade and FDI
Term.T10=diag(V_D)*LM*A_E*B*diag(Y_F);
Term.T11=diag(V_F)*LM*A_E*B*diag(Y_D);
Term.T12=diag(V_F)*LM*A_E*B*diag(Y_F);

Term.check=Term.T1+Term.T2+Term.T3+Term.T4+Term.T5+Term.T6+Term.T7+Term.T8+Term.T9+Term.T10+Term.T11+Term.T12;
Term.check-Term.total




