
%% Parameters Setup
clear;
G = 77; % number of countries
S = 41; % sector size
N = S*2; % block size (rows)

%z = xlsread('E:\AMNE\mne_2023 VERSION\AAMNE_ICIO2010\AAMNE_ICIO2010.csv','AAMNE_ICIO2010',"B2:IHW6315");
z = readmatrix('E:\AMNE\mne_2023 VERSION\AAMNE_ICIO2010\AAMNE_ICIO2010.csv', 'Range', 'B2:IHW6315');
FD2 = readmatrix('E:\AMNE\mne_2023 VERSION\AAMNE_ICIO2010\AAMNE_ICIO2010.csv', 'Range',"IHX2:IZQ6315");
X = readmatrix('E:\AMNE\mne_2023 VERSION\AAMNE_ICIO2010\AAMNE_ICIO2010.csv', 'Range',"B6318:IHW6318");
VaD = readmatrix('E:\AMNE\mne_2023 VERSION\AAMNE_ICIO2010\AAMNE_ICIO2010.csv', 'Range',"B6316:IHW6316");

% FD2 = xlsread('E:\AMNE\mne_2023 VERSION\AAMNE_ICIO2010\AAMNE_ICIO2010.csv','AAMNE_ICIO2010',"IHX2:IZQ6315");
% X = xlsread('E:\AMNE\mne_2023 VERSION\AAMNE_ICIO2010\AAMNE_ICIO2010.csv','AAMNE_ICIO2010',"B6318:IHW6318");
% VaD = xlsread('E:\AMNE\mne_2023 VERSION\AAMNE_ICIO2010\AAMNE_ICIO2010.csv','AAMNE_ICIO2010',"B6316:IHW6316");



%%
A=z./X;
A(isnan(A))=0;
A(isinf(A))=0;
V=VaD./X;
V(isnan(V))=0;
V(isinf(V))=0;

%%
%Value-added coefficients: Domestic
V_D=zeros(1,G*N);
    for i=1:G*S
        V_D(2*i-1)=V(2*i-1);
    end
%Value-added coefficients: foreign
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

% Assuming Y is a 6314x1 vector
% Number of countries and sectors
num_countries = 77;
num_sectors = 41;

% Initialize Y_D and Y_F as zero vectors
Y_D = zeros(size(Y));
Y_F = zeros(size(Y));
V_D=zeros(size(V));
% Loop through each country
for country = 1:num_countries
    % Calculate the start and end indices for this country's data
    start_idx = (country - 1) * 2 * num_sectors + 1;
    end_idx = start_idx + num_sectors - 1;

    % Assign Y_D values for domestic firms
    Y_D(start_idx:end_idx) = Y_temp(start_idx:end_idx);
    V_D(start_idx:end_idx) = V(start_idx:end_idx);
    % Assign Y_F values for foreign firms as zero (already initialized as zero)
end
%equation 2 direct value-added coefficient vectors of DOEs and FIEs,
Y_D=sum(Y_D,2);  %  final production outputs of DOEs in various industries,
Y_F=Y_temp-Y_D;  % final production outputs of  FIEs in various industries within each country respectively
V_F=V-V_D; %direct value-added coefficient vectors of DOEs and FIEs,

% Y_F already initialized as zero




%%
%Y_L(D) and Y_L(F)::
%final production of DOEs and FIEs in various 
% industries that satisfies host country’s domestic final demand respectively
Y_diag = zeros(size(Y));

% Size of diagonal blocks
block_size = 82;

% Loop through each column
for col = 1:size(Y, 2)
    % Calculate the start and end indices for the current block
    start_idx = (col - 1) * block_size + 1;
    end_idx = col * block_size;
    
    % Check to avoid indexing out of bounds
    if end_idx <= size(Y, 1)
        % Extract the diagonal block and assign to the corresponding column
        Y_diag(start_idx:end_idx, col) = Y(start_idx:end_idx, col);
    end
end

Y_diag_sum=sum(Y_diag,2);
%Y_L(D) and Y_L(F)


Y_L_D = zeros(size(Y_diag_sum));
% Loop through each country
for country = 1:num_countries
    % Calculate the start and end indices for this country's data
    start_idx = (country - 1) * 2 * num_sectors + 1;
    end_idx = start_idx + num_sectors - 1;

    % Assign Y_D values for domestic firms
    Y_L_D(start_idx:end_idx) = Y_diag_sum(start_idx:end_idx);
    
    % Assign Y_F values for foreign firms as zero (already initialized as zero)
end

%equation 2 direct value-added coefficient vectors of DOEs and FIEs,
%Y_D=sum(Y_D,2);  %  final production outputs of DOEs in various industries,
Y_L_F=Y_diag_sum-Y_L_D;  % final production outputs of  FIEs in various industries within each country respectively


%exports of final goods and services of  DOEs and FIEs for various 
%country/industry pairs respectively

