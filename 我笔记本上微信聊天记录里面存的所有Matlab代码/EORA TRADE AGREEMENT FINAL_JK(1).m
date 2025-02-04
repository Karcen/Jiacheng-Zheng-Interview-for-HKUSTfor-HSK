clear all

S = 189;   % Number of countries
N = 26;    % Number of sectors
nfd = 6;   % Number of final demand categories

% Define the base directory
baseDir = 'E:\EORA\';

% Get a list of all directories in the base directory that match the pattern "Eora26_1990_bp" to "Eora26_2021_bp"
dirs = dir(fullfile(baseDir, 'Eora26_*_bp'));

% Loop through each directory
for i = 1:length(dirs)
    currentDir = fullfile(baseDir, dirs(i).name);
    
    % Extract the year from the directory name (e.g., "Eora26_1990_bp" -> "1990")
    year = regexp(dirs(i).name, '\d{4}', 'match', 'once');
    
    % Change directory to the current folder
    cd(currentDir);
    
    % Dynamically generate the file names based on the year
    Z_file = ['Eora26_' year '_bp_T.txt'];
    FD_file = ['Eora26_' year '_bp_FD.txt'];
    V_file = ['Eora26_' year '_bp_VA.txt'];
    
    % Read the files for Z, FD, and V matrices
    Z = readmatrix(Z_file);
    FD = readmatrix(FD_file);
    V = readmatrix(V_file);
    
    % Optional: display the year being processed
    fprintf('Processed data for year: %s\n', year);



FD1 = squeeze(sum(reshape(FD,S*N+1,nfd,[]),2));
FD1(:, end) = [];  % Delete the last column
FD1(end, :) = [];  % Delete the last row
%
VA=sum(V,1);                  % 取增加值, confirm value added in matlab and excel
VA(:, end) = [];  % Delete the last column

for i=1:S
VA_blocks(1,i)=sum(VA(1,(i-1)*N+1:i*N),2);
% VA_blocks{1,i}=sum(VA(1,(i-1)*N:i*N),2);
end

VA_Eora=BRI_EORA_VAD(VA_blocks)';

AA=Z;                 %取中间投入矩阵816*816 
% Remove the last row and column
AA(:, end) = [];  % Delete the last column
AA(end, :) = [];  % Delete the last row


TI=sum(AA,1)+VA;    %取总投入 Total Input

A=AA./TI; 
A(isnan(A))=0;
A(isinf(A))=0; 
% vtest=1-sum(A);  %

v = VA./TI;
v(isnan(v))=0;
v(isinf(v))=0;



I=eye(S*N);                          %单位矩阵,单位矩阵生成函数
I1=eye(N);                           %部门数的单位矩阵
B=I/(I-A);                          %求列奥列夫逆矩阵，这个矩阵是一个全局的逆矩阵。


%% blocks of A L Y V
FA=cell(S,S);                                         % 生成一个48*48**3的单元矩阵。celldisp
for i=1:1:S
    for j=1:1:S
    FA{i,j}=A([(i-1)*N+1:i*N],[(j-1)*N+1:j*N]);      %取A中的出j对i国家（区域）的直接消耗系数矩阵。
    end
end                                     %提出分块矩阵
% celldisp(FA, 'direct matrix')           %显示分块直接消耗系数矩阵

L=cell(1,S);                             %S个国家（区域）的局部逆矩阵。一个很好的矩阵。
for i=1:1:S
L{1,i}=I1/(I1-FA{i,i});
end                                     %求局部逆矩阵中的单元
% celldisp(L, 'Local inverse  matrix')    %显示局部逆矩阵的单元


FB=cell(S,S);                            % 生成一个48*48的单元组。celldisp
for i=1:1:S
    for j=1:1:S
FB{i,j}=B([(i-1)*N+1:i*N],[(j-1)*N+1:j*N]);  %提取分块矩阵，取B中的j对i国家的完全消耗系数矩阵。
    end
end                                     
% celldisp(FB, 'complete matrix')               %显示分块完全消耗系数矩阵


FV=cell(1,S);                               %对增加值率分块。
for i=1:1:S
    FV{1,i}=v(1,[(i-1)*N+1:i*N]);      
end                                        %循环获取增加值率分块矩阵。
% celldisp(FV,'value added rate')            %显示增加值率分块矩阵。

