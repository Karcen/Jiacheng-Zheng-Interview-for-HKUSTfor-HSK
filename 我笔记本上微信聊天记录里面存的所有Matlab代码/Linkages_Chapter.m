clear all

%% Basic sets
N=3; % number of countries
n=4; % number of sectors

z=xlsread('C:\Users\Jiacheng Zheng\Desktop\TCBA_Karcen','TCBA Example',"C4:N15");
X=xlsread('C:\Users\Jiacheng Zheng\Desktop\TCBA_Karcen','TCBA Example',"C21:N21");
A=z./X;
B=z./X';
Y=xlsread('C:\Users\Jiacheng Zheng\Desktop\TCBA_Karcen','TCBA Example',"R4:T15");
V=xlsread('C:\Users\Jiacheng Zheng\Desktop\TCBA_Karcen','TCBA Example',"C16:N16");
L=inv(diag(ones(size(V)))-A);
G=inv(diag(ones(size(V)))-B);
v=V./X;
Ysum=sum(Y,2);
e=ones(N,1);

for j=1:N
IFVArray{j} = diag(v)*L*Y2(:,j);
end


MatrixIFV=cell2mat(IFVArray);
MatrixIFVsum=sum(sum(MatrixIFV));

for j=1:N
CRArray{j} = MatrixIFV(:,j)./MatrixIFVsum;
end


%% 
VBY=diag(v)*B*Y;
TVD=sum(VBY,1); % Forward linkage the total value added created by production factors employed in sector 1 of Country s.
VFP=sum(VBY,2); % Backward linkage contributions of value added from all countries-sectors to the final goods produced by a particular country-sector. by Adding up all elements in the first column equals the value of final products of sector 1 produced in Country s

%% decompose Y
start_id=1;
end_id=n;
Y2=Y;
for i=1:N 
    Y2(start_id:end_id,i)=0;
    start_id=end_id+1;
    end_id=end_id+n;                        
end

%% decompose A
start_id=1;
end_id=n;
A2=A;
for i=1:N 
    A2(start_id:end_id,start_id:end_id)=0;
    start_id=end_id+1;
    end_id=end_id+n;                        
end

%% decompose B
start_id=1;
end_id=n;
B2=B;
for i=1:N 
    B2(start_id:end_id,start_id:end_id)=0;
    start_id=end_id+1;
    end_id=end_id+n;                        
end

%% sub block

% for A and B
rows = n;
cols = n;

AsubMatrices = cell(N, N);
BsubMatrices = cell(N, N);
GsubMatrices = cell(N, N);
LsubMatrices = cell(N, N);

% col_sum
AsubMatrices_col_sum = cell(N, N);
BsubMatrices_col_sum = cell(N, N);
GsubMatrices_col_sum = cell(N, N);
LsubMatrices_col_sum = cell(N, N);


% row_sum
AsubMatrices_row_sum = cell(N, N);
BsubMatrices_row_sum = cell(N, N);
GsubMatrices_row_sum = cell(N, N);
LsubMatrices_row_sum = cell(N, N);



for i = 1:N
    for j = 1:N
        
        rowStart = (i - 1) * rows + 1;
        rowEnd = rowStart + rows - 1;

        colStart = (j - 1) * cols + 1;
        colEnd = colStart + cols - 1;

        AsubMatrix = A(rowStart:rowEnd, colStart:colEnd);
        BsubMatrix = B(rowStart:rowEnd, colStart:colEnd);
        GsubMatrix = G(rowStart:rowEnd, colStart:colEnd);
        LsubMatrix = L(rowStart:rowEnd, colStart:colEnd);

        AsubMatrices{i, j} = AsubMatrix;
        BsubMatrices{i, j} = BsubMatrix;
        GsubMatrices{i, j} = GsubMatrix;
        LsubMatrices{i, j} = LsubMatrix;

        AsubMatrices_col_sum{i,j}=sum(AsubMatrix,1);
        BsubMatrices_col_sum{i,j}=sum(BsubMatrix,1);
        GsubMatrices_col_sum{i,j}=sum(GsubMatrix,1);
        LsubMatrices_col_sum{i,j}=sum(LsubMatrix,1);

        AsubMatrices_row_sum{i,j}=sum(AsubMatrix,2);
        BsubMatrices_row_sum{i,j}=sum(BsubMatrix,2);
        GsubMatrices_row_sum{i,j}=sum(GsubMatrix,2);
        LsubMatrices_row_sum{i,j}=sum(LsubMatrix,2);

        
    end
end

% for Y

subMatrixRows = n;
subMatrixCols = 1;

numRows = size(Y, 1);
numCols = size(Y, 2);

YsubMatrices = cell(ceil(numRows/subMatrixRows), ceil(numCols/subMatrixCols));

for i = 1:subMatrixRows:numRows
    for j = 1:subMatrixCols:numCols
        YsubMatrix = Y(i:min(i+subMatrixRows-1, numRows), j:min(j+subMatrixCols-1, numCols));
        YsubMatrices{ceil(i/subMatrixRows), ceil(j/subMatrixCols)} = YsubMatrix;
    end
end

% A
Matrix_AsubMatrices_col_sum=cell2mat(AsubMatrices_col_sum);
Matrix_AsubMatrices_col_sum_col_sum=sum(Matrix_AsubMatrices_col_sum,1);
result.DB=Matrix_AsubMatrices_col_sum./Matrix_AsubMatrices_col_sum_col_sum;

% L
Matrix_LsubMatrices_col_sum=cell2mat(LsubMatrices_col_sum);
Matrix_LsubMatrices_col_sum_col_sum=sum(Matrix_LsubMatrices_col_sum,1);
result.TB=Matrix_LsubMatrices_col_sum./Matrix_LsubMatrices_col_sum_col_sum;

% B
Matrix_BsubMatrices_row_sum=cell2mat(BsubMatrices_row_sum);
Matrix_BsubMatrices_row_sum_row_sum=sum(Matrix_BsubMatrices_row_sum,2);
result.DF=Matrix_BsubMatrices_row_sum./Matrix_BsubMatrices_row_sum_row_sum;

% G
Matrix_GsubMatrices_row_sum=cell2mat(LsubMatrices_row_sum);
Matrix_GsubMatrices_row_sum_row_sum=sum(Matrix_GsubMatrices_row_sum,2);
result.TF=Matrix_GsubMatrices_row_sum./Matrix_GsubMatrices_row_sum_row_sum;

final.AdivCon()
final.LdivCon()
final.BdivCon()
final.GdivCon()