Y_off_diag= Y-Y_diag;
Y_off_diag_SUM=sum(Y_off_diag,2);
Y_E_D = zeros(size(Y_off_diag_SUM));
% Loop through each country
for country = 1:num_countries
    % Calculate the start and end indices for this country's data
    start_idx = (country - 1) * 2 * num_sectors + 1;
    end_idx = start_idx + num_sectors - 1;

    % Assign Y_D values for domestic firms
    Y_E_D(start_idx:end_idx) = Y_off_diag_SUM(start_idx:end_idx);
    
    % Assign Y_F values for foreign firms as zero (already initialized as zero)
end

%equation 2 direct value-added coefficient vectors of DOEs and FIEs,
%Y_D=sum(Y_D,2);  %  final production outputs of DOEs in various industries,
Y_E_F=Y_off_diag_SUM-Y_E_D;  % final production outputs of  FIEs in various industries within each country respectively


%%
%final production outputs of DOEs and FIEs 
% Y_D
% Y_D=zeros(G*S*2,1);
%     for i=1:G*S
%         Y_D(2*i-1,1)=Y_temp(2*i-1,1);
%     end
% 
% %  Y_LD=Y_D;
% 
%  % Y_F
% Y_F=zeros(G*S*2,1);
%     for i=1:G*S
%         Y_F(2*i,1)=Y_temp(2*i,1);
%     end
% 
% Y_LF=Y_F;
% 
% % Y_L
%    start_id=1;
%    end_id=N;
%    for i=1:G
%     Y_L(start_id:end_id,i)=Y(start_id:end_id,i);
%     start_id=end_id+1;
%     end_id=end_id+N;
%    end
% 
%    % Y_e
%    Y_E=Y-Y_L;
% 
%       % Y_DE
%    Y_E_S=sum(Y_E,2);
% %    Y_DE2= Y_D-Y_LD;
%    Y_DE=zeros(G*S*2,1);
%     for i=1:S
%         Y_DE(2*i-1,1)=Y_E_S(2*i-1,1);
%     end
% 
%       % Y_FE
% %       Y_FE2=Y_F-Y_LF;
% Y_FE=zeros(G*S*2,1);
%     for i=1:S
%         Y_FE(2*i,1)=Y_E_S(2*i,1);
%     end
%     % Y_DE
%    Y_L_S=sum(Y_L,2);
%      Y_LD=zeros(G*S*2,1);
%     for i=1:S
%         Y_LD(2*i-1,1)=Y_L_S(2*i-1,1);
%     end
% 
%       % Y_FE
% Y_LF=zeros(G*S*2,1);
%     for i=1:S
%         Y_LF(2*i,1)=Y_L_S(2*i,1);
%     end
% 
   
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




%%
%Equation 6
B=inv(eye(G*N,G*N)-A);
Term1.total=diag(V)*B*diag(Y_temp);
% Y_L_D
Term1.T1=diag(V_D)*LM*diag(Y_L_D);
%Term.T1=diag(V_D)*LM*diag(Y_LD); % value-added created by DOEs used by their final production to satisfy domestic final demand
% GVC activities
Term1.T2=diag(V_D)*LM*diag(Y_E_D);
%Term.T2=diag(V_D)*LM*diag(Y_DE); %  value-added created by DOEs but embedded in the final goods exports to satisfy the final demand abroad
% GVC activities
Term1.T3=diag(V_D)*LM*A_E*B*diag(Y_D); 
Term1.T31.T11=diag(V_D)*LM*A_E*LM*diag(Y_L_D); %% double check this  value-added embodied in intermediate exports that are produced by DOEs in the host country, but is  used by the direct importing country to produce final products either for domestic final demand (simple GVC activities) or for exports to third countries.
Term1.T31.T12=diag(V_D)*LM*A_E*(B*diag(Y_D)-LM*diag(Y_L_D));

%%
% FDI related activities
%1. %Term.T4=diag(V_D)*LM*diag(Y_LF); % value added originally created by DOEs in the host country but used by FIEs in the final production to satisfy final demand in domestic (host country) and foreign markets respectively.
Term1.T4=diag(V_D)*LM*diag(Y_L_F); % value added originally created by DOEs in the host country but used by FIEs in the final production to satisfy final demand in domestic (host country) and foreign markets respectively.
%2. %Term.T5=diag(V_D)*LM*diag(Y_FE); % value added originally created by DOEs in the host country but used by FIEs in the final production to satisfy final demand in domestic (host country) and foreign markets respectively.
Term1.T5=diag(V_D)*LM*diag(Y_E_F); % value added originally created by DOEs in the host country but used by FIEs in the final production to satisfy final demand in domestic (host country) and foreign markets respectively.

