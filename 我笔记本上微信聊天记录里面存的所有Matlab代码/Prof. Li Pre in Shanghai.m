clear all
%% Basic sets
N=3; % number of countries
n=4; % number of sectors



%% create the matrix we need to use
inp.e=ones(N,1);
inp.z=xlsread('E:\CBAN\TCBA_Karcen','TCBA Example',"C4:N15");
inp.X=xlsread('E:\CBAN\TCBA_Karcen','TCBA Example',"C21:N21");
% inp.Tz=xlsread('E:\ADB_Stuff_Karcen\Day-05_Session-01_Applications-and-Hands-on-Exercise_Worksheet','3 Three Regions',"E23:S23");
inp.A=inp.z./inp.X;
inp.isizeA=size(inp.A,1);
inp.I=eye(inp.isizeA);
inp.L=inv(inp.I-inp.A);
% inp.Y=xlsread('E:\ADB_Stuff_Karcen\Day-05_Session-01_Applications-and-Hands-on-Exercise_Worksheet','3 Three Regions',"T8:AH22");
% inp.VAA=xlsread('E:\ADB_Stuff_Karcen\Day-05_Session-01_Applications-and-Hands-on-Exercise_Worksheet','3 Three Regions',"E28:S28");
% inp.Y=xlsread('E:\CBAN\TCBA_Karcen','TCBA Example',"R4:T15");
inp.GHG=xlsread('E:\CBAN\TCBA_Karcen','TCBA Example',"C23:N23");
inp.f = inp.GHG./inp.X;
inp.p = inp.f * inp.Y;
inp.FD = xlsread('E:\CBAN\TCBA_Karcen','FD',"I3:W14");
%% 
for i = 1:N
    for j = 1:N
       submatrices.z{i, j} = inp.z((i-1)*n+1:i*n, (j-1)*n+1:j*n);
    end
end

for i = 1:N
    for j = 1:N
        submatrices.A{i, j} = inp.A((i-1)*n+1:i*n, (j-1)*n+1:j*n);
    end
end

% 初始化存储每个子矩阵按列求和的变量
sum_submatrices_z_col= cell(N, N);

% 遍历每个子矩阵并对其进行按列求和
for i = 1:N
    for j = 1:N
        % 对当前子矩阵按列求和
        sum_submatrices_z_col{i, j} = sum(submatrices.z{i, j}, 1);
    end
end

% 初始化存储每个子矩阵按列求和的变量
sum_submatrices_z_row = cell(N, N);

% 遍历每个子矩阵并对其进行按列求和
for i = 1:N
    for j = 1:N
        % 对当前子矩阵按列求和
        sum_submatrices_z_row{i, j} = sum(submatrices.z{i, j}, 2);
    end
end

int_trade = cell(N, N);

% 遍历每个子矩阵并对其进行按列求和
for i = 1:N
    for j = 1:N
        % 对当前子矩阵按列求和
        int_trade{i,j} = sum(sum(submatrices.z{i, j},1));
    end
end

% 遍历每个子矩阵并对其进行按列求和
for i = 1:N
    for j = 1:N
        % 对当前子矩阵按列求和
        int_trade_Ndiag{i,j} = int_trade{i,j}; 
        int_trade_Ndiag{j,j} =0;
    end
end
int_trade_Ndiag_Matrix=cell2mat(int_trade_Ndiag);
% 遍历每个子矩阵并对其进行按列求和
for i = 1:N
    for j = 1:N
Exports.int = sum(int_trade_Ndiag_Matrix,2);
    end
end

% 遍历每个子矩阵并对其进行按列求和
for i = 1:N
    for j = 1:N
Imports.int = sum(int_trade_Ndiag_Matrix,1);
    end
end
inp.Y=inp.FD;
for i = 1:N
    for j = 1:N
       submatrices.Y{i, j} = inp.Y((i-1)*n+1:i*n, (j-1)*n+1:j*n);
    end
end

for i = 1:N
    for j = 1:N
        submatrices.A{i, j} = inp.A((i-1)*n+1:i*n, (j-1)*n+1:j*n);
    end
end

% 初始化存储每个子矩阵按列求和的变量
sum_submatrices_Y_col= cell(N, N);

% 遍历每个子矩阵并对其进行按列求和
for i = 1:N
    for j = 1:N
        % 对当前子矩阵按列求和
        sum_submatrices_Y_col{i, j} = sum(submatrices.Y{i, j}, 1);
    end
end

