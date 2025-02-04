clear all,

N=67; %  Number of countries in the table
n=45; % Number of sectors in the table

%%
%z MATRIX Satellite extension for intermediate sectors
Z=xlsread('E:\CBAN\final demand compent\ICIO2021_2018_11_baseline.xlsx','Sheet1','B2:DKZ3016');
Z(Z==0)=0.000001;

%[output1_Z,output2_Z]=eachConZ(Z);%%405*405


%% Gross output array
inp.X=xlsread('E:\CBAN\final demand compent\ICIO2021_2018_11_baseline.xlsx','Sheet1','B3265:DKZ3265');
inp.X(inp.X==0)=0.000001;  
X=inp.X

inp.VA=xlsread('E:\CBAN\final demand compent\ICIO2021_2018_11_baseline.xlsx','Sheet1','B3264:EHK3264');

%%
%FINAL DEMAND FINAL DEMAND Final demand matrix.
        % In the current version, all components of final demand (household cons,
        % non-profit serving hh, government cons, capital formation, 
        % net stocks and inventories, acquisition less disposal of valuables) 
        % are aggregated into one final demand array per country
INTL.FD2=xlsread('E:\CBAN\final demand compent\ICIO2021_2018_11_baseline.xlsx','Sheet1','DRY2:EHJ3016');

%%Final demand aggregation
num_cpmpent=6;
N=67;
n=45
for i=1:n*N
    for j=1:N*6
        INTL.FD (i,j)= INTL.FD2(i,j);  %GO_P.Y2001 just for the year 2001, you should change when needed,such as GO_P.Y2002
    end
