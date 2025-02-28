%% import dataset
clear;
G=77; % number of countries
S=41;
N=82; % WE SHOULD USE 2 WHEN WE HAVE 1 SECTOR
z = xlsread('E:\AMNE\mne_2023 VERSION\AAMNE_ICIO2010\AAMNE_ICIO2010.csv','AAMNE_ICIO2010',"B2:IHW6315");
FD2 = xlsread('E:\AMNE\mne_2023 VERSION\AAMNE_ICIO2010\AAMNE_ICIO2010.csv','AAMNE_ICIO2010',"IHX2:IZQ6315");
X = xlsread('E:\AMNE\mne_2023 VERSION\AAMNE_ICIO2010\AAMNE_ICIO2010.csv','AAMNE_ICIO2010',"B6318:IHW6318");
VaD = xlsread('E:\AMNE\mne_2023 VERSION\AAMNE_ICIO2010\AAMNE_ICIO2010.csv','AAMNE_ICIO2010',"B6316:IHW6316");
%%
A=z./X;
A(isnan(A))=0;
A(isinf(A))=0;
V=VaD./X;
V(isnan(V))=0;
V(isinf(V))=0;
V_D=zeros(1,G*N);
    for i=1:G*S
        V_D(2*i-1)=V(2*i-1);
    end
V_F=zeros(1,G*N);
    for i=1:G*S
        V_F(2*i)=V(2*i);
    end
%% For Y
for i=1:G*S*2
    for j=1:G*6
        FD (i,j)= FD2(i,j);  %GO_P.Y2001 just for the year 2001, you should change when needed,such as GO_P.Y2002
    end
end
Y=[]  ;
for i=1:G
    GG=FD([1:S*G*2],[6*i-5:6*i]);
    C=sum(GG')';
    Y=[Y C];
end
Y;


Y_dia = diag(sum(Y,2));
Y_temp = sum(Y_dia,2);

% Y_D
Y_D=zeros(G*S*2,1);
    for i=1:G*S
        Y_D(2*i-1,1)=Y_temp(2*i-1,1);
    end
    
%  Y_LD=Y_D;

 % Y_F
Y_F=zeros(G*S*2,1);
    for i=1:G*S
        Y_F(2*i,1)=Y_temp(2*i,1);
    end
    
Y_LF=Y_F;
  
% Y_L
   start_id=1;
   end_id=N;
   for i=1:G
    Y_L(start_id:end_id,i)=Y(start_id:end_id,i);
    start_id=end_id+1;
    end_id=end_id+N;
   end
   
   % Y_e
   Y_E=Y-Y_L;
   
      % Y_DE
   Y_E_S=sum(Y_E,2);
%    Y_DE2= Y_D-Y_LD;
   Y_DE=zeros(G*S*2,1);
    for i=1:S
        Y_DE(2*i-1,1)=Y_E_S(2*i-1,1);
    end
   
      % Y_FE
%       Y_FE2=Y_F-Y_LF;
Y_FE=zeros(G*S*2,1);
    for i=1:S
        Y_FE(2*i,1)=Y_E_S(2*i,1);
    end
    % Y_DE
   Y_L_S=sum(Y_L,2);
     Y_LD=zeros(G*S*2,1);
    for i=1:S
        Y_LD(2*i-1,1)=Y_L_S(2*i-1,1);
    end
   
      % Y_FE
Y_LF=zeros(G*S*2,1);
    for i=1:S
        Y_LF(2*i,1)=Y_L_S(2*i,1);
    end
     
   
%% BLOCK A
A=z./X;
A(isnan(A))=0;
A(isinf(A))=0;
A_subMatrices = cell(S,S);
for i = 1:G
    for j = 1:G
        A_subMatrix = A((N*(i-1)+1):(N*i), (N*(j-1)+1):(N*j));
        A_subMatrices {i,j} = A_subMatrix;
    end
end

A_L=zeros(S*N);
start_id=1;
end_id=N;
for i=1:G
A_L(start_id:end_id,start_id:end_id)=A_subMatrices{i,i};
    start_id=end_id+1;
    end_id=end_id+N;
end
A_E=A-A_L;

I1=eye(N); 
L=cell(1,G);   %S个国家（区域）的局部逆矩阵。一个很好的矩阵。
for i=1:1:G
L{i,i}=I1/(I1-A_subMatrices{i,i});
end                 
LM=zeros(S*N);
start_id=1;
end_id=N;
for i=1:G
LM(start_id:end_id,start_id:end_id)=L{i,i};
    start_id=end_id+1;
    end_id=end_id+N;
end

%% Equation 6
B=inv(eye(G*N,G*N)-A);
Term.total=diag(V)*B*diag(Y_temp);
Term.T1=diag(V_D)*LM*diag(Y_LD); % value-added created by DOEs used by their final production to satisfy domestic final demand
% GVC activities
Term.T2=diag(V_D)*LM*diag(Y_DE); %  value-added created by DOEs but embedded in the final goods exports to satisfy the final demand abroad
% FDI related activities
Term.T3=diag(V_D)*LM*A_E*B*diag(Y_D);  %% double check this  value-added embodied in intermediate exports that are produced by DOEs in the host country, but is  used by the direct importing country to produce final products either for domestic final demand (simple GVC activities) or for exports to third countries.
Term.T4=diag(V_D)*LM*diag(Y_LF); % value added originally created by DOEs in the host country but used by FIEs in the final production to satisfy final demand in domestic (host country) and foreign markets respectively.
Term.T5=diag(V_D)*LM*diag(Y_FE); % value added originally created by DOEs in the host country but used by FIEs in the final production to satisfy final demand in domestic (host country) and foreign markets respectively.
Term.T6=diag(V_F)*LM*diag(Y_LD); % value added generated by the FIEs in a host country but used in the final production of host-country DOEs to satisfy final demand in the domestic and global markets, respectively.
Term.T7=diag(V_F)*LM*diag(Y_DE); % value added generated by the FIEs in a host country but used in the final production of host-country DOEs to satisfy final demand in the domestic and global markets, respectively.
Term.T8=diag(V_F)*LM*diag(Y_LF); % value added created by one set of FIEs in a host country but is used by potentially a different set of FIEs in their final goods and service production to satisfy final demand in either domestic or foreign markets.
Term.T9=diag(V_F)*LM*diag(Y_FE); % value added created by one set of FIEs in a host country but is used by potentially a different set of FIEs in their final goods and service production to satisfy final demand in either domestic or foreign markets.
% Trade and FDI
Term.T10=diag(V_D)*LM*A_E*B*diag(Y_F); % value-added created by DOEs embodied in their intermediate exports that are used by FIEs in the direct importing countries to produce final goods and services that are either consumed domestically (in the direct importing country) or exported to other countries.
Term.T11=diag(V_F)*LM*A_E*B*diag(Y_D); % value-added embedded in the exports of intermediate inputs that is created by the FIEs in the host country and used by the DOEs in the direct importing country in final production  for both local and global markets. 
Term.T12=diag(V_F)*LM*A_E*B*diag(Y_F); % value added embedded in the exports of intermediate inputs that is created by the FIEs in the first country and used by the FIEs in the second country (the direct importing country) for final production  that are either consumed locally (in the direct importing country) or exported to other countries. 

Term.check=Term.T1+Term.T2+Term.T3+Term.T4+Term.T5+Term.T6+Term.T7+Term.T8+Term.T9+Term.T10+Term.T11+Term.T12;
Term.check-Term.total