% 初始化存储每个子矩阵按列求和的变量
sum_submatrices_Y_row = cell(N, N);

% 遍历每个子矩阵并对其进行按列求和
for i = 1:N
    for j = 1:N
        % 对当前子矩阵按列求和
        sum_submatrices_Y_row{i, j} = sum(submatrices.Y{i, j}, 2);
    end
end

FD = cell(N, N);

% 遍历每个子矩阵并对其进行按列求和
for i = 1:N
    for j = 1:N
        % 对当前子矩阵按列求和
        FD{i,j} = sum(sum(submatrices.Y{i, j},1));
    end
end

% 遍历每个子矩阵并对其进行按列求和
for i = 1:N
    for j = 1:N
        % 对当前子矩阵按列求和
        FD_Ndiag{i,j} = FD{i,j}; 
        FD_Ndiag{j,j} =0;
    end
end
FD_Ndiag_Matrix=cell2mat(FD_Ndiag);
% 遍历每个子矩阵并对其进行按列求和
for i = 1:N
    for j = 1:N
Exports.FD = sum(FD_Ndiag_Matrix,2);
    end
end

% 遍历每个子矩阵并对其进行按列求和
for i = 1:N
    for j = 1:N
Imports.FD = sum(FD_Ndiag_Matrix,1);
    end
end

Exports.tot = Exports.int + Exports.FD;
Imports.tot = Imports.int + Imports.FD;


EL=diag(inp.GHG)*inp.L;

%% Equation 1
inp.x=inp.L*inp.Y*inp.e; 
%% Equation 2
inp.isizeY=size(inp.Y,2);
columnMatricesY = cell(1,inp.isizeY);
for i = 1:N
    columnMatricesY{i} = zeros(n*N, inp.isizeY);  
    columnMatricesY{i}(:,i) =inp.Y(:,i);  
end
for i = 1:inp.isizeY
    disp(columnMatricesY{i});
    disp('---'); 
