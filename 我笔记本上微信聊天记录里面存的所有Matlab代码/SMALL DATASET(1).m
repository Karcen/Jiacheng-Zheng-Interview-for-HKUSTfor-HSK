clear all
%% Basic sets
N=3; % number of countries
n=4; % number of sectors



%% create the matrix we need to use
inp.e=ones(N,1);
inp.z=xlsread('E:\CBAN\TCBA_Karcen','TCBA Example',"C4:N15");
inp.X=xlsread('E:\CBAN\TCBA_Karcen','TCBA Example',"C21:N21");
inp.A=inp.z./inp.X;
inp.isizeA=size(inp.A,1);
inp.I=eye(inp.isizeA);
inp.L=inv(inp.I-inp.A);
inp.Y=xlsread('E:\CBAN\TCBA_Karcen','TCBA Example',"R4:T15");
inp.GHG=xlsread('E:\CBAN\TCBA_Karcen','TCBA Example',"C23:N23");

%% FOR Z
start_id=1;
end_id=n;
zArray=cell(1,N);
for i=1:N
    inp.z2=inp.z;
    inp.z2(start_id:end_id,:)=0;
    inp.z2(:,start_id:end_id)=0;
    start_id=end_id+1;
    end_id=n+end_id;
    zArray{1,i}=inp.z2;
end

%% FOR Y
YArray=cell(1,N);
for i=1:N
    inp.Y2=inp.Y;
    inp.Y2(:,i)=0;
    YArray{1,i}=inp.Y2;
end

%% For X
for i=1:N
    xArray{1,i}=sum(zArray{1,i},2)+sum(YArray{1,i},2);
    xArray{1,i}(xArray{1,i}==0)=0.001;
end

%% FOR GHG
start_id=1;
end_id=n;
GHGArray=cell(1,N);
for i=1:N
    inp.GHG2=inp.GHG;
    inp.GHG2(:,start_id:end_id)=0;
    start_id=end_id+1;
    end_id=n+end_id;
    GHGArray{1,i}=inp.GHG2;
end

%% FOR A
for i=1:N
    aArray{1,i}=zArray{1,i}./xArray{1,i}';
end

%% FOR L
for i=1:N
    LArray{1,i}=inv(eye(size(aArray{1,1}))-aArray{1,i});
end

%% FOR q
for i=1:N
    qArray{1,i}=GHGArray{1,i}./xArray{1,i}';
end

%% q.L.Y
q=inp.GHG./inp.X;
qLY=diag(q)*inp.L*inp.Y;

%% diag(qArray{1,i})*LArray{1,i}*YArray{1,i}

for i=1:N
    qLYbar{1,i}=diag(qArray{1,i})*LArray{1,i}*YArray{1,i};
end

%% x extract qLY
for i=1:N
    HEc{1,i}=qLY-diag(qArray{1,i})*LArray{1,i}*YArray{1,i};
end

%% For Yc
for i=1:N
  YcArray{1,i}=(inp.Y-YArray{1,i});
end


%% For Lc
start_id=1;
end_id=n;
LcArray=cell(1,N);
for i=1:N
    inp.Lc2=inp.L;
    inp.Lc2(start_id:end_id,:)=0;
    inp.Lc2(:,start_id:end_id)=0;
    start_id=end_id+1;
    end_id=n+end_id;
    LcArray{1,i}=inp.Lc2;
end




%% reimport
for i=1:N
    reimport{1,i}=diag(q-qArray{1,i})*(inp.L-LcArray{1,i})*(inp.Y-YArray{1,i})*inp.e;
    reimport_zero=reimport{1,i};
    reimport_zero(start_id:end_id,1)=0;
    reimport_zero_Array{1,i}=reimport_zero;
    start_id=end_id+1;
    end_id=n+end_id;
    reimport_sum{1,i}=sum(reimport_zero,1);
end


%%
%% reimport
start_id=1;
end_id=n;
for i=1:N
%reimport{1,i}=diag(q-qArray{1,i})*(inp.L-LcArray{1,i})*(inp.Y-YArray{1,i})*inp.e;
reimport{1,i}=diag(q-qArray{1,i})*(inp.L-LcArray{1,i})*YcArray{1,i}*inp.e;
reimport_zero=reimport{1,i};
reimport_zero(start_id:end_id,1)=0;
reimport_zero_Array{1,i}=reimport_zero;
start_id=end_id+1;
end_id=n+end_id;
reimport_sum{1,i}=sum(reimport_zero,1);
end


