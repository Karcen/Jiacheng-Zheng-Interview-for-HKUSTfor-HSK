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

for i=1:189
    Atilde((i-1)*num_sector+1:i*num_sector,(i-1)*num_sector+1:i*num_sector)=A((i-1)*num_sector+1:i*num_sector,(i-1)*num_sector+1:i*num_sector);
end
I=eye(size(Atilde));
M1=inv(I-Atilde);
Astar=inv(I-Atilde)*(A-Atilde);
M2=(I+Astar);
M3=inv(I-Astar^2);
for i=1:num_country*num_sector
    for j=1:num_country*num_sector
        if M3(i,j)<0.1
            M3(i,j)=0;
        end
    end
end