end
%% Equation 3 [where qr is the vector of direct externalities coefficients for country r, in which all coefficients associated with countries s ~= r are set to 0.
inp.q=inp.GHG./inp.X; 
disp(inp.q);
% Calculate the split index
splitIndex = numel(inp.q) / N;
% Create a cell array to store the split matrices
inp.inp.qArray = cell(1, n*N/splitIndex);
inp.inp.qArray2matrix=cell2mat(inp.inp.qArray);
inp.qdiag=diag(inp.inp.qArray2matrix);

% Split the original matrix into N matrices
for i = 1:N
    % Create an empty 1xn matrix
    qSplit = zeros(1, numel(inp.q));
    % Assign elements to the split matrices based on the split index
        qSplit(1+(i-1)*n:splitIndex*i) = inp.q(1+(i-1)*n:splitIndex*i);
         % Add the split matrix to the cell array
     inp.inp.qArray{i} = qSplit;
end
% Display the split matrices
for i = 1:N
    disp(inp.inp.qArray{i});
end

%% Equation 4[The volume of externalities caused in country r to supply the final demand in country s can be obtained by multiplying the vector of externalities coefficients of country r, qr with
%the Leontief inverse L and the final demand in country s, Ys
eq.eq4.frsArray=cell(1,((1+(N-1))*(N-1))/2)
for r=1:N
    for s=1:N
        if s~=r
                eq.eq4.frs=diag(inp.inp.qArray{1,r})*inp.L*columnMatricesY{1,s}*inp.e;
                eq.eq4.frsArray{r}=eq.eq4.frs;
        else
            continue
            end
    end
end
%note add sum of every equation at the end of equation
%eq.eq4.frsmatrix=cell2mat(eq.eq4.frsArray);
%eq.eq4.frsmatrixsum=sum(eq.eq4.frsmatrix);
%exam.exam4.frs=diag(inp.inp.qArray{1,1})*inp.L*columnMatricesY{1,3}*inp.e;

%% Equation 5 6 (PBAC:these are exported externalities:: for example, externalities in China to meet final demand of EU/US/ROW)
%The sum of the externalities caused in country c to supply the final demand in any country corresponds to the Production Based Accounting (PBA) measure of the externalities
%attributable to country c, noted pbac
eq.eq56.pbac=0;
eq.eq56.pbacArray=cell(1,((1+(N-1))*(N-1))/2)
for c=1:N
    for s=1:N
          if c~=s
                      eq.eq56.pbac=eq.eq56.pbac+diag(inp.inp.qArray{1,c})*inp.L*columnMatricesY{1,s}*inp.e;
          end 
    end
    eq.eq56.pbacArray{c}=eq.eq56.pbac;
    eq.eq56.pbac=0;
end
eq.eq5.pbacmatrix=cell2mat(eq.eq56.pbacArray);
eq.eq5.pbacmatrixsum=sum(eq.eq5.pbacmatrix);
% example is following
%eq.eq56.pbac1=eq.eq56.pbac+diag(inp.inp.qArray{1,1})*inp.L*columnMatricesY{1,3}*inp.e;
%eq.eq56.pbac2=eq.eq56.pbac+diag(inp.inp.qArray{1,1})*inp.L*columnMatricesY{1,2}*inp.e;
%eq.eq56.pbac3=eq.eq56.pbac1+eq.eq56.pbac2;
%disp(sum(eq.eq56.pbac3));



%% Equation 7 8 (CBAC are imported externalities caused in any country to supply the final demand in country c yields the Consumption Based Accounting (CBA) 
eq.eq78.cbac=0;
eq.eq78.cbacArray=cell(1,((1+(N-1))*(N-1))/2)
for c=1:N
    for r=1:N
          if r~=c
                      eq.eq78.cbac=eq.eq78.cbac+diag(inp.inp.qArray{1,r})*inp.L*columnMatricesY{1,c}*inp.e;
          end 
    end
      eq.eq78.cbacArray{c}=eq.eq78.cbac;
      eq.eq78.cbac=0;
end
eq.eq78.cbacmatrix=cell2mat(eq.eq78.cbacArray);
eq.eq78.cbacmatrixsum=(eq.eq78.cbacmatrix);

% example is following 
%eq.eq78.cbac1=eq.eq78.cbac+diag(inp.inp.qArray{1,2})*inp.L*columnMatricesY{1,1}*inp.e;
%eq.eq78.cbac2=eq.eq78.cbac+diag(inp.inp.qArray{1,3})*inp.L*columnMatricesY{1,1}*inp.e;



%%  Measuring the throughflow

%% Equation 9  imports to c (China) and exports from c (china) are set to 0

eq.eq9.AcbarArray=cell(N,1);
    for i=1:N
              eq.eq9.Acbar=inp.A;
             eq.eq9.Acbar(1+(i-1)*n:i*n,:)=0;
              eq.eq9.Acbar(:,1+(i-1)*n:i*n)=0;
            eq.eq9.AcbarArray{i}=eq.eq9.Acbar;
    end
  eq.eq9.Acbarmatrix=cell2mat(eq.eq9.AcbarArray);  
  eq.eq9.Acbarmatrixsum=sum(eq.eq9.Acbarmatrix);
  
% example is following 
 % eq.eq9.AcbarArray2=eq.eq9.AcbarArray{1};
  
%% Equation 10
eq.eq10.LcbarArray=cell(N,1);
    for i=1:N
    eq.eq10.Lcbar=inv(inp.I-eq.eq9.AcbarArray{i});
    eq.eq10.LcbarArray{i}= eq.eq10.Lcbar;
    end
   eq.eq10.Lcbarmatrix=cell2mat(eq.eq10.LcbarArray);
   eq.eq10.Lcbarmatrixsum=sum(eq.eq10.Lcbarmatrix);
   
   % example is following 
  % eq.eq10.Lcbar2=eq.eq10.LcbarArray{2};
% if we want to extract special country we can use 


%% Equation 11:    Then, we define Y� c to be the global final demand of commodities outside of country c, 
%built from the final demand matrix Yby setting the final demand of countryc(c-th column)to zero:
eq.eq11.YcbarArray=cell(1,c);
    for i=1:c
        eq.eq11.Ycbar=inp.Y;
        eq.eq11.Ycbar(:,i)=0;
        eq.eq11.YcbarArray{i}=eq.eq11.Ycbar;
    end
    eq.eq11.Ycbarmatrix=cell2mat(eq.eq11.YcbarArray);
    eq.eq11.Ycbarmatrixsum=sum(eq.eq11.Ycbarmatrix);
    
% example is following 
%eq.eq11.YcbarArray2=eq.eq11.YcbarArray{2};
    
eq.eq11.YcArray=cell(1,c);
 for i=1:c
        eq.eq11.Yc=inp.Y;
        eq.eq11.Yc(:,i)=0;
        eq.eq11.Ycbar=inp.Y;
        eq.eq11.Ycbar(:,i)=0;
        eq.eq11.YcArray{i}=inp.Y-eq.eq11.Ycbar;
 end
eq.eq11.Ycmatrix=cell2mat(eq.eq11.YcArray);
eq.eq11.Ycmatrixsum=sum(eq.eq11.Ycmatrix);

% example is following 
%eq.eq11.YcArray2=eq.eq11.YcArray{2};
 
 
%% Equation 12
eq.eq12.qcbarArray=cell(1,N);
for i=1:N
        eq.eq12.qc=inp.q;
        startcolum=1+(i-1)*n;
        endcolum=i*n;
         eq.eq12.qc(:,startcolum:endcolum)=0;
         eq.eq12.qcbar=inp.q-eq.eq12.qc;
         eq.eq12.qcbar=inp.q-eq.eq12.qcbar;
         eq.eq12.qcbarArray{i}=eq.eq12.qcbar;
end   
 eq.eq12.qcbarmatrix=cell2mat(eq.eq12.qcbarArray);
 eq.eq12.qcbarmatrixsum=sum(eq.eq12.qcbarmatrix);

 % example is following 
%eq.eq12.qcbarArray2=eq.eq12.qcbarArray{2};

%% Equation 13
eq.eq13.qLY=diag(inp.q)*inp.L*inp.Y;
eq.eq13.qLYArray=cell(1,N);
    for i=1:N
        eq.eq13.qLYbar=diag(eq.eq12.qcbarArray{i})*eq.eq10.LcbarArray{i}*eq.eq11.YcbarArray{i};
        eq.eq13.qLYArray{i}=eq.eq13.qLYbar;
    end
    eq.eq13.qLYmatrix=cell2mat(eq.eq13.qLYArray);
    eq.eq13.qLYmatrixsum=sum(eq.eq13.qLYmatrix);
    eq.eq13.qLYArray2=eq.eq13.qLYArray{2};
    
     % example is following 
     
     
      eq.eq13.tbacArray=cell(1,N);
    for i=1:N
         eq.eq13.tbac=(eq.eq13.qLY-eq.eq13.qLYArray{i})*inp.e;
         eq.eq13.tbacArray{i}=eq.eq13.tbac;
    end
    
eq.eq13.tbacmatrix=cell2mat(eq.eq13.tbacArray);
eq.eq13.tracmatrixsum=sum(eq.eq13.tbacmatrix);

 % example is following 
%eq.eq13.tbacArray2=eq.eq13.tbacArray{2};


%% Decomposing the throughflow

%% Equation 14
eq.eq14.loccArray=cell(1,c);
    for i=1:c
        eq.eq14.locc=diag(inp.inp.qArray{i})*inp.L*eq.eq11.YcArray{i}*inp.e; 
        eq.eq14.loccArray{i}=eq.eq14.locc;
    end
    eq.eq14.local=cell2mat(eq.eq14.loccArray);
    eq.eq14.localsum=sum( eq.eq14.local);
    
    % example is following 
  %  eq.eq14.loccArray1= eq.eq14.loccArray{1};
    
 %% Equation 15 imprc=imp_r^c
 eq.eq15.imprc=0;
 eq.eq15.imprcArray=cell(1,((1+(N-1))*(N-1))/2);
for r=1:c
                       eq.eq15.imprc= diag(eq.eq12.qcbarArray{r})*inp.L*eq.eq11.YcArray{r}*inp.e;
     eq.eq15.imprcArray{r}= eq.eq15.imprc;
end
eq.eq15.imports=cell2mat(eq.eq15.imprcArray);
eq.eq15.importssum=sum(eq.eq15.imports);

 % example is following 
%eq.eq15.imprcArray2=eq.eq15.imprcArray{2};
 %% Equation 16 expsc=exp_s^c
eq.eq16.expsc=0;
eq.eq16.expscArray=cell(1,((1+(N-1))*(N-1))/2);
for c=1:N
    for s=1:N
          if s~=c
             
                       eq.eq16.expsc=eq.eq16.expsc+diag(inp.inp.qArray{c})*inp.L*eq.eq11.YcArray{1,s}*inp.e;
          end 
    end
     eq.eq16.expscArray{c}=eq.eq16.expsc;
    eq.eq16.expsc=0;
end
eq.eq16.exports=cell2mat(eq.eq16.expscArray);
eq.eq16.exportssum=sum(eq.eq16.exports);

 % example is following 
% eq.eq16.expscArray2=eq.eq16.expscArray{2};
 
 %% Equation 17 expsc=exp_s^c
t=0;
for s=1:N
    for c=1:N
             for r=1:N
                    if s~=c & r~=c & s~=r
                       t=t+1;
                    end 
             end  
    end
    end

eq.eq17.index=0;
eq.eq17.trarsc=0;
eq.eq17.each_trarscArray=cell(1,t)
eq.eq17.trarscArray=cell(1,((1+(N-1))*(N-1))/2);
eq.eq17.indexArray=cell(1,t)
for s=1:N
    for c=1:N
             for r=1:N
                    if s~=c & r~=c & s~=r
                       eq.eq17.trarsc0=diag(inp.inp.qArray{s})*(inp.L-eq.eq10.LcbarArray{c})*eq.eq11.YcArray{r}*inp.e;
                       eq.eq17.trarsc=eq.eq17.trarsc+diag(inp.inp.qArray{s})*(inp.L-eq.eq10.LcbarArray{c})*eq.eq11.YcArray{r}*inp.e;   
                       eq.eq17.each_trarscArray{eq.eq17.index+1}= eq.eq17.trarsc0;
                       eq.eq17.index= eq.eq17.index+1;
                       eq.eq17.indexArray{eq.eq17.index}=[s,c,r];
                    end 

             end
             eq.eq17.trarscArray{s}=eq.eq17.trarsc;     
    end
    eq.eq17.trarsc=0;
end
eq.eq17.tras=cell2mat(eq.eq17.trarscArray);
eq.eq17.trarscArraycombined = vertcat(eq.eq17.indexArray, eq.eq17.each_trarscArray);
eq.eq17.trassum=sum(eq.eq17.tras);
 % example is following 
%eq.eq17.trarscArray2=eq.eq17.trarscArray{2};

%% Equation 18
%eq.eq18.tbacArray2 = cellfun(@(x, y, z, w) x + abs(y) + abs(z) + abs(w), eq.eq14.loccArray, eq.eq15.imprcArray, eq.eq16.expscArray, eq.eq17.trarscArray, 'UniformOutput', false);
%eq.eq18.tbac=cell2mat(eq.eq18.tbacArray2);

%% Equation 19
%eq.eq19.pbacArray2=cellfun(@(x,y)x+abs(y), eq.eq14.loccArray,eq.eq16.expscArray);
%eq.eq19.cbacArray2=cellfun(@(x,y)x+abs(y), eq.eq14.loccArray,eq.eq15.imprcArray);

%% Transported Externalities (Re-exported)
eq.eq20.TEArray=cell(1,((1+(N-1))*(N-1))/2);
for i=1:N
    eq.eq20.TE=diag(eq.eq12.qcbarArray{i})*(inp.L-eq.eq10.LcbarArray{i})*eq.eq11.YcbarArray{i};
    eq.eq20.TEArray{i}=eq.eq20.TE;
end
eq.eq20.TEArray=cell2mat(eq.eq20.TEArray);
eq.eq20.TEArraysum=sum(eq.eq20.TEArray);

 % example is following 
%eq.eq20.TEArray1=eq.eq20.TEArray(1:3);

%% Re-imported externalities*
eq.eq21.LcArray=cell(N,1);
for i=1:N
    eq.eq21.Lc=inp.L-eq.eq10.LcbarArray{i};
    eq.eq21.LcArray{i}=eq.eq21.Lc;
end
 eq.eq21.Lcmatrix=cell2mat(eq.eq21.LcArray);
  eq.eq21.Lcmatrixsum=sum(eq.eq21.Lcmatrix);
  
   % example is following
 % eq.eq21.LcArray2=eq.eq21.LcArray{2}

eq.eq21.LminsLc=inp.L-eq.eq21.Lc;
eq.eq21.ReimpArray=cell(1,((1+(N-1))*(N-1))/2);
for i=1:N
    eq.eq21.Lc=inp.L-eq.eq10.LcbarArray{i};
    eq.eq21.LcArray{i}=eq.eq21.Lc;
    eq.eq21.LminsLc=inp.L-eq.eq21.Lc;
    eq.eq21.Reimp=diag(inp.inp.qArray{i})*eq.eq21.LminsLc*eq.eq11.YcArray{i};
    eq.eq21.ReimpArray{i}=eq.eq21.Reimp;
end
eq.eq21.Reimpmatrix=cell2mat(eq.eq21.ReimpArray);

  %eq.eq21.ReimpArray1= eq.eq21.ReimpArray(1:3);
  %eq.eq21.Reimpmatrixsum=sum(eq.eq21.Reimpmatrix);