%因为最终需求矩阵分为消费、投资和存货，每一国家（区域）对应3列。
FD2=FD;
FD2(:, end) = [];  % Delete the last column
FD2(end, :) = [];  % Delete the last row


Y=FD2;             %提出最终需求矩阵。     
 FY=cell(S,S)                              %生成一个3*3的单元矩阵。celldisp               
 for i=1:1:S
     for j=1:1:S
         FY{i,j}=Y([(i-1)*N+1:i*N],[(j-1)*nfd+1:j*nfd])*ones(nfd,1);   %Finaldemand 由于提取后，最终需求矩阵的数据重新排列后，注意列的选取。 
     end
 end
 % celldisp(FY,'final demand')                                     %循环语句计算最终需求分块矩阵，并显示。
 
 
 
 %方法一，直接从中间投入矩阵提取双边国家中间产品出口矩阵。出口部门对其他国家中间品出口。
 %In method 1, the export matrix of intermediate products of bilateral countries is extracted directly from the intermediate input matrix. 
 % The export sector exports intermediate goods to other countries.
 DEI=cell(S,S)    %定义双边中间投入单元。
  for i=1:1:S
    for j=1:1:S
         if j==i
            DEI{i,j}=[ ] ;
         else
            DEI{i,j}=Z([(i-1)*N+1:i*N],[(j-1)*N+1:j*N ])*ones(N,1);  %i 国出口到j国的分行业的中间产品。
         end
    end
  end
 % celldisp(DEI,'Intermediate export')
 
 
%总出口直接从全球投入矩阵中取。TOTAL INT + TOTAL FINAL
 TE=cell(S,1)
 for i=1:1:S
     TE{i,1}=0;
     for j=1:1:S
         if j==i
             TE{i,1}=TE{i,1}+zeros(N,1);
         else
         TE{i,1}=TE{i,1}+DEI{i,j}+FY{i,j};
         end
     end
 end
 % celldisp(TE,'total export')
 % csvwrite('totalexportwiod2011.csv',TE) 
 
%方法2，利用逆矩阵计算。中间投入的ABY分解。 

 
  EI=cell(S,S);                         %定义双边国家中间产品出口向量。
       
 %Term2 DVA INT:intermediate exports to the direct importer and is absorbed there.

 % 从最终需求矩阵计算中间产品出口  计算i国到j国的中间产品出口。
 tt2=cell(S,S)              %j国生产的自己消费的最终产品，引致的对i国的中间产品进口。
 for i=1:1:S
    for j=1:1:S
         if j==i
            tt2{i,j}=zeros(N,1);
         else
             tt2{i,j}=FA{i,j}*FB{j,j}*FY{j,j};
         end
    end
 end
 %celldisp(tt2)
            
  % Term3:The third country t consumes its own final products to produce intermediate goods in Country j, resulting in the import of intermediate goods to country i.           
   tt3=cell(S,S)              %第三方国家t消费自己的最终产品对j国生产中间品，引致的对i国的中间产品进口。
 for i=1:1:S
    for j=1:1:S
         if j==i
            tt3{i,j}=zeros(N,1); 
         else
            tt3{i,j}=zeros(N,1);
             for t=1:1:S 
             tt3{i,j}=tt3{i,j}+FA{i,j}*FB{j,t}*FY{t,t};
             end
             tt3{i,j}=tt3{i,j}-FA{i,j}*FB{j,i}*FY{i,i}-FA{i,j}*FB{j,j}*FY{j,j};
         end
    end
 end
  % celldisp(tt3)                  
             
 tt4=cell(S,S);              %j生产的产品出口到第三方国家t作为最终消费，引致的对i国的中间产品进口。
 for i=1:1:S
    for j=1:1:S
         if j==i
            tt4{i,j}=zeros(N,1);
         else 
             tt4{i,j}= zeros(N,1);
             for t=1:1:S 
                 tt4{i,j}=tt4{i,j}+FA{i,j}*FB{j,j}*FY{j,t};
             end
             tt4{i,j}=tt4{i,j}-FA{i,j}*FB{j,j}*FY{j,i}-FA{i,j}*FB{j,j}*FY{j,j};
         end
    end
 end                        
% celldisp(tt4)
 
%这个地方相对复杂，需要仔细思考一下。
  tt5=cell(S,S);                   %    引致的对i国的中间产品进口。
  
  FYt=cell(S,1);                     %   最终需求合计（包括国内和国外)。
  for t=1:1:S
      FYt{t,1}=zeros(N,1);
      for u=1:1:S
          FYt{t,1}=FYt{t,1}+FY{t,u}; % FY is Finaldemand, make blocks
      end
  end
  