%3. Term.T6=diag(V_F)*LM*diag(Y_LD); % value added generated by the FIEs in a host country but used in the final production of host-country DOEs to satisfy final demand in the domestic and global markets, respectively.
Term1.T6=diag(V_F)*LM*diag(Y_L_D); % value added generated by the FIEs in a host country but used in the final production of host-country DOEs to satisfy final demand in the domestic and global markets, respectively.
%4. Term.T7=diag(V_F)*LM*diag(Y_DE); % value added generated by the FIEs in a host country but used in the final production of host-country DOEs to satisfy final demand in the domestic and global markets, respectively.
Term1.T7=diag(V_F)*LM*diag(Y_E_D); % value added generated by the FIEs in a host country but used in the final production of host-country DOEs to satisfy final demand in the domestic and global markets, respectively.

%5. Term.T8=diag(V_F)*LM*diag(Y_LF); % value added created by one set of FIEs in a host country but is used by potentially a different set of FIEs in their final goods and service production to satisfy final demand in either domestic or foreign markets.
Term1.T8=diag(V_F)*LM*diag(Y_L_F); % value added created by one set of FIEs in a host country but is used by potentially a different set of FIEs in their final goods and service production to satisfy final demand in either domestic or foreign markets.

%6 Term.T9=diag(V_F)*LM*diag(Y_FE); % value added created by one set of FIEs in a host country but is used by potentially a different set of FIEs in their final goods and service production to satisfy final demand in either domestic or foreign markets.
Term1.T9=diag(V_F)*LM*diag(Y_E_F); % value added created by one set of FIEs in a host country but is used by potentially a different set of FIEs in their final goods and service production to satisfy final demand in either domestic or foreign markets.

%%
% Trade and FDI
%Term.T10=diag(V_D)*LM*A_E*B*diag(Y_F); % value-added created by DOEs embodied in their intermediate exports that are used by FIEs in the direct importing countries to produce final goods and services that are either consumed domestically (in the direct importing country) or exported to other countries.
Term1.T10=diag(V_D)*LM*A_E*B*diag(Y_F); % value-added created by DOEs embodied in their intermediate exports that are used by FIEs in the direct importing countries to produce final goods and services that are either consumed domestically (in the direct importing country) or exported to other countries.

%Term.T11=diag(V_F)*LM*A_E*B*diag(Y_D); % value-added embedded in the exports of intermediate inputs that is created by the FIEs in the host country and used by the DOEs in the direct importing country in final production  for both local and global markets. 
Term1.T11=diag(V_F)*LM*A_E*B*diag(Y_D); % value-added embedded in the exports of intermediate inputs that is created by the FIEs in the host country and used by the DOEs in the direct importing country in final production  for both local and global markets. 

%Term.T12=diag(V_F)*LM*A_E*B*diag(Y_F); % value added embedded in the exports of intermediate inputs that is created by the FIEs in the first country and used by the FIEs in the second country (the direct importing country) for final production  that are either consumed locally (in the direct importing country) or exported to other countries. 
Term1.T12=diag(V_F)*LM*A_E*B*diag(Y_F); % value added embedded in the exports of intermediate inputs that is created by the FIEs in the first country and used by the FIEs in the second country (the direct importing country) for final production  that are either consumed locally (in the direct importing country) or exported to other countries. 

Term1.check=Term1.T1+Term1.T2+Term1.T3+Term1.T4+Term1.T5+Term1.T6+Term1.T7+Term1.T8+Term1.T9+Term1.T10+Term1.T11+Term1.T12;
Term1.check_fin=sum(sum(Term1.check-Term1.total));


%%
%𝑛𝑜𝑛−𝐺𝑉𝐶𝑠𝑎𝑐𝑡𝑖𝑣𝑖𝑡𝑖𝑒
Results.VBY=Term1.total;

Results.NGVC.PDP=Term1.T1;
Results.NGVC.Trad_Trade=Term1.T2;
%𝐺𝑉𝐶𝑠𝑎𝑐𝑡𝑖𝑣𝑖𝑡𝑖𝑒
Results.GVC.Trade_GVC=Term1.T3;
Results.GVC.Trade_GVC_st.simple=Term1.T31.T11;
Results.GVC.Trade_GVC_st.complex=Term1.T31.T12;

%value added originally created by DOEs 
% in the host country but used by FIEs in the final production to satisfy final demand in domestic 
% (host country) and foreign markets respectively. 

Results.GVC.FDI_GVC.V_doe_Y_FIE_L=Term1.T4;
Results.GVC.FDI_GVC.V_doe_Y_FIE_E=Term1.T5;

% %value added generated by the FIEs in a host country but used in the final production 
% of host-country DOEs to satisfy final demand in the domestic and global markets, respectively. 

Results.GVC.FDI_GVC.V_fie_Y_DOE_L=Term1.T6;
Results.GVC.FDI_GVC.V_fie_Y_DOE_E=Term1.T7;

% value added created by one set of FIEs 
% in a host country but is used by potentially a different set of FIEs in their final goods and service 
% production to satisfy final demand in either domestic or foreign markets. 
% 