end
Y=[]  ;
for i=1:N
    NN=INTL.FD([1:n*N],[6*i-5:6*i]);
    C=sum(NN')';
    Y=[Y C];
end
Y;
Y(Y==0)=0.000001;

[output1_Y,output2_Y]=eachCon(Y);%405*9

inp.Y=Y;


%% Input Coefficient matrix and Value added per unit output
inp.e=ones(N,1);
inp.A=Z./X;
inp.isizeA=size(inp.A,1);
inp.I=eye(inp.isizeA); 

inp.V=inp.VA./X;
inp.isizeV=size(inp.V,1);
inp.I=eye(inp.isizeV); 
%% Leontief inverse: Compute the matrix of input coefficients and the leontief inverse
inp.L=inv(inp.I-inp.A);
inp.x=inp.L*inp.Y*inp.e;

%% Equation 2
inp.isizeY=size(inp.Y,2);
columnMatricesY = cell(1,inp.isizeY);
for i = 1:N
    columnMatricesY{i} = zeros(n*N, inp.isizeY);
    columnMatricesY{i}(:,i) =inp.Y(:,i);
end

%% Environmental extension qr is the vector of direct externalities coefficients for country r, in which all coefficients associated with countries s ~= r are set to 0.
%%
%EMISSIONS
inp.GHG=xlsread('E:\CBAN\final demand compent\Emissions.xlsx','Sheet1','B3:DKZ3');

inp.q=GHG./X;
% emissions

% A=output2_Z./output1_X; L=inv(eye(size(A))-A); q2=output1_GHG./output1_X;
% LY=L*output2_Y; emissions=abs(diag(q2)*LY);
LY=inp.L*inp.Y;
emissions=diag(inp.q)*LY;
[output1_emission,output2_emission]=eachCon(emissions);

sum_output2_emission=sum(output2_emission,1);
%%
% inp.q=abs(inp.q) Calculate the split index
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



%% Scope 1 Emissions
% direct externalities coefficients q and the final demand in country s, Ys (in our case
% OECD countries final demand imports from non-OECD)
eq.eq4.frsArray=cell(1,((1+(N-1))*(N-1))/2)
for r=1:N
    for s=1:N
        if s~=r
            eq.eq4.frs=diag(inp.inp.qArray{1,r})*columnMatricesY{1,s}*inp.e;
            eq.eq4.frsArray{r}=eq.eq4.frs;
            % eq.eq4.frsArray{r} = abs(eq.eq4.frsArray{r});
        else
            continue
        end
    end
end

%% Scope2 and downstream emissions
% the input cofficient A and the final demand in country s, Ys
eq.eq4.frsArray=cell(1,((1+(N-1))*(N-1))/2)
for r=1:N
    for s=1:N
        if s~=r
            eq.eq4.frs=diag(inp.inp.qArray{1,r})*inp.A*columnMatricesY{1,s}*inp.e;
            eq.eq4.frsArray{r}=eq.eq4.frs;
            % eq.eq4.frsArray{r} = abs(eq.eq4.frsArray{r});
        else
            continue
        end
    end
end

%% Scope 3 Emissions (Direct and Indirect)
% the Leontief inverse L and the final demand in country s, Ys
eq.eq4.frsArray=cell(1,((1+(N-1))*(N-1))/2)
for r=1:N
    for s=1:N
        if s~=r
            eq.eq4.frs=diag(inp.inp.qArray{1,r})*inp.L*columnMatricesY{1,s}*inp.e;
            eq.eq4.frsArray{r}=eq.eq4.frs;
            % eq.eq4.frsArray{r} = abs(eq.eq4.frsArray{r});
        else
            continue
        end
    end
end

%%
% Value added generated in different scopes
%%
% inp.q=abs(inp.q) Calculate the split index
splitIndex = numel(inp.VA) / N;
% Create a cell array to store the split matrices
inp.inp.VArray = cell(1, n*N/splitIndex);
inp.inp.VArray2matrix=cell2mat(inp.inp.VArray);
inp.Vdiag=diag(inp.inp.qVArray2matrix);

% Split the original matrix into N matrices
for i = 1:N
    % Create an empty 1xn matrix
    qSplit = zeros(1, numel(inp.q));
    % Assign elements to the split matrices based on the split index
    qSplit(1+(i-1)*n:splitIndex*i) = inp.q(1+(i-1)*n:splitIndex*i);
    % Add the split matrix to the cell array
    inp.inp.qArray{i} = qSplit;
end

%% Scope 1 value added
% direct externalities coefficients q and the final demand in country s, Ys (in our case
% OECD countries final demand imports from non-OECD)
eq.eq4.frsArray=cell(1,((1+(N-1))*(N-1))/2)
for r=1:N
    for s=1:N
        if s~=r
            eq.eq4.frs=diag(inp.inp.VArray{1,r})*columnMatricesY{1,s}*inp.e;
            eq.eq4.frsArray{r}=eq.eq4.frs;
            % eq.eq4.frsArray{r} = abs(eq.eq4.frsArray{r});
        else
            continue
        end
    end
end

%% Scope2 and downstream value added
% the input cofficient A and the final demand in country s, Ys
eq.eq4.frsArray=cell(1,((1+(N-1))*(N-1))/2)
for r=1:N
    for s=1:N
        if s~=r
            eq.eq4.frs=diag(inp.inp.VArray{1,r})*inp.A*columnMatricesY{1,s}*inp.e;
            eq.eq4.frsArray{r}=eq.eq4.frs;
            % eq.eq4.frsArray{r} = abs(eq.eq4.frsArray{r});
        else
            continue
        end
    end
end

%% Scope 3  Value added (Direct and Indirect)
% the Leontief inverse L and the final demand in country s, Ys
eq.eq4.frsArray=cell(1,((1+(N-1))*(N-1))/2)
for r=1:N
    for s=1:N
        if s~=r
            eq.eq4.frs=diag(inp.inp.VArray{1,r})*inp.L*columnMatricesY{1,s}*inp.e;
            eq.eq4.frsArray{r}=eq.eq4.frs;
            % eq.eq4.frsArray{r} = abs(eq.eq4.frsArray{r});
        else
            continue
        end
    end
end


%%
inp.inp.qArray{i} = abs(inp.inp.qArray{i});
%%[The volume of externalities caused in country r to supply the final demand in country s can be obtained by multiplying the vector of externalities coefficients of country r, qr with
% the Leontief inverse L and the final demand in country s, Ys
eq.eq4.frsArray=cell(1,((1+(N-1))*(N-1))/2)
for r=1:N
    for s=1:N
        if s~=r
            eq.eq4.frs=diag(inp.inp.qArray{1,r})*inp.L*columnMatricesY{1,s}*inp.e;
            eq.eq4.frsArray{r}=eq.eq4.frs;
            % eq.eq4.frsArray{r} = abs(eq.eq4.frsArray{r});
        else
            continue
        end
    end
end

%% Reimports of Emissions and Value added 
% blocks of A L Y V and q note: For emissions, 
FA=cell(S,S);                                         
for i=1:1:S
    for j=1:1:S
    FA{i,j}=inp.A([(i-1)*N+1:i*N],[(j-1)*N+1:j*N]);      
    end
end                                     

L=cell(1,S);                             
for i=1:1:S
L{1,i}=I1/(I1-FA{i,i});
end                                     

FB=cell(S,S);                            
for i=1:1:S
    for j=1:1:S
FB{i,j}=inp.L([(i-1)*N+1:i*N],[(j-1)*N+1:j*N]); 
    end
end                                     



FQ=cell(1,S);                            
for i=1:1:S
    FQ{1,i}=inp.q(1,[(i-1)*N+1:i*N]);      
end                                      

FV=cell(1,S);                            
for i=1:1:S
    FV{1,i}=inp.VA(1,[(i-1)*N+1:i*N]);      
end                                      


           
 FY=cell(S,S)                                      
 for i=1:1:S
     for j=1:1:S
         FY{i,j}=Y([(i-1)*N+1:i*N],[(j-1)*nfd+1:j*nfd])*ones(nfd,1);    
     end
 end



 tt6=cell(S,S);        
 for i=1:1:S
    for j=1:1:S
         if j==i
            tt6{i,j}=zeros(N,1);
         else
            tt6{i,j}= FA{i,j}*FB{j,j}*FY{j,i};    
         end
    end
 end             

 %% Emissions reimports
RE=cell(S,S)
 for i=1:1:S
     for j=1:1:S
         if j==i
             RE{i,j}=zeros(N,1);
         else
           RE{i,j}=(FV{1,i}*L{1,i})'.*tt6{i,j};
         end
     end
 end 

 %% Value added reimports
 RV=cell(S,S)
 for i=1:1:S
     for j=1:1:S
         if j==i
             RV{i,j}=zeros(N,1);
         else
           RV{i,j}=(FV{1,i}*L{1,i})'.*tt6{i,j};
         end
     end
 end 