% FY_MAT=cell2mat(FY);

 for i=1:1:S
    for j=1:1:S
         if j==i
            tt5{i,j}=zeros(N,1);
         else
             tt5{i,j}= zeros(N,1);
             for t=1:1:S
                 if  t==i || t==j
                    tt5{i,j}=tt5{i,j}+zeros(N,1);
                 else
                     tt5{i,j}=tt5{i,j}+FA{i,j}*FB{j,t}*(FYt{t,1}-FY{t,i}-FY{t,t});  % intermediate goods is from country 
%  intermediate exports used by Country r to produce intermediates that it re-exports to third Country t for production of final goods exports that are 
% shipped to other countries (including the direct importer, Country r) except Country s.
                 end
             end
         end
    end 
 end
 
 celldisp(tt5)


 tt6=cell(S,S);        %i出口到j国的中间产品，用来生产j国的产品并且作为i国的最终消费。     
 for i=1:1:S
    for j=1:1:S
         if j==i
            tt6{i,j}=zeros(N,1);
         else
            tt6{i,j}= FA{i,j}*FB{j,j}*FY{j,i};    
         end
    end
 end             
 celldisp(tt6)


  tt7=cell(S,S);              %        引致的对i国的中间产品进口。
 for i=1:1:S
    for j=1:1:S
         if j==i
            tt7{i,j}=zeros(N,1);
         else
            tt7{i,j}= zeros(N,1);
             for t=1:1:S 
                tt7{i,j}=tt7{i,j}+FA{i,j}*FB{j,t}*FY{t,i}; 
             end
             tt7{i,j}=tt7{i,j}-FA{i,j}*FB{j,j}*FY{j,i}-FA{i,j}*FB{j,i}*FY{i,i};
         end
    end
 end             
 celldisp(tt7)


 tt8=cell(S,S);              %        引致的对i国的中间产品进口。
 for i=1:1:S
    for j=1:1:S
         if j==i
            tt8{i,j}=zeros(N,1); 
         else
           tt8{i,j}=FA{i,j}*FB{j,i}*FY{i,i};    
         end
    end
 end             
 celldisp(tt8)


  tt9=cell(S,S);              %        引致的对i国的中间产品进口。
 for i=1:1:S
    for j=1:1:S
         if j==i
            tt9{i,j}=zeros(N,1);
         else
              tt9{i,j}=zeros(N,1); 
             for t=1:1:S    
               tt9{i,j}=tt9{i,j}+FA{i,j}*FB{j,i}*FY{i,t};  
              end
             tt9{i,j}=tt9{i,j}-FA{i,j}*FB{j,i}*FY{i,i};
         end
    end
 end             
% celldisp(tt9)
 
 
 for i=1:1:S
    for j=1:1:S
         if j==i
            EI{i,j}=[ ]; 
         else
          EI{i,j}=tt2{i,j}+tt3{i,j}+tt4{i,j}+tt5{i,j}+tt6{i,j}+tt7{i,j}+tt8{i,j}+tt9{i,j};  
         end
    end
 end             
% celldisp(EI)
 
CheckEI=cell(S,S);

for i=1:1:S
    for j=1:1:S
         if j==i
            CheckEI{i,j}=[ ] ;
         else
          CheckEI{i,j}=DEI{i,j}-EI{i,j}; 
         end
    end
 end             
 celldisp(CheckEI)
 
 %中间投入利用局部逆矩阵计算
 LEI=cell(S,S);
 for i=1:1:S
     for j=1:1:S
         if j==i
             LEI{i,j}=[ ];
         else
          LEI{i,j}=FA{i,j}*L{1,j}*FY{j,j}+FA{i,j}*L{1,j}*TE{j,1};
         end
     end
 end
 
% celldisp(LEI,'total bilateral export')

 
 
 %双边国家的总出口的16项分解公式计算——wwz分解法
 T1=cell(S,S)
 for i=1:1:S
     for j=1:1:S
         if j==i
             T1{i,j}=zeros(N,1);
         else
           T1{i,j}=(FV{1,i}*FB{i,i})'.*FY{i,j};
         end
     end
 end 