Results.GVC.FDI_GVC.V_fie_Y_FIE_L=Term1.T8;
Results.GVC.FDI_GVC.V_fie_Y_FIE_E=Term1.T9;

%%
%𝑇𝑟𝑎𝑑𝑒 𝑎𝑛𝑑 𝐹𝐷𝐼 𝑟𝑒𝑙𝑎𝑡𝑒𝑑 𝐺𝑉𝐶
% value-added created by DOEs embodied in their intermediate exports that are used by FIEs in the direct 
% importing countries to produce final goods and services that are either consumed domestically (in 
% the direct importing country) or exported to other countries.

Results.GVC.Trade_FDI_GVC.V_doe_Y_FIE_L_F=Term1.T10;
Results.GVC.Trade_FDI_GVC_t1.V_doe_Y_FIE_L=diag(V_D)*LM*A_E*LM*diag(Y_L_F); %Simple GVC
Results.GVC.Trade_FDI_GVC_t1.V_doe_Y_FIE_E=diag(V_D)*LM*A_E*(B*diag(Y_F)-LM*diag(Y_L_F));  %Complex GVC


% value-added embedded in the exports of intermediate inputs that is created by the FIEs in the host 
% country and used by the DOEs in the direct importing country in final production  for both local 
% and global markets. 
Results.GVC.Trade_FDI_GVC.V_fie_Y_DOE_L_F=Term1.T11;
Results.GVC.Trade_FDI_GVC_t2.V_fie_Y_DOE_L=diag(V_F)*LM*A_E*LM*diag(Y_L_D); %Simple GVC
Results.GVC.Trade_FDI_GVC_t2.V_fie_Y_DOE_E=diag(V_F)*LM*A_E*(B*diag(Y_D)-LM*diag(Y_L_D));  %Complex GVC


% value-added embedded in the exports of intermediate inputs that is created by the FIEs in the first country 
% and used by the FIEs in the second country (the direct importing country) for final production  that 
% are either consumed locally (in the direct importing country) or exported to other countries. 

Results.GVC.Trade_FDI_GVC.V_fie_Y_FIE_L_F=Term1.T12;
Results.GVC.Trade_FDI_GVC_t3.V_fie_Y_FIE_L=diag(V_F)*LM*A_E*LM*diag(Y_L_F); %Simple GVC
Results.GVC.Trade_FDI_GVC_t3.V_fie_Y_FIE_E=diag(V_F)*LM*A_E*(B*diag(Y_F)-LM*diag(Y_L_F));  %Complex GVC



%%Results.GVC.FDI_GVC.V_doe_Y_FIE_L

for i=1:77
    for j=1:77
%     start_id=1+(i-1)*82;
% end_id=41+(i-1)*82;
GVC_Trade{j,i}=Results.GVC.Trade_GVC(1+(j-1)*82:41+(j-1)*82,1+(i-1)*82:41+(i-1)*82);
GVC_Trades{i,j}=sum(GVC_Trade{j,i},2);
% test1(1+(i-1)*41:41+(i-1)*41,i)=sum(Results.GVC.Trade_GVC(1+(i-1)*82:41+(i-1)*82,1+(i-1)*82:41+(i-1)*82),2);
    end
end
GVC_TradesM=cell2mat(GVC_Trades);




%% 
for i=1:77
    for j=1:77
        % row_startid{i}=1+(i-1)*82;
        % row_endid{i}=41+(i-1)*82;
        % 
        % col_startid{j}=42+(j-1)*82;
        % col_endid{j}=82+(j-1)*82;
    TradeFDIGVCO1{i,j}=Results.GVC.Trade_FDI_GVC.V_doe_Y_FIE_L_F(1+(i-1)*82:41+(i-1)*82,42+(j-1)*82:82+(j-1)*82);
    TradeFDIGVCO1s{i,j}=sum(TradeFDIGVCO1{i,j},2);
    end
end
TradeFDIGVCO1sM=cell2mat(TradeFDIGVCO1s);

for i=1:77
    for j=1:77
        % row_startid{i}=42+(i-1)*82;
        % row_endid{i}=82+(i-1)*82;
        % % 
        % col_startid{j}=1+(j-1)*82;
        % col_endid{j}=41+(j-1)*82;
    TradeFDIGVCO2{i,j}=Results.GVC.Trade_FDI_GVC.V_fie_Y_DOE_L_F(42+(i-1)*82:82+(i-1)*82,1+(j-1)*82:41+(j-1)*82);
    TradeFDIGVCO2s{i,j}=sum(TradeFDIGVCO2{i,j},2);
    end
end
TradeFDIGVCO2sM=cell2mat(TradeFDIGVCO2s);