%test

Lc=[];
reimport_test=diag(q-qArray{1,i})*(inp.L-LcArray{1,i})*YcArray{1,i}*inp.e;


%%
%% For Lcbar
start_id=1;
end_id=n;
LcbarArray=cell(1,N);
for i=1:N
inp.Lc2=inp.L;
inp.Lc2(start_id:end_id,:)=0;
inp.Lc2(:,start_id:end_id)=0;
start_id=end_id+1;
end_id=n+end_id;
LcbarArray{1,i}=inp.Lc2;
end
%% For Lc
start_id=1;
end_id=n;
LcArray=cell(1,N);
for i=1:N
LcArray{1,i}=inp.L-LcbarArray{1,i};
end

%%
start_id=1;
end_id=n;
for i=1:N
%reimport{1,i}=diag(q-qArray{1,i})*(inp.L-LcArray{1,i})*(inp.Y-YArray{1,i})*inp.e;
reimport{1,i}=diag(q-qArray{1,i})*(inp.L-LcArray{1,i})*YcArray{1,i}*inp.e;
reimport_zero=reimport{1,i};
reimport_zero(start_id:end_id,1)=0;
reimport_zero_Array{1,i}=reimport_zero;
start_id=end_id+1;
end_id=n+end_id;
reimport_sum{1,i}=sum(reimport_zero,1);
end


%% Basic definitions

%% Equation 1
inp.x=inp.L*inp.Y*inp.e;
%% Equation 2
inp.isizeY=size(inp.Y,2);
columnMatricesY = cell(1,inp.isizeY);
for i = 1:N
    columnMatricesY{i} = zeros(n*N, inp.isizeY);
    columnMatricesY{i}(:,i) =inp.Y(:,i);
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


%% Equation 5 6 (PBAC:these are exported externalities:: for example, externalities in China to meet final demand of EU/US/ROW)
%The sum of the externalities caused in country c to supply the final
%demand in any country corresponds to the Production Based Accounting
%(PBA) measure of the externalities attributable to country c, noted pbac
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
eq.eq5.pbacmatrixsum=sum(eq.eq5.pbacmatrix, 2);

