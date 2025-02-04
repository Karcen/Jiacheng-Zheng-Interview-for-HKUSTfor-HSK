clc;
tic;


clear;
G=3;
N=4;
GN=G*N;
fd_components=2;
% in full Eora, fd_components=6;

    t = dlmread('t.txt','\t');
    fd = dlmread('fd.txt','\t');
    for i = 1:G
        y(:,i)=sum(fd(:,((i-1)*fd_components+1):fd_components*i),2);
    end
    % In full Eora, may need to eliminate the statistical discrepancy line    
    % y=y(1:4914,:);
    % t=t(1:4914,:);
    for i = 1:G
        x(:,i)= sum(t(:,((i-1)*N+1):N*i),2) + y(:,i);
    end
    % x=x(1:4914,:);
    % t=t(1:4914,1:4914);
    for i=1:GN
        xt(i,:)=sum(x,2)';
    end
    
    A = t./xt;
    % In full Eora, need a small adjustment for matrices to invert    
    % A(3600,:)=0.0000001;
    % A(:,3600)=0.0000001;

    B = inv(eye(GN)-A);
    V_hat= eye(GN) - diag(sum(A,1));
    for i=1:G
        j=(i-1)*N+1;
        V(i,:)=sum(V_hat(j:N*i,:,1));
    end
    VB=V*B;
    id_temp=eye(GN);
    for i = 1:G
        id(:,i)= sum(id_temp(:,((i-1)*N+1):N*i),2);
    end
    e_bysector = sum(x-id.*x,2);
    for i = 1:G
        e_xpose(i,:)= sum(e_bysector(((i-1)*N+1):N*i));
    end
    e=e_xpose';
    tv=V_hat*B*diag(e_bysector);

    id_blockeye=blkdiag(ones(N));
    for i=1:(G-1)
        id_blockeye=blkdiag(id_blockeye,ones(N));
    end
    
    %---- DVA, FVA, DVX -------------------------------------------------
    % DVA and FVA (gross), country-sector level
    DVA = sum(id_blockeye.*tv,1);
    FVA = sum(tv,1)-DVA;

    % DVA and FVA (share of exports), country-sector level
    DVA_cs_pct_exp=DVA./e_bysector';
    FVA_cs_pct_exp=FVA./e_bysector';
    
    % DVA and FVA, country level
    for i = 1:G
        DVA_c(1,i)= sum(DVA(1,((i-1)*N+1):N*i),2);
    end
    for i = 1:G
        FVA_c(1,i)= sum(FVA(1,((i-1)*N+1):N*i),2);
    end
    DVA_c_pct_exp = DVA_c./e;
    FVA_c_pct_exp = FVA_c./e;

    % DVX, country-sector level
    DVX_temp = sum(tv,2);
    DVX=(DVX_temp-DVA')';
    DVX_cs_pct_exp=DVX./e_bysector';
    % DVX, country level
    for i = 1:G
        DVX_c(1,i)= sum(DVX(1,((i-1)*N+1):N*i),2);
    end
    DVX_c_pct_exp = DVX_c./e;
    %--------------------------------------------------------------------
    
    
    %----VERYFIY CALCUALTIONS FROM USER GUIDE----------------------------
    % x_ug, y_ug refer to equations in the user guide (ug), x_ug=(A*x_ug+y_ug);
    %--------------------------------------------------------------------
    x_ug = sum(x,2);
    y_ug = sum(y,2);
    disp('The following should be a vector of zeros.');
    x_ug-(A*x_ug+y_ug);

    disp('By definition, DVA+FVA=1, must be true for each country-sector. Verify below.');
    DVA_cs_pct_exp + FVA_cs_pct_exp
    disp('By definition, DVA+FVA=1, must be true for each country. Verify with output below.')
    DVA_c_pct_exp + FVA_c_pct_exp

    disp('Verify DVA and FVA shares based on V_hat*B, as explained in UG.');
    Tv_I = V_hat*B*eye(GN);
    DVA_I=sum(id_blockeye.*Tv_I,1);
    disp('DVA_I and DVA_cs_pct_exp are equal');
    DVA_I-DVA_cs_pct_exp;
    disp('Elements of each column of V_hat*B, the value added share matrix, sum to 1');
    sum(V_hat*B,1);
    disp('By definition, at the world level DVX=FVA.');
    sum(DVX)-sum(FVA);
    %--------------------------------------------------------------------
    
   
    %---- EXPORTS -----------------------------------------------------
    % bilateral exports (intermediate and final), country-sector level
    e_b_intmd_bysector_both= t - t.*id_blockeye;
    for i=1:G
        e_b_intmd_bysector(:,i) = sum(e_b_intmd_bysector_both(:,((i-1)*N+1):N*i),2); 
    end
    e_b_final_bysector = y-y.*id;
    % bilateral exports (intermediate and final), country level
    for i=1:G
        e_b_intmd(i,:) = sum(e_b_intmd_bysector(((i-1)*N+1):N*i,:),1); 
    end
    for i=1:G
        e_b_final(i,:) = sum(e_b_final_bysector(((i-1)*N+1):N*i,:),1); 
    end
    % bilateral exports, gross, country level
    e_b_gross_bysector = x-id.*x;
    e_b_gross = e_b_intmd+e_b_final;

    % gross (non-BILATERAL) exports
    e_bysector = sum(x-id.*x,2);
    for i = 1:G
        e_xpose(i,:)= sum(e_bysector(((i-1)*N+1):N*i));
    end
    e=e_xpose';
    %--------------------------------------------------------------------
      
    
    %---- KOOPMAN et al 6 term DECOMPOSITION ----------------------------
    V_cell = cell(G);
    B_cell = cell(G);
    y_cell = cell(G);
    x_cell = cell(G);
    A_cell = cell(G);
    e_bysector_cell = cell(G,1);
    for i=1:G
        for j=1:G
            V_cell{i,j}=V(i,((j-1)*N+1):N*j);
        end
    end
    for i=1:G
        for j=1:G
            B_cell{i,j}=B(((i-1)*N+1):N*i,((j-1)*N+1):N*j);
        end
    end
    for i=1:G
        for j=1:G
            y_cell{i,j}=y(((i-1)*N+1):N*i,j);
        end
    end
    for i=1:G
        for j=1:G
            x_cell{i,j}=x(((i-1)*N+1):N*i,j);
        end
    end
    
    for i=1:G
        for j=1:G
            A_cell{i,j}=A(((i-1)*N+1):N*i,((j-1)*N+1):N*j);
        end
    end
    for i=1:G
        e_cell{i,1}=e_bysector(((i-1)*N+1):N*i,1);
    end
    e_diag_temp = diag(e_bysector);
    for i = 1:G
        e_diag(:,i)=sum(e_diag_temp(:,((i-1)*N+1):N*i),2);
    end
    for i=1:G
        for j=1:G
            e_cell_diag{i,j}=e_diag(((i-1)*N+1):N*i,j);
        end
    end
    %--------------
    % term1 is the 1st term in Koopman eq 36
    %--------------
    for s=1:G
        for r=1:G
            term1(s,r)=V_cell{s,s}*B_cell{s,s}*y_cell{s,r};
        end
    end
    for s=1:G
        term1(s,s)=0;
    end
    % term1_b is bilateral
    term1_b=term1;
    term1=sum(term1,2);
    term1_pct_export= term1./e';
    sum_terms1=term1_pct_export;
    disp('Done with term 1')

    %--------------
    % term2 is the 2nd term in Koopman eq 36
    %--------------
    for s=1:G
        for r=1:G
            term2(s,r)=V_cell{s,s}*B_cell{s,r}*y_cell{r,r};
        end
    end
    for s=1:G
        term2(s,s)=0;
    end
    % term2_b is bilateral
    term2_b=term2;
    term2=sum(term2,2);
    term2_pct_export=term2./e';
    sum_terms2=sum_terms1+term2_pct_export;
    disp('Done with term 2')
       
    %--------------
    % term3 is the 3rd term in Koopman eq 36
    %--------------
    for s=1:G
        for r=1:G
            B_cell_t3{s,r}=B_cell{s,r};
            B_cell_t3{s,s}=zeros(N);    %sets diagonal terms to zero in the B matrix
            y_cell_t3{s,r}=y_cell{s,r};
            y_cell_t3{s,s}=zeros(N,1);  %sets diagonal terms to zero in the y matrix
        end
    end
    for s=1:G
        for r=1:G
            for q=1:G
                B_term3{s,r,q}=zeros(N);
                B_term3{s,r,s}=B_cell_t3{s,r};     %leaves rows set to zero, and puts above modified B_cell when s=t
                y_term3{s,r,q}=y_cell_t3{s,r};     %puts above modified y_cell everywhere
                y_term3{s,r,r}=zeros(N,1);         %then sets columns to zero when r=t
            end
        end
    end
    B_term3_m=cell2mat(B_term3);
    y_term3_m=cell2mat(y_term3);
    % clear B_term3;
    clear y_term3;
    for q=1:G
        term3_1m(:,:,q)=B_term3_m(:,:,q)*y_term3_m(:,:,q);
    end
    term3_1m_reshape = reshape(term3_1m,[GN,G*G]);
    % clear term3_1m B_term3_m y_term3_m;
    clear term3_1m y_term3_m;
    % term3_b stands for bilateral
    term3_b_temp = V*term3_1m_reshape;
    for i=1:G
        term3_b(i,:)=term3_b_temp(i,((i-1)*G+1):G*i);
    end   
    sum_term3_1m = sum(term3_1m_reshape,2);
    term3 = V*sum_term3_1m;
    term3_pct_export=term3./e';
    sum_terms3=sum_terms2+term3_pct_export;
    disp('Done with term 3')

    % Note that you can sum term1, term2 and term3 to get the VAX.
    
    %--------------
    % term4 is the 4th term in Koopman eq 36
    %--------------
    B_cell_t4=B_cell;
    y_cell_t4=y_cell;
    for s=1:G
        B_cell_t4{s,s}=zeros(N);
        y_cell_t4{s,s}=zeros(N,1);
    end
    B_cell_t4m=cell2mat(B_cell_t4);
    y_cell_t4m=cell2mat(y_cell_t4);
    term4_part1m = B_cell_t4m*y_cell_t4m;
    term4=V*(term4_part1m.*id);
    term4=sum(term4,2);
    term4_pct_export=term4./e';
    sum_terms4=sum_terms3+term4_pct_export;
    disp('Done with term 4')
    %--------------
    % term5 is the 5th term in Koopman eq 36
    %--------------
    % This partly uses code for term4, so instead of B_cell_t5, use B_cell_t4
    A_cell_t5=A_cell;
    for s=1:G
        A_cell_t5{s,s}=zeros(N,N);
    end
    A_cell_t5m=cell2mat(A_cell_t5);
    term5_part1m = B_cell_t4m*A_cell_t5m;
    id_t5=blkdiag(ones(N));
    for i=1:(G-1)
        id_t5=blkdiag(id_t5,ones(N));
    end
    term5_part1m = term5_part1m.*id_t5;
    for s=1:G
        for r=1:G
            term5_part2{s,r}=zeros(N,1);
        end
    end
    for s=1:G
        term5_part2{s,s}=inv(eye(N)-A_cell{s,s})*y_cell{s,s};
    end
    term5_part2m=cell2mat(term5_part2);
    term5=V*sum(term5_part1m*term5_part2m,2);
    term5_pct_export=term5./e';
    sum_terms5=sum_terms4+term5_pct_export;
    disp('Done with term 5')
    %--------------
    % term6 is the 6th term in Koopman eq 36
    %--------------
    % This partly uses code from term4 and term5
    term6_part1m = term5_part1m;
    for s=1:G
        for r=1:G
            term6_part2{s,r}=zeros(N,1);
        end
    end
    for s=1:G
        term6_part2{s,s}=inv(eye(N)-A_cell{s,s})*e_cell_diag{s,s};
    end
    term6_part2m=cell2mat(term6_part2);
    term6=V*sum(term6_part1m*term6_part2m,2);
    term6_pct_export=term6./e';
    sum_terms6=sum_terms5+term6_pct_export;
    disp('Done with term 6')
    disp('The difference between the sum of 6 decomposed terms and DVA (Eora calc) should be zero');
    max(DVA_c_pct_exp'-sum_terms6);

    
    %---- Additional term to recover DVX ----------
    % DVX = terms 3,4 5, and 6, plus the extra term, see Koopman eq 42
    %----------------------------------------------
    for s=1:G
        for r=1:G
            A_cell_DVXextra{s,r}=A_cell{s,r};
            A_cell_DVXextra{s,s}=zeros(N);  
       end
    end
    for s=1:G
        for r=1:G
            for q=1:G
                A_DVXextra{s,r,q}=A_cell_DVXextra{s,r};     
                A_DVXextra{s,r,r}=zeros(N);                 
            end
        end
    end
    A_DVXextra_m=cell2mat(A_DVXextra);
    clear B_term3;
    clear A_DVXextra;
    for q=1:G
      term_DVXextra_1m(:,:,q)=B_term3_m(:,:,q)*A_DVXextra_m(:,:,q);
    end
    term_DVXextra_1m_sum=zeros(GN);
    for i=1:G
       term_DVXextra_1m_sum= term_DVXextra_1m_sum+term_DVXextra_1m(:,:,i);
    end
    term_DVXextra=V*term_DVXextra_1m_sum*sum(x,2);
    term_DVXextra_pct_export=term_DVXextra./e';
    sum_terms3456extra=term3_pct_export+term4_pct_export+term5_pct_export+term6_pct_export+term_DVXextra_pct_export;
    sum_terms3456=term3_pct_export+term4_pct_export+term5_pct_export+term6_pct_export;
    disp('the following should equal zero (or very close)'); 
    DVX_c_pct_exp'-sum_terms3456extra;
    disp('Done with term DVX extra term from Koopman equation 42')
    %--------------------------------------------------------------------
    
  
    
% dlmwrite('Q:\DATA\RS\Research\Trade Asia LAC\Data\MRIO\Data\Data BP\Eora26_1990_bp\term1_1990_bp.txt',term1_pct_export,'\t');
% dlmwrite('Q:\DATA\RS\Research\Trade Asia LAC\Data\MRIO\Data\Data BP\Eora26_1990_bp\term2_1990_bp.txt',term2_pct_export,'\t');
% dlmwrite('Q:\DATA\RS\Research\Trade Asia LAC\Data\MRIO\Data\Data BP\Eora26_1990_bp\term3_1990_bp.txt',term3_pct_export,'\t');
% dlmwrite('Q:\DATA\RS\Research\Trade Asia LAC\Data\MRIO\Data\Data BP\Eora26_1990_bp\term4_1990_bp.txt',term4_pct_export,'\t');
% dlmwrite('Q:\DATA\RS\Research\Trade Asia LAC\Data\MRIO\Data\Data BP\Eora26_1990_bp\term5_1990_bp.txt',term5_pct_export,'\t');
% dlmwrite('Q:\DATA\RS\Research\Trade Asia LAC\Data\MRIO\Data\Data BP\Eora26_1990_bp\term6_1990_bp.txt',term6_pct_export,'\t');
%     
% dlmwrite('Q:\DATA\RS\Research\Trade Asia LAC\Data\MRIO\Data\Data BP\Eora26_2006_bp\e_b_gross_2006_bp.txt',e_b_gross,'\t'); 
% dlmwrite('Q:\DATA\RS\Research\Trade Asia LAC\Data\MRIO\Data\Data BP\Eora26_2006_bp\e_b_final_2006_bp.txt',e_b_final,'\t'); 
% dlmwrite('Q:\DATA\RS\Research\Trade Asia LAC\Data\MRIO\Data\Data BP\Eora26_2006_bp\e_b_intmd_2006_bp.txt',e_b_intmd,'\t'); 
% dlmwrite('Q:\DATA\RS\Research\Trade Asia LAC\Data\MRIO\Data\Data BP\Eora26_2006_bp\term1_b_2006_bp.txt',term1_b,'\t');
% dlmwrite('Q:\DATA\RS\Research\Trade Asia LAC\Data\MRIO\Data\Data BP\Eora26_2006_bp\term2_b_2006_bp.txt',term2_b,'\t');
% dlmwrite('Q:\DATA\RS\Research\Trade Asia LAC\Data\MRIO\Data\Data BP\Eora26_2006_bp\term3_b_2006_bp.txt',term3_b,'\t');    
 

