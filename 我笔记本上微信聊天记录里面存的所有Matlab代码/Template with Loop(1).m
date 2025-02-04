clear all

% 循环遍历每一年
for year = 1995:2019
S=77;                  % number of countries
N=45;                 % number of sectors
nfd=6;  % number of finaldemand

    % 创建文件路径
    filepath = sprintf('E:\\China_vs_India\\PAK\\Wang\\%d_SML.csv', year);
    
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

%% GDP
s.sector.GDP=sum(diag(v)*B*(diag(sum(FD,2))),2);
s.sector.GDPCon=EachCon(s.sector.GDP);
start_id=1;
end_id=N;
for i=1:S
    s.country.GDP{i,1}=sum(s.sector.GDP(start_id:end_id,1),1);
    start_id=end_id+1;
    end_id=end_id+N;
end
s.country.GDPM=cell2mat(s.country.GDP);
%% GVCs Participation
DVAX2=Term2;
REF=RDV_G; %RDV_G=Term6+Term7+Term8;
REX=DVA_INTrex; %DVA_INTrex=Term3+Term4+Term5;
s.sector.GVCsParticipation=(DVAX2+REX+REF)./s.sector.GDP;
s.sector.GVCsParticipation(isnan(s.sector.GVCsParticipation))=0;
s.sector.GVCsParticipation(isinf(s.sector.GVCsParticipation))=0; 
start_id=1;
end_id=N;
for i=1:S
    s.country.GVCsParticipation{i,1}=sum(s.sector.GVCsParticipation(start_id:end_id,1),1);
    start_id=end_id+1;
    end_id=end_id+N;
end
s.country.GVCsParticipationM=cell2mat(s.country.GVCsParticipation);

%% Forward Linkage GVCs Trade Based
s.sector.FWGVCsParticipation=(REX+REF)./(s.sector.DVA.Tot+s.sector.FVA.Tot); % s.sector.GDP TE
% s.sector.FWGVCsParticipation=(Term2+Term3+Term4+Term5+Term6+Term7+Term8+Term9+Term10)./sum(FD,2);

s.sector.FWGVCsParticipation(isnan(s.sector.FWGVCsParticipation))=0;
s.sector.FWGVCsParticipation(isinf(s.sector.FWGVCsParticipation))=0; 
start_id=1;
end_id=N;
for i=1:S
    s.country.FWGVCsParticipation{i,1}=sum(s.sector.FWGVCsParticipation(start_id:end_id,1),1);
    start_id=end_id+1;
    end_id=end_id+N;
end
s.country.FWGVCsParticipationM=cell2mat(s.country.FWGVCsParticipation);


%% Backward Linkage GVCs Trade Based
s.sector.PDC=sum(PDC,2);
% s.sector.BWGVCsParticipation=(s.sector.FVA.INT+s.sector.PDC)./(s.sector.DVA.Tot+s.sector.FVA.Tot);
s.sector.BWGVCsParticipation=(Term11+Term9+Term10+Term12+Term15+Term16)./(s.sector.DVA.Tot+s.sector.FVA.Tot);
% s.sector.BWGVCsParticipation=(Term11+Term12)./(s.sector.DVA.Tot+s.sector.FVA.Tot);
s.sector.BWGVCsParticipation(isnan(s.sector.BWGVCsParticipation))=0;
s.sector.BWGVCsParticipation(isinf(s.sector.BWGVCsParticipation))=0; 
start_id=1;
end_id=N;
for i=1:S
    s.country.BWGVCsParticipation{i,1}=sum(s.sector.BWGVCsParticipation(start_id:end_id,1),1);
    start_id=end_id+1;
    end_id=end_id+N;
end
s.country.BWGVCsParticipationM=cell2mat(s.country.BWGVCsParticipation);

%% GVC Participation Trade Based
VBY2=diag(v)*B*diag(sum(FD,2));
start_id=1;
end_id=N;
VBY=VBY2;
    for i=1:S
        VBY(start_id:end_id,start_id:end_id)=0;
        start_id=end_id+1;
        end_id=end_id+N;
    end
TEM=cell2mat(TE);

% LL.Forward_linkage=sum(VBY,2)./sum(VBY2,2);
% LL.Backward_linkage=sum(VBY,1)./sum(VBY2,1);

LL.Forward_linkage=sum(VBY,2);
LL.Backward_linkage=sum(VBY,1);
LL.Backward_linkage=LL.Backward_linkage';