% celldisp(T1)
% csvwrite('T1.csv',T1)

 
 T2=cell(S,S)
 for i=1:1:S
     for j=1:1:S
         if j==i
             T2{i,j}=zeros(N,1);
         else
           T2{i,j}=(FV{1,i}*L{1,i})'.*tt2{i,j};
         end
     end
 end 
% celldisp(T2)
% csvwrite('T2.csv',T2) 
 
 T3=cell(S,S)
 for i=1:1:S
     for j=1:1:S
         if j==i
             T3{i,j}=zeros(N,1);
         else
           T3{i,j}=(FV{1,i}*L{1,i})'.*tt3{i,j};
         end
     end
 end 
 %celldisp(T3)
% csvwrite('T3.csv',T3) 

 T4=cell(S,S)
 for i=1:1:S
     for j=1:1:S
         if j==i
             T4{i,j}=zeros(N,1);
         else
           T4{i,j}=(FV{1,i}*L{1,i})'.*tt4{i,j};
         end
     end
 end 
% celldisp(T4)
 % csvwrite('T4.csv',T4) 
 
 
  T5=cell(S,S)
 for i=1:1:S
     for j=1:1:S
         if j==i
             T5{i,j}=zeros(N,1);
         else
           T5{i,j}=(FV{1,i}*L{1,i})'.*tt5{i,j};
         end
     end
 end 
% celldisp(T5)
  % csvwrite('T5.csv',T5) 
 
   T6=cell(S,S)
 for i=1:1:S
     for j=1:1:S
         if j==i
             T6{i,j}=zeros(N,1);
         else
           T6{i,j}=(FV{1,i}*L{1,i})'.*tt6{i,j};
         end
     end
 end 
% celldisp(T6)
   % csvwrite('T6.csv',T6)



  T7=cell(S,S)
 for i=1:1:S
     for j=1:1:S
         if j==i
             T7{i,j}=zeros(N,1);
         else
           T7{i,j}=(FV{1,i}*L{1,i})'.*tt7{i,j};
         end
     end
 end 
% celldisp(T7)
  % csvwrite('T7.csv',T7)


 T8=cell(S,S)
 for i=1:1:S
     for j=1:1:S
         if j==i
             T8{i,j}=zeros(N,1);
         else
           T8{i,j}=(FV{1,i}*L{1,i})'.*tt8{i,j};
         end
     end
 end 
 %celldisp(T8)
  % csvwrite('T8.csv',T8)
 
 
  T9=cell(S,S)
 for i=1:1:S
     for j=1:1:S
         if j==i
             T9{i,j}=zeros(N,1);
         else
           T9{i,j}=(FV{1,i}*L{1,i})'.*tt9{i,j};
         end
     end
 end 
 %celldisp(T9)
  % csvwrite('T9.csv',T9)
 
 
 
   T10=cell(S,S)
 for i=1:1:S
     for j=1:1:S
         if j==i
             T10{i,j}=zeros(N,1);
         else
           T10{i,j}=(FV{1,i}*FB{i,i}-FV{1,i}*L{1,i})'.*DEI{i,j};
         end
     end
 end 
% celldisp(T10)
  % csvwrite('T10.csv',T10)


  T11=cell(S,S)
 for i=1:1:S
     for j=1:1:S
         if j==i
             T11{i,j}=zeros(N,1);
         else
           T11{i,j}=(FV{1,j}*FB{j,i})'.*FY{i,j};
         end
     end
 end 
% celldisp(T11)
% csvwrite('T11.csv',T11)


 
  T12=cell(S,S)
 for i=1:1:S
     for j=1:1:S
         if j==i
             T12{i,j}=zeros(N,1);
         else
           T12{i,j}=(FV{1,j}*FB{j,i})'.*(FA{i,j}*L{1,j}*FY{j,j});
         end
     end
 end 
% celldisp(T12)
% csvwrite('T12.csv',T12) 
 
  
  T13=cell(S,S)
 for i=1:1:S
     for j=1:1:S
         if j==i
             T13{i,j}=zeros(N,1);
         else
           T13{i,j}=(FV{1,j}*FB{j,i})'.*(FA{i,j}*L{1,j}*TE{j,1});
         end
     end
 end 
 %celldisp(T13)
 % csvwrite('T13.csv',T13) 
 
