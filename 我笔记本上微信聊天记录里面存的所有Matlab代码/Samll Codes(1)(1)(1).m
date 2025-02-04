clear;
G=77; % number of countries
S=41;
N=82; % WE SHOULD USE 2 WHEN WE HAVE 1 SECTOR
z = xlsread('E:\AMNE\mne_2023 VERSION\AAMNE_ICIO2010\AAMNE_ICIO2010.csv','AAMNE_ICIO2010',"B2:IHW6315");
FD2 = xlsread('E:\AMNE\mne_2023 VERSION\AAMNE_ICIO2010\AAMNE_ICIO2010.csv','AAMNE_ICIO2010',"IHX2:IZQ6315");
X = xlsread('E:\AMNE\mne_2023 VERSION\AAMNE_ICIO2010\AAMNE_ICIO2010.csv','AAMNE_ICIO2010',"B6318:IHW6318");
VaD = xlsread('E:\AMNE\mne_2023 VERSION\AAMNE_ICIO2010\AAMNE_ICIO2010.csv','AAMNE_ICIO2010',"B6316:IHW6316");


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


% we make block of z that every sub-matrix is 4*4, and row sum of
% sub-matrix elements.
z_block = cell(2*G,2*G);
z_block_row_sum = cell(2*G,2*G);
for i = 1:2*G
    for j = 1:2*G
        z_block{i,j} = z((i-1)*S+1:i*S, (j-1)*S+1:j*S);
        z_block_row_sum{i,j} = sum(z_block{i,j}, 2);
    end
end

z_block_row_sumM=cell2mat(z_block_row_sum);

% Extract odd rows
for i=1:S*G
    for j=1:2*G
z_block_row_sum_Odd(i,j)=z_block_row_sumM(2*i-1,j);
    end
end

% Extract Z_DD
for i=1:S*G
    for j=1:G
z_DD(i,j)=z_block_row_sum_Odd(i,2*j-1);
    end
end

% Extract Z_DF
for i=1:S*G
    for j=1:G
z_DF(i,j)=z_block_row_sum_Odd(i,2*j);
    end
end


% Exteact even rows
for i=1:S*G
    for j=1:2*G
z_block_row_sum_Even(i,j)=z_block_row_sumM(2*i,j);
    end
end

% Extract Z_FD
for i=1:S*G
    for j=1:G
z_FD(i,j)=z_block_row_sum_Even(i,2*j-1);
    end
end

% Extract Z_FF
for i=1:S*G
    for j=1:G
z_FF(i,j)=z_block_row_sum_Even(i,2*j);
    end
end

%% Using z to solve export share
% We can get sectoral export and import from this matrices, row sum is
% export, column sum is import
z_DD_e=z_DD; 
z_DF_e=z_DF;
z_FD_e=z_FD;
z_FF_e=z_FF;

for i=1:G
    z_DD_e(2*i-1:2*i,i)=0;
    z_DF_e(2*i-1:2*i,i)=0;
    z_FD_e(2*i-1:2*i,i)=0;
    z_FF_e(2*i-1:2*i,i)=0;
end

z_S_DD_exp_S=sum(z_DD_e,2);
z_S_DF_exp_S=sum(z_DF_e,2);
z_S_FD_exp_S=sum(z_FD_e,2);
z_S_FF_exp_S=sum(z_FF_e,2);

z_S_DD_imp_S=sum(z_DD_e,1);
z_S_DF_imp_S=sum(z_DF_e,1);
z_S_FD_imp_S=sum(z_FD_e,1);
z_S_FF_imp_S=sum(z_FF_e,1);


 z_diag_zero=z;
for i=1:G
    z_diag_zero((i-1)*N+1:N*i,(i-1)*N+1:N*i)=0;
end

z_S_diag_zero_rowS=sum( z_diag_zero,2);
% z_S_diag_zero_colS=sum( z_diag_zero,1);

for i=1:S*G
z_dzrs_D(i,1)=z_S_diag_zero_rowS(2*i-1,1);
z_dzrs_F(i,1)=z_S_diag_zero_rowS(2*i,1);
% z_dzcs_D(1,i)=z_S_diag_zero_colS(1,2*i-1);
% z_dzcs_F(1,i)=z_S_diag_zero_colS(1,2*i);
end


z_DD_exp_Share=z_S_DD_exp_S./z_dzrs_D;
z_FF_exp_Share=z_S_FF_exp_S./z_dzrs_F;
z_DF_exp_Share=z_S_DF_exp_S./z_dzrs_D;
z_FD_exp_Share=z_S_FD_exp_S./z_dzrs_F;

% z_DD_imp_Share=z_S_DD_imp_S./z_dzcs_D;
% z_FF_imp_Share=z_S_FF_imp_S./z_dzcs_F;
% z_DF_imp_Share=z_S_DF_imp_S./z_dzcs_D;
% z_FD_imp_Share=z_S_FD_imp_S./z_dzcs_F;