for i=1:77
    for j=1:77
        % row_startid{i}=42+(i-1)*82;
        % row_endid{i}=82+(i-1)*82;
        % % 
        % col_startid{j}=42+(j-1)*82;
        % col_endid{j}=82+(j-1)*82;
    TradeFDIGVCO3{i,j}=Results.GVC.Trade_FDI_GVC.V_fie_Y_FIE_L_F(42+(i-1)*82:82+(i-1)*82,42+(j-1)*82:82+(j-1)*82);
    TradeFDIGVCO3s{i,j}=sum(TradeFDIGVCO3{i,j},2);
    end
end
TradeFDIGVCO3sM=cell2mat(TradeFDIGVCO3s);

%%
%𝑛𝑜𝑛−𝐺𝑉𝐶𝑠𝑎𝑐𝑡𝑖𝑣𝑖𝑡𝑖𝑒
Results2.VBY=sum(Term1.total,2);

for i=1:77
    Results2.VBY_D(1+(i-1)*41:41+(i-1)*41,:)=Results2.VBY(1+(i-1)*82:41+(i-1)*82,:);
    Results2.VBY_F(1+(i-1)*41:41+(i-1)*41,:)=Results2.VBY(42+(i-1)*82:82+(i-1)*82,:);
end

Results2.GDP.GDP_DF=Results2.VBY_D+Results2.VBY_F;
Results2.GDP.GDP_SD=Results2.VBY_D./Results2.GDP.GDP_DF;
Results2.GDP.GDP_SF=Results2.VBY_F./Results2.GDP.GDP_DF;

Results2.NGVC.PDP=sum(Results.NGVC.PDP,2);
Results2.NGVC.Trad_Trade=sum(Results.NGVC.Trad_Trade,2);
%𝐺𝑉𝐶𝑠𝑎𝑐𝑡𝑖𝑣𝑖𝑡𝑖𝑒
Results2.GVC.Trade_GVC=GVC_TradesM;
% Results.GVC.Trade_GVC_st.simple=Term1.T31.T11;
% Results.GVC.Trade_GVC_st.complex=Term1.T31.T12;

%value added originally created by DOEs 
% in the host country but used by FIEs in the final production to satisfy final demand in domestic 
% (host country) and foreign markets respectively. 

Results2.GVC_uf.FDI_GVC.V_doe_Y_FIE_L=sum(Results.GVC.FDI_GVC.V_doe_Y_FIE_L,2);
Results2.GVC_uf.FDI_GVC.V_doe_Y_FIE_L=reshape(Results2.GVC_uf.FDI_GVC.V_doe_Y_FIE_L,41,77*2);
j=1;
for i=1:77
    Results2.GVC.FDI_GVC.V_doe_Y_FIE_L(:,j)=Results2.GVC_uf.FDI_GVC.V_doe_Y_FIE_L(:,2*i-1);
    j=j+1;
end

Results2.GVC_uf.FDI_GVC.V_doe_Y_FIE_E=sum(Results.GVC.FDI_GVC.V_doe_Y_FIE_E,2);
Results2.GVC_uf.FDI_GVC.V_doe_Y_FIE_E=reshape(Results2.GVC_uf.FDI_GVC.V_doe_Y_FIE_E,41,77*2);
j=1;
for i=1:77
    Results2.GVC.FDI_GVC.V_doe_Y_FIE_E(:,j)=Results2.GVC_uf.FDI_GVC.V_doe_Y_FIE_E(:,2*i-1);
    j=j+1;
end


% %value added generated by the FIEs in a host country but used in the final production 
% of host-country DOEs to satisfy final demand in the domestic and global markets, respectively. 

Results2.GVC_uf.FDI_GVC.V_fie_Y_DOE_L=sum(Results.GVC.FDI_GVC.V_fie_Y_DOE_L,2);
Results2.GVC_uf.FDI_GVC.V_fie_Y_DOE_L=reshape(Results2.GVC_uf.FDI_GVC.V_fie_Y_DOE_L,41,77*2);
j=1;
for i=1:77
    Results2.GVC.FDI_GVC.V_fie_Y_DOE_L(:,j)=Results2.GVC_uf.FDI_GVC.V_fie_Y_DOE_L(:,2*i-1);
    j=j+1;
end



Results2.GVC_uf.FDI_GVC.V_fie_Y_DOE_E=sum(Results.GVC.FDI_GVC.V_fie_Y_DOE_E,2);
Results2.GVC_uf.FDI_GVC.V_fie_Y_DOE_E=reshape(Results2.GVC_uf.FDI_GVC.V_fie_Y_DOE_E,41,77*2);
j=1;
for i=1:77
    Results2.GVC.FDI_GVC.V_fie_Y_DOE_E(:,j)=Results2.GVC_uf.FDI_GVC.V_fie_Y_DOE_L(:,2*i-1);
    j=j+1;
end

% value added created by one set of FIEs 
% in a host country but is used by potentially a different set of FIEs in their final goods and service 
% production to satisfy final demand in either domestic or foreign markets. 
% 