%计算其他国家在出口中体现的增加值。 
 ttother=cell(S,S)
 for  i=1:1:S
     for j=1:1:S 
        if j==i
             ttother{i,j}=[];
        else
            ttother{i,j}=zeros(1,N);
            for t=1:1:S
            ttother{i,j}= ttother{i,j}+FV{1,t}*FB{t,i};
            end
            ttother{i,j}=ttother{i,j}-FV{1,i}*FB{i,i}-FV{1,j}*FB{j,i};
        end
     end
 end
 
 %celldisp(ttother)
 
  T14=cell(S,S)
 for i=1:1:S
     for j=1:1:S
         if j==i
             T14{i,j}=zeros(N,1);
         else
           T14{i,j}=(ttother{i,j})'.*FY{i,j};
         end
     end
 end 
 % celldisp(T14) 
 % csvwrite('T14.csv',T14) 
 
 
   T15=cell(S,S)
 for i=1:1:S
     for j=1:1:S
         if j==i
             T15{i,j}=zeros(N,1);
         else
           T15{i,j}=(ttother{i,j})'.*(FA{i,j}*L{1,j}*FY{j,j});
         end
     end
 end 
% celldisp(T15) 
 % csvwrite('T15.csv',T15) 


    T16=cell(S,S)
 for i=1:1:S
     for j=1:1:S
         if j==i
             T16{i,j}=zeros(N,1);
         else
           T16{i,j}=(ttother{i,j})'.*(FA{i,j}*L{1,j}*TE{j,1});
         end
     end
 end 
 %celldisp(T16) 
 % csvwrite('T16.csv',T16) 
 
 %%计算i到j国的产业总出口，check是否与总出口一致。
 
 SFTE=cell(S,S)
 CheckSTE=cell(S,S)
 
 for i=1:1:S
     for j=1:1:S
         if j==i
             SFTE{i,j}=[];
         else 
             
             SFTE{i,j}=T1{i,j}+T2{i,j}+T3{i,j}+T4{i,j}+T5{i,j}+T6{i,j}+T7{i,j}+T8{i,j}+T9{i,j}+T10{i,j}+T11{i,j}+T12{i,j}+T13{i,j}+T14{i,j}+T15{i,j}+T16{i,j};
         end
     end
 end
 
  for i=1:1:S
     for j=1:1:S
         if j==i
             CheckSTE{i,j}=[];
         else 
          CheckSTE{i,j}=DEI{i,j}+FY{i,j}-SFTE{i,j};
         end
     end
 end

% celldisp(SFTE)
 celldisp(CheckSTE)
 % csvwrite('CHECKva2011.csv',CheckSTE) 
Term1=cell2mat(T1); 
Term2=cell2mat(T2); %%元细胞转为矩阵的命令
Term3=cell2mat(T3);
Term4=cell2mat(T4);
Term5=cell2mat(T5);
Term6=cell2mat(T6);
Term7=cell2mat(T7); %%元细胞转为矩阵的命令
Term8=cell2mat(T8);
Term9=cell2mat(T9);
Term10=cell2mat(T10);
Term11=cell2mat(T11);
Term12=cell2mat(T12); %%元细胞转为矩阵的命令
Term13=cell2mat(T13);
Term14=cell2mat(T14);
Term15=cell2mat(T15);
Term16=cell2mat(T16);
VAX_G=Term1+Term2+Term3+Term4+Term5;
% csvwrite('VAX_G2011.csv',VAX_G)  %Domestic value-added absorbed abroad

DVA_FIN=Term1;
% csvwrite('DVA_FIN2011.csv',DVA_FIN) 

DVA_INTrex=Term3+Term4+Term5;   %REX
% csvwrite('DVA_INTrex2011.csv',DVA_INTrex) 

RDV_G=Term6+Term7+Term8;%      REF
% csvwrite('RDV_G2011.csv',RDV_G) 

DDC=Term9+Term10;
% csvwrite('DDC2011.csv',DDC) 

FVA_FIN=Term11+Term12;
% csvwrite('FVA_FIN2011.csv',FVA_FIN) 

FVA_INT=Term13+Term14; 
% csvwrite('FVA_INT2011.csv',FVA_INT) 

FDC=Term15+Term16; 
% csvwrite('FDC2011.csv',FDC)
PDC=FDC+DDC;
% csvwrite('PDC2011.csv',PDC)

%% For Trade(Int+Fin)

% Initialize the result matrix (189 x 189)
Results.Trade.INT = zeros(S, S);