% Country Level
for i=1:G
    z_C_DD_exp_S(i,1)=sum(z_S_DD_exp_S(2*i-1:2*i,1),1);
    z_C_FF_exp_S(i,1)=sum(z_S_FF_exp_S(2*i-1:2*i,1),1);
    z_C_DF_exp_S(i,1)=sum(z_S_DF_exp_S(2*i-1:2*i,1),1);
    z_C_FD_exp_S(i,1)=sum(z_S_FD_exp_S(2*i-1:2*i,1),1);
    z_C_dzrs_D(i,1)=sum(z_dzrs_D(2*i-1:2*i,1),1);
    z_C_dzrs_F(i,1)=sum(z_dzrs_F(2*i-1:2*i,1),1);
end

z_DD_e_CShare=z_C_DD_exp_S./z_C_dzrs_D;
z_FF_e_CShare= z_C_FF_exp_S./z_C_dzrs_F;
z_DF_e_CShare=z_C_DF_exp_S./z_C_dzrs_D;
z_FD_e_CShare=z_C_FD_exp_S./z_C_dzrs_F;


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

for i=1:S*G
    for j=1:G
Y_Even(i,j)=Y_cellM(2*i,j);
    end
end

for i=1:S*G
    for j=1:G
Y_Odd(i,j)=Y_cellM(2*i-1,j);
    end
end

%% z_odd is z_domestic, z_even is z_foreign
for i=1:S*G
    for j=1:G
z_total(i,j)=z_DD(i,j)+z_DF(i,j)+z_FD(i,j)+z_FF(i,j); 
    end
end


Y_d = Y_Odd;
Y_f = Y_Even;

for i=1:S*G
    for j=1:G
Y_total(i,j)=Y_d(i,j)+Y_f(i,j); 
    end
end

X_2=z_total+Y_total;

X_DD=[z_DD Y_d];
X_FF=[z_FF Y_f];

%% Share
for i=1:2*G
    for j=1:G
z_shareDD(i,j) = z_DD(i,j) ./z_total(i,j);
z_shareDF(i,j) = z_DF(i,j) ./z_total(i,j);
z_shareFD(i,j) = z_FD(i,j) ./z_total(i,j);
z_shareFF(i,j) = z_FF(i,j) ./z_total(i,j);

Y_shareDD(i,j)  = Y_d(i,j)./Y_total(i,j);
Y_shareFF(i,j)  = Y_f(i,j)./Y_total(i,j);
    end
end

%% Export share
z_temp=z;
for i=1:G
z_temp((i-1)*N+1:N*i,(i-1)*N+1:N*i)=0;
end
z_temp_total=sum(z_temp,2);

for i=1:G*N/2
    z_temp_total2(i,1)=sum(z_temp_total(2*i-1:2*i),1);
end
z_share=z_temp_total./repelem(z_temp_total2,2);

z_dplusf=z_block_row_sum_Even+z_block_row_sum_Odd;

for i=1:G
    z_diag_dplusf((i-1)*S+1:S*i,2*i-1:2*i)=z_dplusf((i-1)*S+1:S*i,2*i-1:2*i);
end

 z_offdiag_dplusf=z_dplusf-z_diag_dplusf;


%% Y
for i=1:G
    Y_diag((i-1)*N+1:N*i,i)=Y_cellM((i-1)*N+1:N*i,i);
end

Y_offdiag=Y_cellM-Y_diag;

Y_offdiag_s=sum(Y_offdiag,2);

for i=1:G*N/2
    Y_offdiag_s2(i,1)=sum(Y_offdiag_s(2*i-1:2*i),1);
end

Y_share=Y_offdiag_s./repelem(Y_offdiag_s2,2);


%% Country Level
for i=1:2*G
    z_temp_totalD(i,1)=z_temp_total(2*i-1,1);
end

for i=1:G
    z_temp_totalsD(i,1)=sum(z_temp_totalD(2*i-1:2*i,1),1);
end

for i=1:2*G
    z_temp_totalF(i,1)=z_temp_total(2*i,1);
end

for i=1:G
    z_temp_totalsF(i,1)=sum(z_temp_totalF(2*i-1:2*i,1),1);
end

z_CL_DF=z_temp_totalsF+z_temp_totalsD;

z_CL_shareD=z_temp_totalsD./z_CL_DF;
z_CL_shareF=z_temp_totalsF./z_CL_DF;


% For Y Country Level

for i=1:2*G
    Y_offdiag_D(i,1)=Y_offdiag_s(2*i-1,1);
end

for i=1:G
    Y_offdiag_sD(i,1)=sum(Y_offdiag_D(2*i-1:2*i,1),1);
end

for i=1:2*G
    Y_offdiag_F(i,1)=Y_offdiag_s(2*i,1);
end

for i=1:G
    Y_offdiag_sF(i,1)=sum(Y_offdiag_F(2*i-1:2*i,1),1);
end

Y_CL_DF=Y_offdiag_sF+Y_offdiag_sD;

Y_CL_shareD=Y_offdiag_sD./Y_CL_DF;
Y_CL_shareF=Y_offdiag_sF./Y_CL_DF;

