clear all

% 循环遍历每一年
for year = 1995:2019
S=77;                  % number of countries
N=45;                 % number of sectors
nfd=6;  % number of finaldemand
header = {'DVAFIN', 'DVAINT', 'DVAShare', 'FVAFIN', 'FVAINT', 'FVAShare', 'VAXG', 'VAXGShare', 'TE'}; 
    % 创建文件路径
    filepath = sprintf('E:\\China_vs_India\\PAK\\Wang\\%d\\%d_SML.csv', year, year);
    
    % 检查文件是否存在
    if exist(filepath, 'file') == 2
        % 读取数据
     G = xlsread(filepath);

% G=xlsread('E:\China_vs_India\PAK\Wang\1996\1996_SML.csv');


% 从excel中读取数据 
fd=G([1:N*S],[N*S+1:(N*S+nfd*S)]);             %提出最终需求矩阵。     
FD = squeeze(sum(reshape(fd,S*N,nfd,[]),2));
GRTR_FNL_cs_c = FD(1:S*N,1:S);
VA=G([S*N+2], [1:S*N]);                  % 取增加值, confirm value added in matlab and excel
AA=G([1:S*N], [1:S*N]);                 %取中间投入矩阵816*816 


TI=squeeze(sum(reshape(AA,S*N,N,[]),2))+GRTR_FNL_cs_c;    %取总投入 Total Input
TI = sum(TI,2);
A=AA./repmat(TI,1,S*N)'; 
A(isnan(A))=0;
A(isinf(A))=0; 
% vtest=1-sum(A);  %

v = VA./TI';
v(isnan(v))=0;
v(isinf(v))=0;


I=eye(S*N);                          %单位矩阵,单位矩阵生成函数
I1=eye(N);                           %部门数的单位矩阵
B=I/(I-A);                          %求列奥列夫逆矩阵，这个矩阵是一个全局的逆矩阵。


% blocks of A L Y V
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
Y=G([1:N*S],[N*S+1:(N*S+nfd*S)]);             %提出最终需求矩阵。     
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
            DEI{i,j}=G([(i-1)*N+1:i*N],[(j-1)*N+1:j*N ])*ones(N,1);  %i 国出口到j国的分行业的中间产品。
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

DVA_INTrex=Term3+Term4+Term5;
% csvwrite('DVA_INTrex2011.csv',DVA_INTrex) 

RDV_G=Term6+Term7+Term8;
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
 display (['complete'])


%% FVA INT
s.sector.FVA.INT=sum(FVA_INT,2);
results.sector.FVAINT=EachCon(s.sector.FVA.INT);
start_id=1;
end_id=N;
for i=1:S
    s.country.FVA.INT{i,1}=sum(s.sector.FVA.INT(start_id:end_id,1),1);
    start_id=end_id+1;
    end_id=end_id+N;
end
s.country.FVA.INTM=cell2mat(s.country.FVA.INT);
% csvwrite('FVA_INT_Country_2011.csv',s.country.FVA.INTM)  

%% FVA FIN
s.sector.FVA.FIN=sum(FVA_FIN,2);
results.sector.FVAFIN=EachCon(s.sector.FVA.FIN);
start_id=1;
end_id=N;
for i=1:S
    s.country.FVA.FIN{i,1}=sum(s.sector.FVA.FIN(start_id:end_id,1),1);
    start_id=end_id+1;
    end_id=end_id+N;
end
s.country.FVA.FINM=cell2mat(s.country.FVA.FIN);
% csvwrite('FVA_FIN_Country_2011.csv',s.country.FVA.FINM) 

%% FVA TOTAL
s.sector.FVA.Tot=s.sector.FVA.INT+s.sector.FVA.FIN; % sector level
results.sector.FVATot=EachCon(s.sector.FVA.Tot);
% csvwrite('FVA_Tot_Sector_2011.csv',s.sector.FVA.Tot)  
s.country.FVA.Tot=s.country.FVA.INTM+s.country.FVA.FINM; % country level
% csvwrite('FVA_Tot_Country_2011.csv',s.country.FVA.Tot)  



%% DVA FIN
s.sector.DVA.FIN=sum(DVA_FIN,2); % DVA_FIN for sectors
results.sector.DVAFIN=EachCon(s.sector.DVA.FIN);
start_id=1;
end_id=N;
for i=1:S
    s.country.DVA.FIN{i,1}=sum(s.sector.DVA.FIN(start_id:end_id,1),1);
    start_id=end_id+1;
    end_id=end_id+N;
end
s.country.DVA.FINM=cell2mat(s.country.DVA.FIN);
% csvwrite('DVA_FIN_Country_2011.csv',s.country.DVA.FINM) 

%% DVA INT
DVA.INT=Term2;
% csvwrite('DVA_INT2011.csv',DVA.INT) 

s.sector.DVA.INT=sum(DVA.INT,2);
results.sector.DVAINT=EachCon(s.sector.DVA.INT);
start_id=1;
end_id=N;
for i=1:S
    s.country.DVA.INT{i,1}=sum(s.sector.DVA.INT(start_id:end_id,1),1);
    start_id=end_id+1;
    end_id=end_id+N;
end
s.country.DVA.INTM=cell2mat(s.country.DVA.INT);
% csvwrite('DVA_INT_Country_2011.csv',s.country.DVA.INTM)  