% Loop through the blocks of 26*26
for i = 1:S
    for j = 1:S
        % Select the 26x26 block for countries i and j
        AA_submatrices = AA((i-1)*N+1:i*N, (j-1)*N+1:j*N);
        
        % Sum all elements in the 26x26 block and store in B(i,j)
        Results.Trade.INT(i, j) = sum(AA_submatrices(:));
    end
end


% Initialize the result matrix (189 x 189)
Results.Trade.FIN = zeros(S, S);

% Loop over each country (for rows) and sum the 26-sector blocks
for i = 1:S
    % Select the block of rows corresponding to sectors for country i
    sector_rows = (i-1)*N + 1 : i*N;  % This selects rows i*N-N+1 to i*N

    % Sum the sectors for each destination country
    Results.Trade.FIN(i, :) = sum(FD1(sector_rows, :), 1);  % Sum over the rows (sectors)
end

for i=1:S
Results.Trade.INT(i,i)=0;
Results.Trade.FIN(i,i)=0;
end


Results.Trade.Total_Trade=Results.Trade.INT+Results.Trade.FIN;


%% For imports
Results.IMP.INT=Results.Trade.INT;
Results.IMP.INT = reshape(Results.IMP.INT, [], 1);

Results.IMP.FIN=Results.Trade.FIN;
Results.IMP.FIN = reshape(Results.IMP.FIN, [], 1);
%% For exports
Results.EXP.INT=Results.Trade.INT';
Results.EXP.INT = reshape(Results.EXP.INT, [], 1);

Results.EXP.FIN=Results.Trade.FIN';
Results.EXP.FIN = reshape(Results.EXP.FIN, [], 1);

for i=1:S
    Results.Trade.Total_Trade(i,i)=0;
end