Results2.GVC_uf.FDI_GVC.V_fie_Y_FIE_L=sum(Results.GVC.FDI_GVC.V_fie_Y_FIE_L,2);
Results2.GVC_uf.FDI_GVC.V_fie_Y_FIE_L=reshape(Results2.GVC_uf.FDI_GVC.V_fie_Y_FIE_L,41,77*2);
j=1;
for i=1:77
    Results2.GVC.FDI_GVC.V_fie_Y_FIE_L(:,j)=Results2.GVC_uf.FDI_GVC.V_fie_Y_FIE_L(:,2*i-1);
    j=j+1;
end


Results2.GVC_uf.FDI_GVC.V_fie_Y_FIE_E=sum(Results.GVC.FDI_GVC.V_fie_Y_FIE_E,2);
Results2.GVC_uf.FDI_GVC.V_fie_Y_FIE_E=reshape(Results2.GVC_uf.FDI_GVC.V_fie_Y_FIE_E,41,77*2);
j=1;
for i=1:77
    Results2.GVC.FDI_GVC.V_fie_Y_FIE_E(:,j)=Results2.GVC_uf.FDI_GVC.V_fie_Y_FIE_E(:,2*i-1);
    j=j+1;
end


%%
%𝑇𝑟𝑎𝑑𝑒 𝑎𝑛𝑑 𝐹𝐷𝐼 𝑟𝑒𝑙𝑎𝑡𝑒𝑑 𝐺𝑉𝐶
% value-added created by DOEs embodied in their intermediate exports that are used by FIEs in the direct 
% importing countries to produce final goods and services that are either consumed domestically (in 
% the direct importing country) or exported to other countries.

Results2.GVC.Trade_FDI_GVC.V_doe_Y_FIE_L_F=TradeFDIGVCO1sM;
% Results.GVC.Trade_FDI_GVC_t1.V_doe_Y_FIE_L=diag(V_D)*LM*A_E*LM*diag(Y_L_F); %Simple GVC
% Results.GVC.Trade_FDI_GVC_t1.V_doe_Y_FIE_E=diag(V_D)*LM*A_E*(B*diag(Y_F)-LM*diag(Y_L_F));  %Complex GVC
% 

% value-added embedded in the exports of intermediate inputs that is created by the FIEs in the host 
% country and used by the DOEs in the direct importing country in final production  for both local 
% and global markets. 
Results2.GVC.Trade_FDI_GVC.V_fie_Y_DOE_L_F=TradeFDIGVCO2sM;
% Results.GVC.Trade_FDI_GVC_t2.V_fie_Y_DOE_L=diag(V_F)*LM*A_E*LM*diag(Y_L_D); %Simple GVC
% Results.GVC.Trade_FDI_GVC_t2.V_fie_Y_DOE_E=diag(V_F)*LM*A_E*(B*diag(Y_D)-LM*diag(Y_L_D));  %Complex GVC


% value-added embedded in the exports of intermediate inputs that is created by the FIEs in the first country 
% and used by the FIEs in the second country (the direct importing country) for final production  that 
% are either consumed locally (in the direct importing country) or exported to other countries. 

Results2.GVC.Trade_FDI_GVC.V_fie_Y_FIE_L_F=TradeFDIGVCO3sM;

Results2.GVC.FDI.FDI_Total=Results2.GVC.FDI_GVC.V_doe_Y_FIE_L+Results2.GVC.FDI_GVC.V_doe_Y_FIE_E+Results2.GVC.FDI_GVC.V_fie_Y_DOE_L+Results2.GVC.FDI_GVC.V_fie_Y_DOE_E+Results2.GVC.FDI_GVC.V_fie_Y_FIE_L+Results2.GVC.FDI_GVC.V_fie_Y_FIE_E;
Results2.GDP.GDP_DF_Res=reshape(Results2.GDP.GDP_DF,[41,77]);
Results2.GVC.FDI.FDIShare=Results2.GVC.FDI.FDI_Total./Results2.GDP.GDP_DF_Res; % we added all 6 categories

Results2.GVC.FDI.T1Share=Results2.GVC.FDI_GVC.V_doe_Y_FIE_L./Results2.GDP.GDP_DF_Res;
Results2.GVC.FDI.T2Share=Results2.GVC.FDI_GVC.V_doe_Y_FIE_E./Results2.GDP.GDP_DF_Res;

Results2.GVC.FDI.T3Share=Results2.GVC.FDI_GVC.V_fie_Y_DOE_L./Results2.GDP.GDP_DF_Res;
Results2.GVC.FDI.T4Share=Results2.GVC.FDI_GVC.V_fie_Y_DOE_E./Results2.GDP.GDP_DF_Res;

Results2.GVC.FDI.T5Share=Results2.GVC.FDI_GVC.V_fie_Y_FIE_L./Results2.GDP.GDP_DF_Res;
Results2.GVC.FDI.T6Share=Results2.GVC.FDI_GVC.V_fie_Y_FIE_E./Results2.GDP.GDP_DF_Res;