%% DVA TOTAL
s.sector.DVA.Tot=s.sector.DVA.FIN+s.sector.DVA.INT; % sector level
results.sector.DVATot=EachCon(s.sector.DVA.Tot);
% csvwrite('DVA_Tot_Sector_2011.csv',s.sector.DVA.Tot)  
s.country.DVA.Tot=s.country.DVA.INTM+s.country.DVA.FINM; % country level
% csvwrite('DVA_Tot_Country_2011.csv',s.country.DVA.Tot)  




%% TOTAL EXPORTS
s.sector.TE=cell2mat(TE);
results.sector.TE=EachCon(s.sector.TE);
start_id=1;
end_id=N;
for i=1:S
    s.country.TE{i,1}=sum(s.sector.TE(start_id:end_id,1),1);
    start_id=end_id+1;
    end_id=end_id+N;
end
s.country.TEM=cell2mat(s.country.TE);
% csvwrite('TE_Country_2011.csv',s.country.TEM)  



%% VAX_G Domestic value-added absorbed abroad
s.sector.VAX_G=sum(VAX_G,2);
results.sector.VAXG=EachCon(s.sector.VAX_G);
start_id=1;
end_id=N;
for i=1:S
    s.country.VAX_G{i,1}=sum(s.sector.VAX_G(start_id:end_id,1),1);
    start_id=end_id+1;
    end_id=end_id+N;
end
s.country.VAX_GM=cell2mat(s.country.VAX_G);

%% DVA SHARE
s.sector.DVA.share=s.sector.DVA.Tot ./ s.sector.TE;
results.sector.DVAshare=EachCon(s.sector.DVA.share);
s.country.DVA.share=s.country.DVA.Tot ./ s.country.TEM;

%% FVA/DVA SHARE
s.sector.FVA.share=s.sector.FVA.Tot./s.sector.TE;
results.sector.FVAshare=EachCon(s.sector.FVA.share);
s.country.FVA.share=s.country.FVA.Tot ./ s.country.TEM;

%% VAX_G Share
s.sector.VAX_Gshare=s.sector.VAX_G./s.sector.TE;
results.sector.VAXGshare=EachCon(s.sector.VAX_Gshare);
s.country.VAX_Gshare=s.country.VAX_GM ./ s.country.TEM;


PAK.DVA.FIN=results.sector.DVAFIN(:,56);
PAK.DVA.INT=results.sector.DVAINT(:,56);
PAK.DVA.share=results.sector.DVAshare(:,56);
PAK.FVA.FIN=results.sector.FVAFIN(:,56);
PAK.FVA.INT=results.sector.FVAINT(:,56);
PAK.FVA.share=results.sector.FVAshare(:,56);
PAK.TE=results.sector.TE(:,56);
PAK.VAXG=results.sector.VAXG(:,56);
PAK.VAX_Gshare=results.sector.VAXGshare(:,56);

PAK=[PAK.DVA.FIN PAK.DVA.INT PAK.DVA.share PAK.FVA.FIN PAK.FVA.INT PAK.FVA.share PAK.VAXG PAK.VAX_Gshare PAK.TE];
% csvwrite('E:\China_vs_India\PAK\Wang\1996\PAK.csv',PAK)  

        % 定义输出文件路径
        output_filepath = sprintf('E:\\China_vs_India\\PAK\\Wang\\%d\\%d_SML_processed.csv', year, year);
        
        % 打开文件写入模式
        fid = fopen(output_filepath, 'w');
        
        % 写入表头字符串到文件
        headerStr = strjoin(header, ',');
        fprintf(fid, '%s\n', headerStr);
        
        % 关闭文件
        fclose(fid);
        
        % 使用 dlmwrite 追加数据到文件
        dlmwrite(output_filepath, PAK, '-append');
    else
        fprintf('文件 %s 不存在。\n', filepath);
    end
    clear all
end


% csvwrite('E:\China_vs_India\PAK\Wang\1996\DVAFIN.csv',results.sector.DVAFIN)  
% csvwrite('E:\China_vs_India\PAK\Wang\1996\DVAINT.csv',results.sector.DVAINT)  
% csvwrite('E:\China_vs_India\PAK\Wang\1996\DVAshare.csv',results.sector.DVAshare)  
% csvwrite('E:\China_vs_India\PAK\Wang\1996\DVATot.csv',results.sector.DVATot)  
% csvwrite('E:\China_vs_India\PAK\Wang\1996\FVAFIN.csv',results.sector.FVAFIN)  
% csvwrite('E:\China_vs_India\PAK\Wang\1996\FVAINT.csv',results.sector.FVAINT)  
% csvwrite('E:\China_vs_India\PAK\Wang\1996\FVAshare.csv',results.sector.FVAshare)  
% csvwrite('E:\China_vs_India\PAK\Wang\1996\FVATot.csv',results.sector.FVATot)  
% csvwrite('E:\China_vs_India\PAK\Wang\1996\TE.csv',results.sector.TE)  
% csvwrite('E:\China_vs_India\PAK\Wang\1996\VAXG.csv',results.sector.VAXG)  
% csvwrite('E:\China_vs_India\PAK\Wang\1996\VAXGshare.csv',results.sector.VAXGshare)  