start_id=1;
end_id=N;
for i=1:S
    s.country.BWGVCsParticipation{i,1}=sum(LL.Backward_linkage(start_id:end_id,1),1);
    start_id=end_id+1;
    end_id=end_id+N;
end
s.country.BWGVCsParticipationM=cell2mat(s.country.BWGVCsParticipation);


start_id=1;
end_id=N;
for i=1:S
    s.country.FWGVCsParticipation{i,1}=sum(LL.Forward_linkage(start_id:end_id,1),1);
    start_id=end_id+1;
    end_id=end_id+N;
end
s.country.FWGVCsParticipationM=cell2mat(s.country.FWGVCsParticipation);


LL.Forward_linkage_Country=EachCon(LL.Forward_linkage);
LL.Backward_linkage_Country=EachCon(LL.Backward_linkage);

V_VBY2=sum(VBY2,2);
y_VBY2=sum(VBY2,1);
y_VBY2=y_VBY2';
LL.V_VBY2=EachCon(V_VBY2);
LL.y_VBY2=EachCon(y_VBY2);

LL.GVC.Forward_linkage_Country=LL.Forward_linkage_Country./LL.V_VBY2;
LL.GVC.Backward_linkage_Country=LL.Backward_linkage_Country./LL.y_VBY2;

LL.GVC.FCountry=sum(LL.Forward_linkage_Country,1)./sum(LL.V_VBY2,1);
LL.GVC.BCountry=sum(LL.Backward_linkage_Country,1)./sum(LL.y_VBY2,1);

%% Method 2
Y=sum(FD,2);

start_id=1;
end_id=N;  % number of sectors 4
for i=1:S   % number of countries 3
Yd(start_id:end_id)=fd(start_id:end_id,i);
    start_id=end_id+1;
    end_id=end_id+N;
end
Yd=Yd';

Yf=Y-Yd;
answ=Yd+Yf;
%% BLOCK A
A_subMatrices = cell(S,S);

for i = 1:S
    for j = 1:S
        A_subMatrix = A((N*(i-1)+1):(N*i), (N*(j-1)+1):(N*j));
        A_subMatrices {i,j} = A_subMatrix;
    end
end

%%  CREATE Ad, Af
Ad=zeros(S*N);
start_id=1;
end_id=N;
for i=1:S
Ad(start_id:end_id,start_id:end_id)=A_subMatrices{i,i};
    start_id=end_id+1;
    end_id=end_id+N;
end
Af=A-Ad;

%% CREATE Leontief inverse
Ld=inv(eye(S*N)-Ad);
VBY=diag(v)*B*diag(Y);
RVBY=sum(VBY,2);
CVBY=sum(VBY,1);

DVAC1=v*B*diag(Y); 

Agg.BL.YT=v*Ld*diag(Yd)+v*Ld*diag(Yf)+v*Ld*Af*Ld*diag(Yd)+v*Ld*Af*(B*diag(Y)-Ld*diag(Yd)); 
Agg.BL.Yd=v*Ld*diag(Yd);

BGVC.Yd=v*Ld*diag(Yd);
BGVC.Yrt=v*Ld*diag(Yf);
BGVC.YGVCs=v*Ld*Af*Ld*diag(Yd);
BGVC.YGVCc=v*Ld*Af*(B*diag(Y)-Ld*diag(Yd));
BGVC.YGVC=[BGVC.Yd BGVC.Yrt  BGVC.YGVCs BGVC.YGVCc];
BGVC.GVC=BGVC.YGVCs+BGVC.YGVCc;
BGVC.GVCParticipation=BGVC.GVC./s.sector.TE';