%% Trade FDI

Results2.GVC.Trade_FDI_GVC.T1s=sum(Results2.GVC.Trade_FDI_GVC.V_doe_Y_FIE_L_F,2);
Results2.GVC.Trade_FDI_GVC.T2s=sum(Results2.GVC.Trade_FDI_GVC.V_fie_Y_DOE_L_F,2);
Results2.GVC.Trade_FDI_GVC.T3s=sum(Results2.GVC.Trade_FDI_GVC.V_fie_Y_FIE_L_F,2);

Results2.GVC.Trade_FDI_GVC.TT=Results.GVC.Trade_FDI_GVC.T1s+Results.GVC.Trade_FDI_GVC.T2s+Results.GVC.Trade_FDI_GVC.T3s;
Results2.GVC.Trade_FDI_GVC.T1share=Results.GVC.Trade_FDI_GVC.T1s./Results.GVC.Trade_FDI_GVC.TT;
Results2.GVC.Trade_FDI_GVC.T2share=Results.GVC.Trade_FDI_GVC.T2s./Results.GVC.Trade_FDI_GVC.TT;
Results2.GVC.Trade_FDI_GVC.T3share=Results.GVC.Trade_FDI_GVC.T3s./Results.GVC.Trade_FDI_GVC.TT;

%% Extract every 4th column from FD2

for i=1:77
    GFCF.GFCF(:,i)=FD2(:,4+(i-1)*6);
end

for i=1:77
    GFCF.GFCF_D(1+(i-1)*41:41+(i-1)*41,:)=GFCF.GFCF(1+(i-1)*82:41+(i-1)*82,:);
    GFCF.GFCF_F(1+(i-1)*41:41+(i-1)*41,:)=GFCF.GFCF(42+(i-1)*82:82+(i-1)*82,:);
end

GFCF.GFCF_Total=GFCF.GFCF_D+GFCF.GFCF_F;
GFCF.GFCF_Dshar=GFCF.GFCF_D./GFCF.GFCF_Total;
GFCF.GFCF_Fshar=GFCF.GFCF_F./GFCF.GFCF_Total;

Xtras=X';

for i=1:77
    X_D(1+(i-1)*41:41+(i-1)*41,:)=Xtras(1+(i-1)*82:41+(i-1)*82,:);
    X_F(1+(i-1)*41:41+(i-1)*41,:)=Xtras(42+(i-1)*82:82+(i-1)*82,:);
end

X_Total=X_D+X_F;
X_Dshar=X_D./X_Total;
X_Fshar=X_F./X_Total;


%%
for i=1:77
    for j=1:77
%     start_id=1+(i-1)*82;
% end_id=41+(i-1)*82;
% rows(j)=1+(j-1)*82;
% rowe(j)=41+(j-1)*82;
% cols(i)=42+(i-1)*82;
% cole(i)=82+(i-1)*82;
test4{i,j}=Results.GVC.FDI_GVC.V_doe_Y_FIE_L(1+(j-1)*82:41+(j-1)*82,42+(j-1)*82:82+(j-1)*82);
% test1(1+(i-1)*41:41+(i-1)*41,i)=sum(Results.GVC.Trade_GVC(1+(i-1)*82:41+(i-1)*82,1+(i-1)*82:41+(i-1)*82),2);
    end
end
test4M=cell2mat(test4);


%% make z block   
z_block = cell(2*G,2*G);
z_row_sum = cell(2*G,2*G);
for i = 1:2*G
    for j = 1:2*G
        z_block{i,j} = z((i-1)*S+1:i*S, (j-1)*S+1:j*S);
        z_row_sum{i,j} = sum(z_block{i,j}, 2);
    end
end

z_row_sumM=cell2mat(z_row_sum);

% Extract odd rows
for i=1:2*G
    for j=1:2*G
z_row_sum_Odd(i,j)=z_row_sumM(2*i-1,j);
    end
end

% Extract Z_DD
for i=1:2*G
    for j=1:G
z_DD(i,j)=z_row_sum_Odd(i,2*j-1);
    end
end

% Extract Z_DF
for i=1:2*G
    for j=1:G
z_DF(i,j)=z_row_sum_Odd(i,2*j);
    end
end


% Exteact even rows
for i=1:2*G
    for j=1:2*G
z_row_sum_Even(i,j)=z_row_sumM(2*i,j);
    end
end

% Extract Z_FD
for i=1:2*G
    for j=1:G
z_FD(i,j)=z_row_sum_Even(i,2*j-1);
    end
end

% Extract Z_FF
for i=1:2*G
    for j=1:G
z_FF(i,j)=z_row_sum_Even(i,2*j);
    end
end



%% Final Demand
% Y=FD; % for big dataset we need to add categolies using nFD
Y_cell= cell(G*2, G);
num_rows_per_cell = S;