Results.Trade.IMP=reshape(Results.Trade.Total_Trade,[],1);
Results.Trade.EXP=reshape(Results.Trade.Total_Trade',[],1);
%%


% % Assuming your matrix is named A (4914 x 4914)
% S = 189;  % Number of countries
% N = 26;   % Number of sectors
% 
% % Initialize the result matrix (4914 x 189)
% B = zeros(4914, S);
% 
% % Loop over each block of 26 columns and sum them
% for i = 1:S
%     % Sum every block of 26 columns
%     B(:, i) = sum(A(:, (i-1)*N+1 : i*N), 2);
% end



%%
DVA_J=VAX_G+RDV_G;%Domestic value added comprises VAX G + RDV G 
VS_J=FVA_FIN+FVA_INT+PDC;%FVA FIN + FVA INT + PDC 
%Vertical Specialization comprises FVA + PDC 
%Gross Export comprises DVA and VS
Gross_Exp=DVA_J+VS_J;

%%
NUM_FGVC=DVA_INTrex+RDV_G;
DEN_BGVC=FVA_FIN+PDC;

%% Sectoral Level
GVC.sector.FGVC=NUM_FGVC./Gross_Exp;
GVC.sector.BGVC=DEN_BGVC./Gross_Exp;

GVC.sector.FGVC(isnan(GVC.sector.FGVC))=0;
GVC.sector.BGVC(isnan(GVC.sector.BGVC))=0;


%% Country Level
% Make row from 4914 to 189
for i=1:S
    VAX_GCL(i,:)=sum(VAX_G((i-1)*N+1:i*N,:),1);
    RDV_GCL(i,:)=sum(RDV_G((i-1)*N+1:i*N,:),1);
    FVA_FINCL(i,:)=sum(FVA_FIN((i-1)*N+1:i*N,:),1);
    FVA_INTCL(i,:)=sum(FVA_INT((i-1)*N+1:i*N,:),1);
    PDCCL(i,:)=sum(PDC((i-1)*N+1:i*N,:),1);

    DVA_INTrexCL(i,:)=sum(DVA_INTrex((i-1)*N+1:i*N,:),1);
end
DVA_JCL=VAX_GCL+RDV_GCL;%Domestic value added comprises VAX G + RDV G 
VS_JCL=FVA_FINCL+FVA_INTCL+PDCCL;%FVA FIN + FVA INT + PDC 
%Vertical Specialization comprises FVA + PDC 
%Gross Export comprises DVA and VS
Gross_ExpCL=DVA_JCL+VS_JCL;

%%
NUM_FGVCCL=DVA_INTrexCL+RDV_GCL;
DEN_BGVCCL=FVA_FINCL+PDCCL;

%% Sectoral Level
GVC.CL.FGVC=NUM_FGVCCL./Gross_ExpCL;
GVC.CL.BGVC=DEN_BGVCCL./Gross_ExpCL;

GVC.CL.FGVC(isnan(GVC.CL.FGVC))=0;
GVC.CL.BGVC(isnan(GVC.CL.BGVC))=0;

%% GVC Country Level
Results.GVC.FGVC=BRI_EORA(GVC.CL.FGVC);
Results.GVC.BGVC=BRI_EORA(GVC.CL.BGVC);

%%
Results.GVC.FGVC_Re=Results.GVC.FGVC';
Results.GVC.FGVC_Re=reshape(Results.GVC.FGVC_Re,[],1);

Results.GVC.BGVC_Re=Results.GVC.BGVC;
Results.GVC.BGVC_Re=reshape(Results.GVC.BGVC_Re,[],1);


%% For imports
Results.IMP.INT=Results.Trade.INT;
Results.IMP.INT = reshape(Results.IMP.INT, [], 1);

Results.IMP.FIN=Results.Trade.FIN;
Results.IMP.FIN = reshape(Results.IMP.FIN, [], 1);
%% For exports
Results.EXP.INT=Results.Trade.INT';
Results.EXP.INT = reshape(Results.EXP.INT, [], 1);

Results.EXP.FIN=Results.Trade.FIN';
Results.EXP.FIN = reshape(Results.EXP.FIN, [], 1);

Results.Final=[Results.EXP.INT Results.IMP.INT Results.EXP.FIN Results.IMP.FIN Results.GVC.FGVC_Re Results.GVC.BGVC_Re];

    % Save Results.Final as a CSV file, using the year in the filename
    outputFilename = ['Results_' year '.csv'];
    writematrix(Results.Final, outputFilename);
    
    % Optional: display the year being processed and file saved
    fprintf('Processed and saved data for year: %s\n', year);

% Return to the base directory after processing all data
cd(baseDir);
clear all
end
% Test3=PTA(Test);
% %% Country Level
% numSectors = 26;
% numCountries = 189;
% 
% 
% %%
% %Gross_Exp
% Gross_Exp_reshaped = reshape(Gross_Exp, numSectors, numCountries, numCountries);
% 
% % Sum over the sectors dimension (the first dimension in A_reshaped)
% Gross_Exp_summed = sum(Gross_Exp_reshaped, 1);
% 
% % Squeeze the resulting matrix to remove singleton dimension
% GVC.Gross_Exp_J_final = squeeze(Gross_Exp_summed);
% 
% %%
% %NUM_FGVC
% NUM_FGVC_reshaped = reshape(NUM_FGVC, numSectors, numCountries, numCountries);
% 
% % Sum over the sectors dimension (the first dimension in A_reshaped)
% NUM_FGVC_summed = sum(NUM_FGVC_reshaped, 1);
% 
% % Squeeze the resulting matrix to remove singleton dimension
% GVC.NUM_FGVC_final = squeeze(NUM_FGVC_summed);
% 
% %DEN_BGVC
% DEN_BGVC_reshaped = reshape(DEN_BGVC, numSectors, numCountries, numCountries);
% 
% % Sum over the sectors dimension (the first dimension in A_reshaped)
% DEN_BGVC_summed = sum(DEN_BGVC_reshaped, 1);
% 
% % Squeeze the resulting matrix to remove singleton dimension
% GVC.DEN_BGVC_final = squeeze(DEN_BGVC_summed);
% 
% 
% 
% GVC.COUNTRY.FGVC_final=GVC.NUM_FGVC_final./GVC.Gross_Exp_J_final;
% GVC.COUNTRY.FGVC_final(isnan(GVC.COUNTRY.FGVC_final))=0;
% GVC.COUNTRY.FGVC_final(isinf(GVC.COUNTRY.FGVC_final))=0;
% 
% 
% 
% GVC.COUNTRY.BGVC_final=GVC.DEN_BGVC_final./GVC.Gross_Exp_J_final;
% GVC.COUNTRY.BGVC_final(isnan(GVC.COUNTRY.BGVC_final))=0;
% GVC.COUNTRY.BGVC_final(isinf(GVC.COUNTRY.BGVC_final))=0;
% 
% 
% %% Find Average GVC Participation
% GVC.COUNTRY.AvgBGVC=mean(GVC.COUNTRY.BGVC_final,1);
% GVC.COUNTRY.AvgFGVC=mean(GVC.COUNTRY.FGVC_final,2);

%%