BGVC.GVC2=EachCon(BGVC.GVC');
BGVC.TE2=EachCon(s.sector.TE);
BGVC.GVCParticipation_Country=BGVC.GVC2./BGVC.TE2;
BGVC.GVCParticipation_Country2=sum(BGVC.GVC2,1)./sum(BGVC.TE2,1);
BGVC.GVCParticipation_Country(isnan(BGVC.GVCParticipation_Country))=0;
BGVC.GVCParticipation_Country(isinf(BGVC.GVCParticipation_Country))=0;

% start_id=1;
% end_id=N;
% for i=1:S
%     BGVC.GVCParticipation_Country{i,1}=sum(BGVC.GVCParticipation_Country(start_id:end_id,1),1);
%     start_id=end_id+1;
%     end_id=end_id+N;
% end
%  BGVC.GVCParticipation_CountryM=cell2mat(BGVC.GVCParticipation_Country);


Agg.FL.Vd=diag(v)*Ld*Yd+diag(v)*Ld*Yf+diag(v)*Ld*Af*Ld*Yd+diag(v)*Ld*Af*(B*Y-Ld*Yd); 

FGVC.Vd=diag(v)*Ld*Yd;
FGVC.Vrt=diag(v)*Ld*Yf;
FGVC.VGVCs=diag(v)*Ld*Af*Ld*Yd;
FGVC.VGVCc=diag(v)*Ld*Af*(B*Y-Ld*Yd); 
FGVC.VGVC=[FGVC.Vd FGVC.Vrt FGVC.VGVCs FGVC.VGVCc];
FGVC.GVC=FGVC.VGVCs+FGVC.VGVCc;
FGVC.GVCParticipation=FGVC.GVC./s.sector.TE';

FGVC.GVC2=EachCon(FGVC.GVC);
FGVC.TE2=EachCon(s.sector.TE);
FGVC.GVCParticipation_Country=FGVC.GVC2./FGVC.TE2;
FGVC.GVCParticipation_Country2=sum(FGVC.GVC2,1)./sum(FGVC.TE2,1);
FGVC.GVCParticipation_Country(isnan(FGVC.GVCParticipation_Country))=0;
FGVC.GVCParticipation_Country(isinf(FGVC.GVCParticipation_Country))=0;

% %%
% start_id=1;
% end_id=N;
% for i=1:S
%     DVA.share4{i,1}=sum(DVA.share(start_id:end_id,1),1);
%     start_id=end_id+1;
%     end_id=end_id+N;
% end
% DVA.share2M=cell2mat(DVA.share4);
% 
% TE=cell(S,1)
%  for i=1:1:S
%      TE{i,1}=0;
%      for j=1:1:S
%          if j==i
%              TE{i,1}=TE{i,1}+zeros(N,1);
%          else
%          TE{i,1}=TE{i,1}+DEI{i,j}+FY{i,j};
%          end
%      end
%  end
% 
%  TE2=cell(S,1)
%  for i=1:1:S
%      TE2{i,1}=0;
%      for j=1:1:S
%          if j==i
%              TE2{i,1}=TE2{i,1}+zeros(N,1);
%          else
%          TE2{i,1}=TE2{i,1}+FY{i,j};
%          TED=FY{i,i};
%          end
%      end
%  end
%  s.sector.Final_Exports=cell2mat(TE2);
%  FYM=cell2mat(FY);
%  FYMs=sum(FYM,2);
% s.sector.Domestic_Final_Demand=FYMs-s.sector.Final_Exports;
% start_id=1;
% end_id=N;
% for i=1:S
%     s.country.Domestic_Final_Demand{i,1}=sum(s.sector.Domestic_Final_Demand(start_id:end_id,1),1);
%     start_id=end_id+1;
%     end_id=end_id+N;
% end
% s.country.Domestic_Final_DemandM=cell2mat(s.country.Domestic_Final_Demand);
% 
% s.country.FVADF=s.country.FVA.INTM ./s.country.Domestic_Final_DemandM;
% 
% start_id=1;
% end_id=N;
% for i=1:S
%     s.country.Final_Exports{i,1}=sum(s.sector.Final_Exports(start_id:end_id,1),1);
%     start_id=end_id+1;
%     end_id=end_id+N;
% end
% s.country.Final_ExportsM=cell2mat(s.country.Final_Exports);
% s.country.FVA_Final_Exports=s.country.FVA.FINM./s.country.Final_ExportsM;
% s.country.FVA_Gross_Exports=s.country.FVA.FINM./s.country.TEM;
% 
% s.sector.DVA_Final_Exports=s.sector.DVA.FIN./s.sector.Final_Exports;
% s.sector.DVA_Gross_Exports=s.sector.DVA.FIN./s.sector.TE;
% s.sector.DFE = reshape(s.sector.DVA_Final_Exports, 45, 77); % DVA share in final exports
% s.sector.DVE = reshape(s.sector.DVA_Gross_Exports, 45, 77); % DVA share in gross exports

%% DVA Foreign Final Demand, As a percentage of value added, by industry
for i=1:S
    FFD1(:,i)=sum(reshape(FD(:,i),[N,S]),2);
end

for i=1:S
    Temp=FFD1;
    Temp(:,i)=0;
    FFD_cell{i,i}=sum(Temp,2);
end

  DVAFD=Term1./VA'; % domestic value added embodied in foreign final demand as share of value added
  DVAFDM1=sum(DVAFD,2);
  DVAFDCon=EachCon(DVAFDM1);

  %%foreign value-added content of gross exports
  FVA_tot=FVA_FIN+FVA_INT;
  FVA_totR=sum(FVA_tot,2);
  FVA_Con=EachCon(FVA_totR);

%% - industry share of domestic and foreign value-added content of gross exports (As a percentage of total gross exports) 
VAX_GS=sum(VAX_G,2);
VAX_GCon=EachCon(VAX_GS);

%% Extract PAK
PAK.DVA.FIN=results.sector.DVAFIN(:,56);
PAK.DVA.INT=results.sector.DVAINT(:,56);
PAK.DVA.share=results.sector.DVAshare(:,56);
PAK.FVA.FIN=results.sector.FVAFIN(:,56);
PAK.FVA.INT=results.sector.FVAINT(:,56);
PAK.FVA.share=results.sector.FVAshare(:,56);
PAK.TE=results.sector.TE(:,56);
PAK.VAXG=results.sector.VAXG(:,56);
PAK.VAX_Gshare=results.sector.VAXGshare(:,56);
PAK.FGVCM1=LL.GVC.FCountry(:,56);
PAK.BGVCM1=LL.GVC.BCountry(:,56);
PAK.FGVCPM2=FGVC.GVCParticipation_Country2(:,56);
PAK.BGVCPM2=BGVC.GVCParticipation_Country2(:,56);
PAK.VAX_GCon=VAX_GCon(:,56);
PAK.FVA_Con=FVA_Con(:,56);
PAK.DVAFDCon=DVAFDCon(:,56);
%% Extract BGD
BGD.DVA.FIN=results.sector.DVAFIN(:,5);
BGD.DVA.INT=results.sector.DVAINT(:,5);
BGD.DVA.share=results.sector.DVAshare(:,5);
BGD.FVA.FIN=results.sector.FVAFIN(:,5);
BGD.FVA.INT=results.sector.FVAINT(:,5);
BGD.FVA.share=results.sector.FVAshare(:,5);
BGD.TE=results.sector.TE(:,5);
BGD.VAXG=results.sector.VAXG(:,5);
BGD.VAX_Gshare=results.sector.VAXGshare(:,5);
BGD.FGVCM1=LL.GVC.FCountry(:,5);
BGD.BGVCM1=LL.GVC.BCountry(:,5);
BGD.FGVCPM2=FGVC.GVCParticipation_Country2(:,5);
BGD.BGVCPM2=BGVC.GVCParticipation_Country2(:,5);
BGD.VAX_GCon=VAX_GCon(:,5);
BGD.FVA_Con=FVA_Con(:,5);
BGD.DVAFDCon=DVAFDCon(:,5);
%% Extract CHN
CHN.DVA.FIN=results.sector.DVAFIN(:,13);
CHN.DVA.INT=results.sector.DVAINT(:,13);
CHN.DVA.share=results.sector.DVAshare(:,13);
CHN.FVA.FIN=results.sector.FVAFIN(:,13);
CHN.FVA.INT=results.sector.FVAINT(:,13);
CHN.FVA.share=results.sector.FVAshare(:,13);
CHN.TE=results.sector.TE(:,13);
CHN.VAXG=results.sector.VAXG(:,13);
CHN.VAX_Gshare=results.sector.VAXGshare(:,13);
CHN.FGVCM1=LL.GVC.FCountry(:,13);
CHN.BGVCM1=LL.GVC.BCountry(:,13);
CHN.FGVCPM2=FGVC.GVCParticipation_Country2(:,13);
CHN.BGVCPM2=BGVC.GVCParticipation_Country2(:,13);
CHN.VAX_GCon=VAX_GCon(:,13);
CHN.FVA_Con=FVA_Con(:,13);
CHN.DVAFDCon=DVAFDCon(:,13);
%% Extract IND
IND.DVA.FIN=results.sector.DVAFIN(:,33);
IND.DVA.INT=results.sector.DVAINT(:,33);
IND.DVA.share=results.sector.DVAshare(:,33);
IND.FVA.FIN=results.sector.FVAFIN(:,33);
IND.FVA.INT=results.sector.FVAINT(:,33);
IND.FVA.share=results.sector.FVAshare(:,33);
IND.TE=results.sector.TE(:,33);
IND.VAXG=results.sector.VAXG(:,33);
IND.VAX_Gshare=results.sector.VAXGshare(:,33);
IND.FGVCM1=LL.GVC.FCountry(:,33);
IND.BGVCM1=LL.GVC.BCountry(:,33);
IND.FGVCPM2=FGVC.GVCParticipation_Country2(:,33);
IND.BGVCPM2=BGVC.GVCParticipation_Country2(:,33);
IND.VAX_GCon=VAX_GCon(:,33);
IND.FVA_Con=FVA_Con(:,33);
IND.DVAFDCon=DVAFDCon(:,33);
%% MYS
MYS.DVA.FIN=results.sector.DVAFIN(:,51);
MYS.DVA.INT=results.sector.DVAINT(:,51);
MYS.DVA.share=results.sector.DVAshare(:,51);
MYS.FVA.FIN=results.sector.FVAFIN(:,51);
MYS.FVA.INT=results.sector.FVAINT(:,51);
MYS.FVA.share=results.sector.FVAshare(:,51);
MYS.TE=results.sector.TE(:,51);
MYS.VAXG=results.sector.VAXG(:,51);
MYS.VAX_Gshare=results.sector.VAXGshare(:,51);
MYS.FGVCM1=LL.GVC.FCountry(:,51);
MYS.BGVCM1=LL.GVC.BCountry(:,51);
MYS.FGVCPM2=FGVC.GVCParticipation_Country2(:,51);
MYS.BGVCPM2=BGVC.GVCParticipation_Country2(:,51);
MYS.VAX_GCon=VAX_GCon(:,51);
MYS.FVA_Con=FVA_Con(:,51);
MYS.DVAFDCon=DVAFDCon(:,51);
%% VNM
VNM.DVA.FIN=results.sector.DVAFIN(:,75);
VNM.DVA.INT=results.sector.DVAINT(:,75);
VNM.DVA.share=results.sector.DVAshare(:,75);
VNM.FVA.FIN=results.sector.FVAFIN(:,75);
VNM.FVA.INT=results.sector.FVAINT(:,75);
VNM.FVA.share=results.sector.FVAshare(:,75);
VNM.TE=results.sector.TE(:,75);
VNM.VAXG=results.sector.VAXG(:,75);
VNM.VAX_Gshare=results.sector.VAXGshare(:,75);
VNM.FGVCM1=LL.GVC.FCountry(:,75);
VNM.BGVCM1=LL.GVC.BCountry(:,75);
VNM.FGVCPM2=FGVC.GVCParticipation_Country2(:,75);
VNM.BGVCPM2=BGVC.GVCParticipation_Country2(:,75);
VNM.VAX_GCon=VAX_GCon(:,75);
VNM.FVA_Con=FVA_Con(:,75);
VNM.DVAFDCon=DVAFDCon(:,75);
%% LAO
LAO.DVA.FIN=results.sector.DVAFIN(:,43);
LAO.DVA.INT=results.sector.DVAINT(:,43);
LAO.DVA.share=results.sector.DVAshare(:,43);
LAO.FVA.FIN=results.sector.FVAFIN(:,43);
LAO.FVA.INT=results.sector.FVAINT(:,43);
LAO.FVA.share=results.sector.FVAshare(:,43);
LAO.TE=results.sector.TE(:,43);
LAO.VAXG=results.sector.VAXG(:,43);
LAO.VAX_Gshare=results.sector.VAXGshare(:,43);
LAO.FGVCM1=LL.GVC.FCountry(:,43);
LAO.BGVCM1=LL.GVC.BCountry(:,43);
LAO.FGVCPM2=FGVC.GVCParticipation_Country2(:,43);
LAO.BGVCPM2=BGVC.GVCParticipation_Country2(:,43);
LAO.VAX_GCon=VAX_GCon(:,43);
LAO.FVA_Con=FVA_Con(:,43);
LAO.DVAFDCon=DVAFDCon(:,43);
%% Thailand
THA.DVA.FIN=results.sector.DVAFIN(:,69);
THA.DVA.INT=results.sector.DVAINT(:,69);
THA.DVA.share=results.sector.DVAshare(:,69);
THA.FVA.FIN=results.sector.FVAFIN(:,69);
THA.FVA.INT=results.sector.FVAINT(:,69);
THA.FVA.share=results.sector.FVAshare(:,69);
THA.TE=results.sector.TE(:,69);
THA.VAXG=results.sector.VAXG(:,69);
THA.VAX_Gshare=results.sector.VAXGshare(:,69);
THA.FGVCM1=LL.GVC.FCountry(:,69);
THA.BGVCM1=LL.GVC.BCountry(:,69);
THA.FGVCPM2=FGVC.GVCParticipation_Country2(:,69);
THA.BGVCPM2=BGVC.GVCParticipation_Country2(:,69);
THA.VAX_GCon=VAX_GCon(:,69);
THA.FVA_Con=FVA_Con(:,69);
THA.DVAFDCon=DVAFDCon(:,69);



% Define headers for C and GVC
% Define headers for C and GVC
header1 = {'DVAFIN', 'DVAINT', 'DVAShare', 'FVAFIN', 'FVAINT', 'FVAShare', 'VAXG', 'VAXGShare', 'TE', 'FVA_Con', 'VAX_GCon', 'DVAFDCon'};
header2 = {'GVCFM1', 'GVCBM1', 'GVCFM2', 'GVCBM2'};

% Define data for C and GVC
C.PAK = [PAK.DVA.FIN, PAK.DVA.INT, PAK.DVA.share, PAK.FVA.FIN, PAK.FVA.INT, PAK.FVA.share, PAK.VAXG, PAK.VAX_Gshare, PAK.TE, PAK.FVA_Con, PAK.VAX_GCon PAK.DVAFDCon];
C.BGD = [BGD.DVA.FIN, BGD.DVA.INT, BGD.DVA.share, BGD.FVA.FIN, BGD.FVA.INT, BGD.FVA.share, BGD.VAXG, BGD.VAX_Gshare, BGD.TE, BGD.FVA_Con BGD.VAX_GCon BGD.DVAFDCon];
C.CHN = [CHN.DVA.FIN, CHN.DVA.INT, CHN.DVA.share, CHN.FVA.FIN, CHN.FVA.INT, CHN.FVA.share, CHN.VAXG, CHN.VAX_Gshare, CHN.TE CHN.FVA_Con CHN.VAX_GCon CHN.DVAFDCon] ;
C.IND = [IND.DVA.FIN, IND.DVA.INT, IND.DVA.share, IND.FVA.FIN, IND.FVA.INT, IND.FVA.share, IND.VAXG, IND.VAX_Gshare, IND.TE IND.FVA_Con IND.VAX_GCon IND.DVAFDCon];
C.MYS = [MYS.DVA.FIN, MYS.DVA.INT, MYS.DVA.share, MYS.FVA.FIN, MYS.FVA.INT, MYS.FVA.share, MYS.VAXG, MYS.VAX_Gshare, MYS.TE MYS.FVA_Con MYS.VAX_GCon MYS.DVAFDCon];
C.VNM = [VNM.DVA.FIN, VNM.DVA.INT, VNM.DVA.share, VNM.FVA.FIN, VNM.FVA.INT, VNM.FVA.share, VNM.VAXG, VNM.VAX_Gshare, VNM.TE VNM.FVA_Con VNM.VAX_GCon VNM.DVAFDCon];
C.LAO = [LAO.DVA.FIN, LAO.DVA.INT, LAO.DVA.share, LAO.FVA.FIN, LAO.FVA.INT, LAO.FVA.share, LAO.VAXG, LAO.VAX_Gshare, LAO.TE LAO.FVA_Con LAO.VAX_GCon LAO.DVAFDCon];
C.THA = [THA.DVA.FIN, THA.DVA.INT, THA.DVA.share, THA.FVA.FIN, THA.FVA.INT, THA.FVA.share, THA.VAXG, THA.VAX_Gshare, THA.TE THA.FVA_Con THA.VAX_GCon THA.DVAFDCon];




GVC.PAK = [PAK.FGVCM1, PAK.BGVCM1, PAK.FGVCPM2, PAK.BGVCPM2];
GVC.BGD = [BGD.FGVCM1, BGD.BGVCM1, BGD.FGVCPM2, BGD.BGVCPM2];
GVC.CHN = [CHN.FGVCM1, CHN.BGVCM1, CHN.FGVCPM2, CHN.BGVCPM2];
GVC.IND = [IND.FGVCM1, IND.BGVCM1, IND.FGVCPM2, IND.BGVCPM2];
GVC.MYS = [MYS.FGVCM1, MYS.BGVCM1, MYS.FGVCPM2, MYS.BGVCPM2];
GVC.VNM = [VNM.FGVCM1, VNM.BGVCM1, VNM.FGVCPM2, VNM.BGVCPM2];
GVC.LAO = [LAO.FGVCM1, LAO.BGVCM1, LAO.FGVCPM2, LAO.BGVCPM2];
GVC.THA = [THA.FGVCM1, THA.BGVCM1, THA.FGVCPM2, THA.BGVCPM2];





% Define output file paths for CSV files
output_filepathC_PAK = sprintf('E:\\China_vs_India\\PAK\\codes\\GVCs\\PAK\\%d\\%d_C_processed.csv', year, year);
output_filepathC_IND = sprintf('E:\\China_vs_India\\PAK\\codes\\GVCs\\IND\\%d\\%d_C_processed.csv', year, year);
output_filepathC_BGD = sprintf('E:\\China_vs_India\\PAK\\codes\\GVCs\\BGD\\%d\\%d_C_processed.csv', year, year);
output_filepathC_CHN = sprintf('E:\\China_vs_India\\PAK\\codes\\GVCs\\CHN\\%d\\%d_C_processed.csv', year, year);
output_filepathC_MYS = sprintf('E:\\China_vs_India\\PAK\\codes\\GVCs\\MYS\\%d\\%d_C_processed.csv', year, year);
output_filepathC_VNM = sprintf('E:\\China_vs_India\\PAK\\codes\\GVCs\\VNM\\%d\\%d_C_processed.csv', year, year);
output_filepathC_LAO = sprintf('E:\\China_vs_India\\PAK\\codes\\GVCs\\LAO\\%d\\%d_C_processed.csv', year, year);
output_filepathC_THA = sprintf('E:\\China_vs_India\\PAK\\codes\\GVCs\\THA\\%d\\%d_C_processed.csv', year, year);


output_filepathGVC_PAK = sprintf('E:\\China_vs_India\\PAK\\codes\\GVCs\\PAK\\%d\\%d_GVC_processed.csv', year, year);
output_filepathGVC_IND = sprintf('E:\\China_vs_India\\PAK\\codes\\GVCs\\IND\\%d\\%d_GVC_processed.csv', year, year);
output_filepathGVC_BGD = sprintf('E:\\China_vs_India\\PAK\\codes\\GVCs\\BGD\\%d\\%d_GVC_processed.csv', year, year);
output_filepathGVC_CHN = sprintf('E:\\China_vs_India\\PAK\\codes\\GVCs\\CHN\\%d\\%d_GVC_processed.csv', year, year);
output_filepathGVC_MYS = sprintf('E:\\China_vs_India\\PAK\\codes\\GVCs\\MYS\\%d\\%d_GVC_processed.csv', year, year);
output_filepathGVC_VNM = sprintf('E:\\China_vs_India\\PAK\\codes\\GVCs\\VNM\\%d\\%d_GVC_processed.csv', year, year);
output_filepathGVC_LAO = sprintf('E:\\China_vs_India\\PAK\\codes\\GVCs\\LAO\\%d\\%d_GVC_processed.csv', year, year);
output_filepathGVC_THA = sprintf('E:\\China_vs_India\\PAK\\codes\\GVCs\\THA\\%d\\%d_GVC_processed.csv', year, year);


% Define the output file path for TEM
output_filepathTEM_PAK = sprintf('E:\\China_vs_India\\PAK\\codes\\GVCs\\PAK\\%d\\%d_TEM_processed.csv', year, year);
output_filepathTEM_IND = sprintf('E:\\China_vs_India\\PAK\\codes\\GVCs\\IND\\%d\\%d_TEM_processed.csv', year, year);
output_filepathTEM_BGD = sprintf('E:\\China_vs_India\\PAK\\codes\\GVCs\\BGD\\%d\\%d_TEM_processed.csv', year, year);
output_filepathTEM_CHN = sprintf('E:\\China_vs_India\\PAK\\codes\\GVCs\\CHN\\%d\\%d_TEM_processed.csv', year, year);
output_filepathTEM_MYS = sprintf('E:\\China_vs_India\\PAK\\codes\\GVCs\\MYS\\%d\\%d_TEM_processed.csv', year, year);
output_filepathTEM_VNM = sprintf('E:\\China_vs_India\\PAK\\codes\\GVCs\\VNM\\%d\\%d_TEM_processed.csv', year, year);
output_filepathTEM_LAO = sprintf('E:\\China_vs_India\\PAK\\codes\\GVCs\\LAO\\%d\\%d_TEM_processed.csv', year, year);
output_filepathTEM_THA = sprintf('E:\\China_vs_India\\PAK\\codes\\GVCs\\THA\\%d\\%d_TEM_processed.csv', year, year);

% Convert TEM data to tables
tableTEM_PAK = array2table(s.country.TEM, 'VariableNames', {'TEM'});
tableTEM_IND = array2table(s.country.TEM, 'VariableNames', {'TEM'});
tableTEM_BGD = array2table(s.country.TEM, 'VariableNames', {'TEM'});
tableTEM_CHN = array2table(s.country.TEM, 'VariableNames', {'TEM'});
tableTEM_MYS = array2table(s.country.TEM, 'VariableNames', {'TEM'});
tableTEM_VNM = array2table(s.country.TEM, 'VariableNames', {'TEM'});
tableTEM_LAO = array2table(s.country.TEM, 'VariableNames', {'TEM'});
tableTEM_THA = array2table(s.country.TEM, 'VariableNames', {'TEM'});

% Save TEM data as CSV files
writetable(tableTEM_PAK, output_filepathTEM_PAK);
writetable(tableTEM_IND, output_filepathTEM_IND);
writetable(tableTEM_BGD, output_filepathTEM_BGD);
writetable(tableTEM_CHN, output_filepathTEM_CHN);
writetable(tableTEM_MYS, output_filepathTEM_MYS);
writetable(tableTEM_VNM, output_filepathTEM_VNM);
writetable(tableTEM_LAO, output_filepathTEM_LAO);
writetable(tableTEM_THA, output_filepathTEM_THA);


% Create folders if they don't exist
folders = {...
    sprintf('E:\\China_vs_India\\PAK\\codes\\GVCs\\PAK\\%d', year), ...
    sprintf('E:\\China_vs_India\\PAK\\codes\\GVCs\\IND\\%d', year), ...
    sprintf('E:\\China_vs_India\\PAK\\codes\\GVCs\\BGD\\%d', year), ...
    sprintf('E:\\China_vs_India\\PAK\\codes\\GVCs\\CHN\\%d', year), ...
    sprintf('E:\\China_vs_India\\PAK\\codes\\GVCs\\MYS\\%d', year), ...
    sprintf('E:\\China_vs_India\\PAK\\codes\\GVCs\\LAO\\%d', year), ...
    sprintf('E:\\China_vs_India\\PAK\\codes\\GVCs\\THA\\%d', year), ...
    sprintf('E:\\China_vs_India\\PAK\\codes\\GVCs\\VNM\\%d', year)};

for i = 1:numel(folders)
    if ~exist(folders{i}, 'dir')
        mkdir(folders{i});
    end
end

% Convert C data to tables
tableC_PAK = array2table(C.PAK, 'VariableNames', header1);
tableC_IND = array2table(C.IND, 'VariableNames', header1);
tableC_BGD = array2table(C.BGD, 'VariableNames', header1);
tableC_CHN = array2table(C.CHN, 'VariableNames', header1);
tableC_MYS = array2table(C.MYS, 'VariableNames', header1);
tableC_VNM = array2table(C.VNM, 'VariableNames', header1);
tableC_LAO = array2table(C.LAO, 'VariableNames', header1);
tableC_THA = array2table(C.THA, 'VariableNames', header1);

% Convert GVC data to tables
tableGVC_PAK = array2table(GVC.PAK, 'VariableNames', header2);
tableGVC_IND = array2table(GVC.IND, 'VariableNames', header2);
tableGVC_BGD = array2table(GVC.BGD, 'VariableNames', header2);
tableGVC_CHN = array2table(GVC.CHN, 'VariableNames', header2);
tableGVC_MYS = array2table(GVC.MYS, 'VariableNames', header2);
tableGVC_VNM = array2table(GVC.VNM, 'VariableNames', header2);
tableGVC_LAO = array2table(GVC.LAO, 'VariableNames', header2);
tableGVC_THA = array2table(GVC.THA, 'VariableNames', header2);

% Save C data as CSV files
writetable(tableC_PAK, output_filepathC_PAK);
writetable(tableC_IND, output_filepathC_IND);
writetable(tableC_BGD, output_filepathC_BGD);
writetable(tableC_CHN, output_filepathC_CHN);
writetable(tableC_MYS, output_filepathC_MYS);
writetable(tableC_VNM, output_filepathC_VNM);
writetable(tableC_LAO, output_filepathC_LAO);
writetable(tableC_THA, output_filepathC_THA);

% Save GVC data as CSV files
writetable(tableGVC_PAK, output_filepathGVC_PAK);
writetable(tableGVC_IND, output_filepathGVC_IND);
writetable(tableGVC_BGD, output_filepathGVC_BGD);
writetable(tableGVC_CHN, output_filepathGVC_CHN);
writetable(tableGVC_MYS, output_filepathGVC_MYS);
writetable(tableGVC_VNM, output_filepathGVC_VNM);
writetable(tableGVC_LAO, output_filepathGVC_LAO);
writetable(tableGVC_THA, output_filepathGVC_THA);
% Optional: Display completion message
    end
    disp('All COUNTRY and GVC data files have been saved successfully.');
    year
    clear all
end