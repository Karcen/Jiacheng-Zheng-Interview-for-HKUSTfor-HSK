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

% A(isnan(A))=0;
% A(isinf(A))=0;
Z_subMatrices = cell(S,S);
for i = 1:G
    for j = 1:G
        Z_subMatrix = z((N*(i-1)+1):(N*i), (N*(j-1)+1):(N*j));
        Z_subMatrices {i,j} = Z_subMatrix;
    end
end

Z_d=zeros(S*N);
start_id=1;
end_id=N;
for i=1:G
Z_d(start_id:end_id,start_id:end_id)=Z_subMatrices{i,i};
    start_id=end_id+1;
    end_id=end_id+N;
end
Z_f=z-Z_d;


Zd_s=sum(Z_d,2);
for i=1:G*S
Zd_s_even(i,1)=Zd_s(2*i,1);
end

for i=1:G*S
Zd_s_odd(i,1)=Zd_s(2*i-1,1);
end

Zd_resh_F=reshape(Zd_s_even,[S,G]);
Zd_resh_D=reshape(Zd_s_odd,[S,G]);


Z_exp=sum(Z_f,2);
for i=1:G*S
Z_f_exp_even(i,1)=Z_exp(2*i,1);
end

for i=1:G*S
Z_f_exp_odd(i,1)=Z_exp(2*i-1,1);
end

Zf_exp_F=reshape(Z_f_exp_even,[S,G]);
Zf_exp_D=reshape(Z_f_exp_odd,[S,G]);

Z_imp=sum(Z_f,1);
for i=1:G*S
Z_f_imp_even(1,i)=Z_imp(1,2*i);
end

for i=1:G*S
Z_f_imp_odd(1,i)=Z_imp(1,2*i-1);
end

Zf_imp_F=reshape(Z_f_imp_even,[S,G]);
Zf_imp_D=reshape(Z_f_imp_odd,[S,G]);




%% For Y Start from Y
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

FD=Y;
start_id=1;
end_id=N;
for i=1:G
    FD_d(start_id:end_id,i)=FD(start_id:end_id,i);
    start_id=end_id+1;
    end_id =end_id+N;
end
FD_f=FD-FD_d;

x=sum(z,2)+sum(FD,2);




