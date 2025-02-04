clear all

baseDir = 'E:\\EORA\\';
targetYear = '2019';  % Set the specific year you want to process
currentDir = fullfile(baseDir, ['Eora26_' targetYear '_bp']);  % Construct the directory path

% Define parameters
S = 189;   % Number of countries
N = 26;    % Number of sectors
nfd = 6;   % Number of final demand categories
G=189;
n=26;
% Change directory to the current folder
cd(currentDir);

% Dynamically generate the file names based on the year
Z_file = fullfile(currentDir, ['Eora26_' targetYear '_bp_T.txt']);
FD_file = fullfile(currentDir, ['Eora26_' targetYear '_bp_FD.txt']);
V_file = fullfile(currentDir, ['Eora26_' targetYear '_bp_VA.txt']);

% Read the files for Z, FD, and V matrices
Z = readmatrix(Z_file);               
Z(:, end) = [];  % Delete the last column
Z(end, :) = [];  % Delete the last row


FD = readmatrix(FD_file);
FD1 = squeeze(sum(reshape(FD,S*N+1,nfd,[]),2));
FD1(:, end) = [];  % Delete the last column
FD1(end, :) = [];  % Delete the last row


FD1(FD1==0)=0.000001;
Finaldemand=FD1;

V1 = readmatrix(V_file);
VA=sum(V1,1);                  % 取增加值, confirm value added in matlab and excel
VA(:, end) = [];  % Delete the last column

TI=sum(Z,1)+sum(VA,1);


A=Z./TI;
A(isnan(A))=0;
A(isinf(A))=0;
% csvwrite('originalA.csv',A);

B=inv(eye(G*n)-A);
B(isnan(B))=0;
B(isinf(B))=0;


num_country=189;
num_sector=26;

order=40; % country order

shock=-0.05;

%% Extract the whole row
A1=A;
A1((order-1)*num_sector+1:num_sector*order,:)=A((order-1)*num_sector+1:num_sector*order,:).*(1+shock);

A2=A;
A2((order-1)*num_sector+1:num_sector*order,:)=A((order-1)*num_sector+1:num_sector*order,:).*(1+shock); %改变所有行，FL

%% Extract the selected column
% for upper block
A1(1:num_sector*(order-1),(order-1)*num_sector+1:order*num_sector)=A(1:num_sector*(order-1),(order-1)*num_sector+1:order*num_sector).*(1+shock);

% for lower block
A1(num_sector*order+1:end,(order-1)*num_sector+1:num_sector*order)=A(num_sector*order+1:end,(order-1)*num_sector+1:num_sector*order).*(1+shock);

% Extract the whole column
A3=A;
A3(:,(order-1)*num_sector+1:num_sector*order)=A(:,(order-1)*num_sector+1:num_sector*order).*(1+shock); %改变所有列，BL

%% FD
FD2=FD1;
FD2(:,order)=FD1(:,order)*(1+shock);

%% FD2Y
Y1=sum(FD1,2);
Y2=sum(FD2,2);

%% B              %求列奥列夫逆矩阵，这个矩阵是一个全局的逆矩阵。
B1=inv(eye(size(A1))-A1);
B2=inv(eye(size(A2))-A2);
B3=inv(eye(size(A3))-A3);

%% GDP
% demand and supply
DS.Before_shock=diag(VA)*B*diag(Y1);
DS.After_shock=diag(VA)*B1*diag(Y2);

DS.Before_shock_S=sum(DS.Before_shock,2);
DS.After_shock_S=sum(DS.After_shock,2);

DS.Before_shock_RS=reshape(DS.Before_shock_S,[26,189]);
DS.After_shock_RS=reshape(DS.After_shock_S,[26,189]);

DS.Before_shock_RS_S=sum(DS.Before_shock_RS,1);
DS.After_shock_RS_S=sum(DS.After_shock_RS,1);

DS.change_GDP=(DS.After_shock_RS_S-DS.Before_shock_RS_S)./DS.Before_shock_RS_S;

DS.change_GDP_Global=(sum(DS.After_shock_RS_S)./sum(DS.Before_shock_RS_S))-1;

DS.changeAbyB=DS.After_shock_S./DS.Before_shock_S;

DS.Final.changeSAbySB=sum(DS.After_shock_S)./sum(DS.Before_shock_S);


% supply
su.Before_shock=diag(VA)*B*diag(Y1);
su.After_shock=diag(VA)*B2*diag(Y2);

su.Before_shock_S=sum(su.Before_shock,2);
su.After_shock_S=sum(su.After_shock,2);

su.Before_shock_RS=reshape(su.Before_shock_S,[26,189]);
su.After_shock_RS=reshape(su.After_shock_S,[26,189]);

su.Before_shock_RS_S=sum(su.Before_shock_RS,1);
su.After_shock_RS_S=sum(su.After_shock_RS,1);

su.change_GDP=(su.After_shock_RS_S-su.Before_shock_RS_S)./su.Before_shock_RS_S;

su.change_GDP_Global=(sum(su.After_shock_RS_S)./sum(su.Before_shock_RS_S))-1;

su.changeAbyB=su.After_shock_S./su.Before_shock_S;

su.changeSAbySB=sum(su.After_shock_S)./sum(su.Before_shock_S);


% demand
D.Before_shock=diag(VA)*B*diag(Y1);
D.After_shock=diag(VA)*B3*diag(Y2);

D.Before_shock_S=sum(D.Before_shock,2);
D.After_shock_S=sum(D.After_shock,2);

D.Before_shock_RS=reshape(D.Before_shock_S,[26,189]);
D.After_shock_RS=reshape(D.After_shock_S,[26,189]);

D.Before_shock_RS_S=sum(D.Before_shock_RS,1);
D.After_shock_RS_S=sum(D.After_shock_RS,1);

D.change_GDP=(D.After_shock_RS_S-D.Before_shock_RS_S)./D.Before_shock_RS_S;

D.change_GDP_Global=(sum(D.After_shock_RS_S)./sum(D.Before_shock_RS_S))-1;

D.changeAbyB=D.After_shock_S./D.Before_shock_S;

D.changeSAbySB=sum(D.After_shock_S)./sum(D.Before_shock_S);

%%
cd('E:\AMNE\Chapter_JK')
BRI.DS.change_GDP=BRI_EORA_VAD(DS.change_GDP);
BRI.DS.change_GDP_Global=DS.change_GDP_Global;
BRI.DS.change_GDP=BRI.DS.change_GDP';


BRI.S1.change_GDP=BRI_EORA_VAD(su.change_GDP);
BRI.S1.change_GDP_Global=su.change_GDP_Global;
BRI.S1.change_GDP=BRI.S1.change_GDP';

BRI.D.change_GDP=BRI_EORA_VAD(D.change_GDP);
BRI.D.change_GDP_Global=D.change_GDP_Global;
BRI.D.change_GDP=BRI.D.change_GDP';

BRI.combine.change_GDP=[BRI.DS.change_GDP BRI.S1.change_GDP BRI.D.change_GDP];
%% Sectoral Level
BRIS.DS.change_GDP=BRI_EORA_VAD((DS.After_shock_RS-DS.Before_shock_RS)./DS.Before_shock_RS);
BRIS.S1.change_GDP=BRI_EORA_VAD((su.After_shock_RS-su.Before_shock_RS)./su.Before_shock_RS);
BRIS.D.change_GDP=BRI_EORA_VAD((D.After_shock_RS-D.Before_shock_RS)./D.Before_shock_RS);