%% Equation 7 8 (CBAC are imported externalities caused in any country to supply the final demand in country c yields the Consumption Based Accounting (CBA)
eq.eq78.cbac=0;
eq.eq78.cbacArray=cell(1,((1+(N-1))*(N-1))/2)
for c=1:N
    for r=1:N
        if r~=c
            eq.eq78.cbac=eq.eq78.cbac+diag(inp.inp.qArray{1,r})*inp.L*columnMatricesY{c}*inp.e;
            % eq.eq56.pbac=eq.eq56.pbac+diag(inp.inp.qArray{1,c})*inp.L*columnMatricesY{1,s}*inp.e;
        end
    end
    eq.eq78.cbacArray{c}=eq.eq78.cbac;
    eq.eq78.cbac=0;
end
eq.eq78.cbacmatrix=cell2mat(eq.eq78.cbacArray);
eq.eq78.cbacmatrixsum=sum(eq.eq78.cbacmatrix,1);

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

%% Equation 10
eq.eq10.LcbarArray=cell(N,1);
for i=1:N
    eq.eq10.Lcbar=inv(inp.I-eq.eq9.AcbarArray{i});
    eq.eq10.LcbarArray{i}= eq.eq10.Lcbar;
end
eq.eq10.Lcbarmatrix=cell2mat(eq.eq10.LcbarArray);
eq.eq10.Lcbarmatrixsum=sum(eq.eq10.Lcbarmatrix);

%% Equation 11:    Then, we define Y¯ c to be the global final demand of commodities outside of country c,
%built from the final demand matrix Yby setting the final demand of
%countryc(c-th column)to zero:
eq.eq11.YcbarArray=cell(1,c);
for i=1:c
    eq.eq11.Ycbar=inp.Y;
    eq.eq11.Ycbar(:,i)=0;
    eq.eq11.YcbarArray{i}=eq.eq11.Ycbar;
end
eq.eq11.Ycbarmatrix=cell2mat(eq.eq11.YcbarArray);
eq.eq11.Ycbarmatrixsum=sum(eq.eq11.Ycbarmatrix);


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


eq.eq13.tbacArray=cell(1,N);
for i=1:N
    eq.eq13.tbac=(eq.eq13.qLY-eq.eq13.qLYArray{i})*inp.e;
    eq.eq13.tbacArray{i}=eq.eq13.tbac;
end

eq.eq13.tbacmatrix=cell2mat(eq.eq13.tbacArray);
eq.eq13.tracmatrixsum=sum(eq.eq13.tbacmatrix);

%% Decomposing the throughflow

%% Equation 14
eq.eq14.loccArray=cell(1,c);
for i=1:c
    eq.eq14.locc=diag(inp.inp.qArray{i})*inp.L*eq.eq11.YcArray{i}*inp.e;
    eq.eq14.loccArray{i}=eq.eq14.locc;
end
eq.eq14.local=cell2mat(eq.eq14.loccArray);
eq.eq14.localsum=sum( eq.eq14.local);

%% Equation 15 imprc=imp_r^c
eq.eq15.imprc=0;
eq.eq15.imprcArray=cell(1,((1+(N-1))*(N-1))/2);
for r=1:c
    eq.eq15.imprc= diag(eq.eq12.qcbarArray{r})*inp.L*eq.eq11.YcArray{r}*inp.e;
    eq.eq15.imprcArray{r}= eq.eq15.imprc;
end
eq.eq15.imports=cell2mat(eq.eq15.imprcArray);
eq.eq15.importssum=sum(eq.eq15.imports);

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

%% Equation 17 expsc=exp_s^c
% t=0; for s=1:N
%     for c=1:N
%         for r=1:N
%             if s~=c & r~=c & s~=r
%                 t=t+1;
%             end
%         end
%     end
% end

% eq.eq17.index=0; eq.eq17.trarsc=0; eq.eq17.each_trarscArray=cell(1,t)
% eq.eq17.trarscArray=cell(1,((1+(N-1))*(N-1))/2);
% eq.eq17.indexArray=cell(1,t) for s=1:N
%     for c=1:N
%         for r=1:N
%             if s~=c & r~=c & s~=r
%                 eq.eq17.trarsc0=diag(inp.inp.qArray{s})*(inp.L-eq.eq10.LcbarArray{c})*eq.eq11.YcArray{r}*inp.e;
%                 eq.eq17.trarsc=eq.eq17.trarsc+diag(inp.inp.qArray{s})*(inp.L-eq.eq10.LcbarArray{c})*eq.eq11.YcArray{r}*inp.e;
%                 eq.eq17.each_trarscArray{eq.eq17.index+1}=
%                 eq.eq17.trarsc0; eq.eq17.index= eq.eq17.index+1;
%                 eq.eq17.indexArray{eq.eq17.index}=[s,c,r];
%             end
%
%         end eq.eq17.trarscArray{s}=eq.eq17.trarsc;
%     end eq.eq17.trarsc=0;
% end eq.eq17.tras=cell2mat(eq.eq17.trarscArray);
% eq.eq17.trarscArraycombined = vertcat(eq.eq17.indexArray,
% eq.eq17.each_trarscArray); eq.eq17.trassum=sum(eq.eq17.tras);

%% Equation 18
% eq.eq18.tbacArray2 = cellfun(@(x, y, z, w) x + abs(y) + abs(z) + abs(w),
% eq.eq14.loccArray, eq.eq15.imprcArray, eq.eq16.expscArray,
% eq.eq17.trarscArray, 'UniformOutput', false);
% eq.eq18.tbac=cell2mat(eq.eq18.tbacArray2);

%% Equation 19
% eq.eq19.pbacArray2=cellfun(@(x,y)x+abs(y),
% eq.eq14.loccArray,eq.eq16.expscArray);
% eq.eq19.cbacArray2=cellfun(@(x,y)x+abs(y),
% eq.eq14.loccArray,eq.eq15.imprcArray);

%% Transported Externalities (Re-exported) OLD CODE####
% eq.eq20.TEArray=cell(1,((1+(N-1))*(N-1))/2); for i=1:N
%     eq.eq20.TE=diag(eq.eq12.qcbarArray{i})*(inp.L-eq.eq10.LcbarArray{i})*eq.eq11.YcbarArray{i}*inp.e;
%     eq.eq20.TEArray{i}=eq.eq20.TE;
% end eq.eq20.TEArray=cell2mat(eq.eq20.TEArray);
% eq.eq20.TEArraysum=sum(eq.eq20.TEArray);

%% Re-imported externalities*
% eq.eq21.LcArray=cell(N,1);
% eq.eq21.Lc=inp.L;
% Lczero=zeros(size(eq.eq21.Lc));
% start_id=1;
% end_id=n;
% for i=1:N
%     Lczero(start_id:end_id,start_id:end_id)=eq.eq21.Lc(start_id:end_id,start_id:end_id);
%     eq.eq21.LcArray{i}=Lczero;
%     start_id=end_id+1;
%     end_id=end_id+n;
%     Lczero=zeros(size(eq.eq21.Lc));
% end
% 
% eq.eq21.LminsLc=inp.L-eq.eq21.Lc;
% eq.eq21.ReimpArray=cell(1,((1+(N-1))*(N-1))/2);
% for i=1:N
%     eq.eq21.Lc=inp.L-eq.eq10.LcbarArray{i};
%     eq.eq21.LcArray{i}=eq.eq21.Lc;
%     eq.eq21.LminsLc=inp.L-eq.eq21.Lc;
%     eq.eq21.Reimp=diag(inp.inp.qArray{i})*eq.eq21.LminsLc*eq.eq11.YcArray{i};
%     eq.eq21.ReimpArray{i}=eq.eq21.Reimp;
% end
% eq.eq21.Reimpmatrix=cell2mat(eq.eq21.ReimpArray);

%% Z MATRIX
start_id=1;
end_id=n;
Z_diag_Array=cell(1,N);
Z_diag_Array_diagsub=cell(1,N);
Zzero=zeros(size(inp.z));
Z_diag_Array_all=zeros(size(inp.z));
for i=1:N
    Zzero(start_id:end_id,start_id:end_id)=inp.z(start_id:end_id,start_id:end_id);
    Z_diag_Array{i}=Zzero;
    start_id=end_id+1;
    end_id=end_id+n;
    Zzero=zeros(size(inp.z));
    Z_diag_Array_all=Z_diag_Array_all+Z_diag_Array{1,i};
end

Z_diag_Array_diagsub= Z_diag_Array;

for i=1:N
    Z_diag_Array_diagsub{i}=diag(diag( Z_diag_Array_diagsub{i}));
end

for i=1:N
    Z_diag_Array_diagsub{i}=diag(diag( Z_diag_Array_diagsub{i}));
end

Z_diag_zero=inp.z-Z_diag_Array_all;

start_id=1;
end_id=n;
for i=1:N
    for j=1:n*N
        sum_row_of_each_country(j,i)=sum(Z_diag_zero(j,start_id:end_id));
    end
    start_id=end_id+1;
    end_id=end_id+n;
end

%% L MATRIX
start_id=1;
end_id=n;
L_diag_Array=cell(1,N);
L_diag_Array_diagsub=cell(1,N);
Lzero=zeros(size(inp.L));
L_diag_Array_all=zeros(size(inp.L));
for i=1:N
    Lzero(start_id:end_id,start_id:end_id)=inp.L(start_id:end_id,start_id:end_id);
    L_diag_Array{i}=Lzero;
    start_id=end_id+1;
    end_id=end_id+n;
    Lzero=zeros(size(inp.L));
    L_diag_Array_all=L_diag_Array_all+L_diag_Array{1,i};
end

L_diag_Array_diagsub= L_diag_Array;
for i=1:N
    L_diag_Array_diagsub{i}=diag(diag( L_diag_Array_diagsub{i}));
end

% OFF DIAG
start_id=1;
end_id=n;
L_diag_Array_offdiagsub=cell(1,N);
for i=1:N
    L_diag_Array_offdiagsub{i}=inp.L(start_id:end_id,start_id:end_id)-diag(diag(inp.L(start_id:end_id,start_id:end_id)));
    start_id=end_id+1;
    end_id=end_id+n;
end


for i=1:N
    L_diag_Array_diagsub{i}=diag(diag( L_diag_Array_diagsub{i}));
end

L_diag_zero=inp.z-L_diag_Array_all;

start_id=1;
end_id=n;
for i=1:N
    for j=1:n*N
        sum_row_of_each_country(j,i)=sum(L_diag_zero(j,start_id:end_id));
    end
    start_id=end_id+1;
    end_id=end_id+n;
end

%% Y matrix
start_id=1;
end_id=n;
Y_diag_zero=inp.Y;
for i=1:N
    Y_diag_zero(start_id:end_id,i)=0;
    start_id=end_id+1;
    end_id=end_id+n;
end

FinplusInter=Y_diag_zero+sum_row_of_each_country;


diag_final_Array_zero=cell(n*N,1);
start_id=1;
end_id=n;
diag_final_Array_zero=FinplusInter;
for i=1:N
    diag_final_Array_zero(start_id:end_id,i)=0;
    start_id=end_id+1;
    end_id=end_id+n;
end

% make a diag matrix Extract the matrix
diag_final_Array = cell(1,(size(diag_final_Array_zero,1)/n)^2);
k = 1;
for i = 1 : size(diag_final_Array_zero,1)/n
    for j = 1 : N
        start_id = (i - 1) * n + 1;
        end_id = start_id + n - 1;
        if end_id <= size(diag_final_Array_zero,1)
            diag_final_Array{1,k} = diag(diag_final_Array_zero(start_id:end_id, j));
        else
            diag_final_Array{1,k} = diag(diag_final_Array_zero(start_id:end, j));
        end
        k = k + 1;
    end
end
diag_final_Array=reshape(diag_final_Array,[],N);
diag_final_Array=diag_final_Array';

start_id=1;
end_id=n;
Final_diag_Array=cell(1,N);
for i=1:N
    Final_diag_Array{i}=FinplusInter(start_id:end_id,:);
    start_id=end_id+1;
    end_id=end_id+n;
end

for i = 1:N
    Final_diag_Array{i} = reshape(Final_diag_Array{i}, [], 1);
end

for i = 1:N
    Final_diag_Array{i} = diag(Final_diag_Array{i});
end

EXGR_DEM_cip_Array=cell(N,1);
for i=1:N
    EXGR_DEM_cip_Array{i,1}=diag(inp.inp.qArray{1,i})*L_diag_Array{1,i}*Final_diag_Array{1,i};
end

EXGR_DEM_cip_matrix=cell2mat(EXGR_DEM_cip_Array);
EXGR_DEM_cip_matrix(EXGR_DEM_cip_matrix==0)=[];
EXGR_DEM_cip_matrix=reshape(EXGR_DEM_cip_matrix,[],n*N);
EXGR_DEM_cip_sum=sum(EXGR_DEM_cip_matrix,2);
EXGR_DEM_cip_sum(EXGR_DEM_cip_sum==0)=[];
diagqarray=diag(inp.inp.qArray{1,1});

% CONVERT EXGR_DEM_cip_matrix 4*12 TO 12*12
start_id=1;
end_id=n;
for i=1:N
    EXGR_DEM_cip_matrix_diag(start_id:end_id,start_id:end_id)= EXGR_DEM_cip_matrix(:,start_id:end_id);
    start_id=end_id+1;
    end_id=n+end_id;
end
%% EXGR_DEM_cip  Eq.12
% EXGR_DEM_cip_A
EXGR_DEM_cip_block_Array=cell(N,1);

for i=1:N
    EXGR_DEM_cip_block=EXGR_DEM_cip_Array{i,1};
    blockRows = repmat([n], 1, N);
    blockCols = repmat([n], 1, N);
    EXGR_DEM_cip_block=mat2cell(EXGR_DEM_cip_matrix_diag,blockRows, blockCols);
    EXGR_DEM_cip_block_Array{i}=EXGR_DEM_cip_block;
end

EXGR_DEM_sum=cell(N*N,1);
k=1;
for i=1:N
    for j=1:N
        EXGR_DEM_sum{k,1}=sum(EXGR_DEM_cip_block_Array{1,1}{i,j},2);
        k=k+1;
    end
end
EXGR_DEM_sum=reshape(EXGR_DEM_sum,[],N)';


%% EXGR_EMD_ci Eq.13

sub_inp.qArray=cell(1,N);

for i=1:N
    sub_inp.q=inp.inp.qArray{1,i};
    sub_inp.q(sub_inp.q==0)=[];
    sub_inp.qArray{i}=sub_inp.q;
end

sub_L_Array=cell(1,N);
for i=1:N
    sub_L=L_diag_Array_diagsub{1,i};
    sub_L(sub_L==0)=[];
    sub_L_Array{i}=sub_L;
end


EXGR_EMD_ci_Array=cell(N*N,1);
k=1;
for i=1:N
    for j=1:N
        EXGR_EMD_ci_Array{k,1}=diag(sub_inp.qArray{i})*diag(sub_L_Array{i})*diag_final_Array{i,j}; % equation13
        k=k+1;
    end
end


EXGR_EMD_ci_Array=reshape(EXGR_EMD_ci_Array,[],N) ;
EXGR_EMD_ci_Array = EXGR_EMD_ci_Array(~cellfun(@isempty, EXGR_EMD_ci_Array));
% EXGR_EMI_ci_matrix=cell2mat(EXGR_EMI_ci_Array);

EXGR_EMD_ci_matrix=cell2mat(EXGR_EMD_ci_Array);
EXGR_EMD_ci_sum=sum(EXGR_EMD_ci_matrix,2);
EXGR_EMD_ci_sum(EXGR_EMD_ci_sum==0)=[];

%% EXGR_EMI_ci Eq.14
EXGR_EMI_ci_Array=cell(n*n,1);
k=1;
for i=1:N
    for j=1:N
        EXGR_EMI_ci_Array{k,1}=diag(sub_inp.qArray{i})*(L_diag_Array_offdiagsub{i})*diag_final_Array{i,j}; % equation13
        k=k+1;
    end
end

EXGR_EMI_ci_Array=reshape(EXGR_EMI_ci_Array,[],1) ;
EXGR_EMI_ci_Array= EXGR_EMI_ci_Array(~cellfun(@isempty, EXGR_EMI_ci_Array));
EXGR_EMI_ci_matrix=cell2mat(EXGR_EMI_ci_Array);
EXGR_EMI_ci_sum=sum(EXGR_EMI_ci_matrix,2);
EXGR_EMI_ci_sum(EXGR_EMI_ci_sum==0)=[];

%% SUM of EXGR_EMD_ci_Array EXGR_EMI_ci_Array Eq.15
EXGR_SUM_EMI_EMD=cellfun(@(x, y) x + y, EXGR_EMD_ci_Array, EXGR_EMI_ci_Array , 'UniformOutput', false);
EXGR_SUM_EMI_EMD=reshape(EXGR_SUM_EMI_EMD,[],N)';

% reimport
for i=1:N
    for j=1:N
        if i~=j
            reimports{i,j}=EXGR_DEM_cip_block{i,i}-EXGR_SUM_EMI_EMD{i,j};
        end
    end
end

% sum reimports row
for i=1:N
    for j=1:N
        if i~=j
            sum_reimport_row{i,j}=sum(reimports{i,j},2);
        end
    end
end



%% For human beings

Sum_reimport_index = cell(size(sum_reimport_row));

for row = 1:size(Sum_reimport_index, 1)
    for col = 1:size(Sum_reimport_index, 2)
        index = ['(' num2str(row) ' to ' num2str(col) ')'];
        Sum_reimport_index{row, col} = [Sum_reimport_index{row, col} ' ' index];
    end
end


rows = size(Sum_reimport_index, 1) + size(sum_reimport_row, 1);
cols = size(Sum_reimport_index, 2);
 

for i = 1:rows
    if mod(i, 2) == 1 
        Reimport_result(i, :) = Sum_reimport_index((i+1)/2, :);
    else 
        Reimport_result(i, :) = sum_reimport_row(i/2, :);
    end
end