for i = 1:G*2
    for j = 1:G
        start_row = (i-1) * num_rows_per_cell + 1; 
        end_row = start_row + num_rows_per_cell - 1; 
        
 
        if end_row > 2*G*S
            end_row = 2*G*S; 
        end
        
 
        Y_cell{i, j} = Y(start_row:end_row, j); 
    end
end

Y_cellM=cell2mat(Y_cell);

for i=1:2*G
    for j=1:G
Y_Even(i,j)=Y_cellM(2*i,j);
    end
end

for i=1:2*G
    for j=1:G
Y_Odd(i,j)=Y_cellM(2*i-1,j);
    end
end

%% z_odd is z_domestic, z_even is z_foreign
for i=1:2*G
    for j=1:G
z_total(i,j)=z_DD(i,j)+z_DF(i,j)+z_FD(i,j)+z_FF(i,j); 
    end
end


Y_d = Y_Odd;
Y_f = Y_Even;

for i=1:2*G
    for j=1:G
Y_total(i,j)=Y_d(i,j)+Y_f(i,j); 
    end
end

X_DD=[z_DD Y_d];
X_FF=[z_FF Y_f];

%% Share
for i=1:2*G
    for j=1:G
z_share(i,j) = z_DD(i,j) ./z_total(i,j);
Y_share(i,j)  = Y_d(i,j)./Y_total(i,j);
    end
end

% X_dM=cell2mat(X_d);
% X_fM=cell2mat(X_f);

%%
%test.term1.diagV_d=diag(V_D);      %Term.T1=diag(V_D)*LM*diag(Y_LD);
% *B*diag(Y_temp);





%%



% Assuming Y is a 6314x77 matrix
% Initialize the output matrix with zeros


% test.term1.diagV_d=diag(V_D);
% test.term1.LM=LM;
% test.term1.Y_LD=Y_LD;
% 
% Term.total=diag(V)*B*diag(Y_temp);
% Term.T1=diag(V_D)*LM*diag(Y_LD); % value-added created by DOEs used by their final production to satisfy domestic final demand
% % GVC activities
% Term.T2=diag(V_D)*LM*diag(Y_DE); %  value-added created by DOEs but embedded in the final goods exports to satisfy the final demand abroad
% % GVC activities
% Term.T3=diag(V_D)*LM*A_E*B*diag(Y_D);  %% double check this  value-added embodied in intermediate exports that are produced by DOEs in the host country, but is  used by the direct importing country to produce final products either for domestic final demand (simple GVC activities) or for exports to third countries.
% % FDI related activities
% Term.T4=diag(V_D)*LM*diag(Y_LF); % value added originally created by DOEs in the host country but used by FIEs in the final production to satisfy final demand in domestic (host country) and foreign markets respectively.
% Term.T5=diag(V_D)*LM*diag(Y_FE); % value added originally created by DOEs in the host country but used by FIEs in the final production to satisfy final demand in domestic (host country) and foreign markets respectively.
% Term.T6=diag(V_F)*LM*diag(Y_LD); % value added generated by the FIEs in a host country but used in the final production of host-country DOEs to satisfy final demand in the domestic and global markets, respectively.
% Term.T7=diag(V_F)*LM*diag(Y_DE); % value added generated by the FIEs in a host country but used in the final production of host-country DOEs to satisfy final demand in the domestic and global markets, respectively.
% Term.T8=diag(V_F)*LM*diag(Y_LF); % value added created by one set of FIEs in a host country but is used by potentially a different set of FIEs in their final goods and service production to satisfy final demand in either domestic or foreign markets.
% Term.T9=diag(V_F)*LM*diag(Y_FE); % value added created by one set of FIEs in a host country but is used by potentially a different set of FIEs in their final goods and service production to satisfy final demand in either domestic or foreign markets.
% % Trade and FDI
% Term.T10=diag(V_D)*LM*A_E*B*diag(Y_F); % value-added created by DOEs embodied in their intermediate exports that are used by FIEs in the direct importing countries to produce final goods and services that are either consumed domestically (in the direct importing country) or exported to other countries.
% Term.T11=diag(V_F)*LM*A_E*B*diag(Y_D); % value-added embedded in the exports of intermediate inputs that is created by the FIEs in the host country and used by the DOEs in the direct importing country in final production  for both local and global markets. 
% Term.T12=diag(V_F)*LM*A_E*B*diag(Y_F); % value added embedded in the exports of intermediate inputs that is created by the FIEs in the first country and used by the FIEs in the second country (the direct importing country) for final production  that are either consumed locally (in the direct importing country) or exported to other countries. 
% 
% Term.check=Term.T1+Term.T2+Term.T3+Term.T4+Term.T5+Term.T6+Term.T7+Term.T8+Term.T9+Term.T10+Term.T11+Term.T12;
% Term.check-Term.total;







