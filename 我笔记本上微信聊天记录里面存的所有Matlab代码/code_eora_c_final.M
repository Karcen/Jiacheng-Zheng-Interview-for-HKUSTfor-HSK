% *************************************************************************
% Compute Value Added in Exports
% 
% Created by Aqib Aslam, Mar 27, 2016.
% See Aslam, Novta, and Rodrigues-Bastos (2017)
% Please cite working paper if code is used.
% 
% Notes:
% Uses Eora MRIO tables.
% Change filepath_id for inputting Eora MRIO tables in section (A).
% Change output paths in final section (M) for outputting GVC measures.
% *************************************************************************
clear all;
clc;

%% Parameters

ncntry  = 189;    % Number of countries
nsec    = 26;     % Number of sectors
nfd     = 6;      % Number of final demand components

%% EORA Loop

for i = 1990:2013

    tic;
    
    year = num2str(i);
        
    %% (A) Read in data
    % Add appropriate file location.
    
    filepath_id = ['...\Eora26_' year '_bp\Eora26_' year '_bp_T.txt'];
    filepath_fd = ['...\Eora26_' year '_bp\Eora26_' year '_bp_FD.txt'];
    filepath_va = ['...\Eora26_' year '_bp\Eora26_' year '_bp_VA.txt'];

    %% Define the Intermediate Use and Final Demand Sections of Matrix
    % Global bilateral gross trade matrices by exporting industry/country (y-dim, rows)
    % and importing (industry/)country (x-dim, cols) for intermediate (INT) or final (FNL) goods

    % intermediate use matrix ((ncntry*nsec)+1) x ((ncntry*nsec)+1)
    id = dlmread(filepath_id,'\t');

    % final demand matrix ((ncntry*nsec)+1) x ((ncntry*nsec)+nfd)
    fd = dlmread(filepath_fd,'\t');
    % Summing over all 6 components of final demand for each country [(ncntry*nsec) x ncntry]
    FD = squeeze(sum(reshape(fd,ncntry*nsec+1,nfd,[]),2));
        
    % value added matrix (6 x ((ncntry*nsec)+1)
    va_components = dlmread(filepath_va,'\t');
    va_total_cs = sum(va_components,1)';
    
    %% Drop the final statistical discrepancy row/column from matrix (aka Rest of World)
    GRTR_INT_cs_cs = id(1:ncntry*nsec,1:ncntry*nsec);  % intermediate demand
    GRTR_FNL_cs_c = FD(1:ncntry*nsec,1:ncntry);              % final demand
    VALU_cs = va_total_cs(1:ncntry*nsec,1);
  
    %% (B) Identity matrices for summing across sectors (when calculating totals by country)
    
    imtx_cs_c=[];
    iblk=ones(nsec,1);
    for i=1:ncntry
        % Construct block diagonal matrix with blocks of ones(nsec,nsec) on the diagonal
        imtx_cs_c=blkdiag(imtx_cs_c,iblk);
    end
    
    imtx_cs_cs=[];
    iblk=ones(nsec,nsec);
    for i=1:ncntry
        % Construct block diagonal matrix with blocks of ones on the diagonal
        imtx_cs_cs=blkdiag(imtx_cs_cs,iblk);
    end
    
    % Build block diagonal matrix for aggregation across sectors to country
    % level
    imtx_c_cs=[];
    ivector=ones(1,nsec);
    for i=1:ncntry
        imtx_c_cs=blkdiag(imtx_c_cs,ivector);
    end
    
    imtx_c_c= eye(ncntry);
    
    imtx_cs_ck=[];
    iblk=ones(nsec,nfd);
    for i=1:ncntry
        % Construct block diagonal matrix with blocks of ones(nsec,nsec) on the diagonal
        imtx_cs_ck=blkdiag(imtx_cs_ck,iblk);
    end
    
    
    %% (C) Calculating Gross Ouput (GO)
    % Sum across all nsec sectors by country for intermediate demand
    % and then add total final demand

    % Without statistical discrepancy
    GO_cs_c = squeeze(sum(reshape(GRTR_INT_cs_cs,ncntry*nsec,nsec,[]),2)) + GRTR_FNL_cs_c;
    GO_cs = sum(GO_cs_c,2);
    
    % Aggregate gross output matrix across sectors [ncntry x ncntry]
    GO_c_c = imtx_c_cs*GO_cs_c; % aggregate rows

    % Total gross output for each country-sector [ncntry*nsec x 1], sum across columns
    GO_c = sum((repmat(GO_cs,1,ncntry).*imtx_cs_c),1)';
        
    
    %% (D) VALUE-ADDED (VALU)
    
    VALU_c = sum((repmat(VALU_cs,1,ncntry).*imtx_cs_c),1)';
    
    %% Derived Value-Added
    
    % (1) Without statistical discrepancy
    
    % Sum across rows of the Intermediate demand matrix
    Inputs_cs = sum(GRTR_INT_cs_cs,1)';
    Inputs_c = sum((repmat(Inputs_cs,1,ncntry).*imtx_cs_c),1)';
    
    % VA = Gross Output - Inputs
    VALU_derived_cs = GO_cs - Inputs_cs;
    VALU_derived_c = sum((repmat(VALU_derived_cs,1,ncntry).*imtx_cs_c),1)';
    
    % (2) With statistical discrepancy (RoW)
    
    for j = 1:ncntry+1
        FD_wROW(:,j)=sum(fd(:,((j-1)*nfd+1):nfd*j),2);
    end
    
    imtx_cs_c_wROW=[];
    iblk=ones(nsec,1);
    for i=1:ncntry+1
        % Construct block diagonal matrix with blocks of ones(nsec,nsec) on the diagonal
        imtx_cs_c_wROW=blkdiag(imtx_cs_c_wROW,iblk);
    end
    imtx_cs_c_wROW = imtx_cs_c_wROW(1:ncntry*nsec+1,:);
    
    GO_cs_c_wROW = nan(ncntry*nsec+1,ncntry+1);
    for k = 1:ncntry
        % Sum of intermediate goods and final demand = gross output (or
        % total input), (ncntry*nsec+1 x ncntry+1)
        GO_cs_c_wROW(:,k)= sum(id(:,((k-1)*nsec+1):nsec*k),2) + FD_wROW(:,k);
    end
    GO_cs_c_wROW(:,ncntry+1) = id(:,ncntry*nsec+1) + FD_wROW(:,ncntry+1);
    GOtotal_cs_wROW = sum(GO_cs_c_wROW,2);
    GOtotal_c_wROW = sum((repmat(GOtotal_cs_wROW,1,ncntry+1).*imtx_cs_c_wROW),1)';
    
    Inputs_cs_wROW = sum(id,1)';
    Inputs_c_wROW = sum((repmat(Inputs_cs_wROW,1,ncntry+1).*imtx_cs_c_wROW),1)';
       
    VALU_derived_cs_wROW = GOtotal_cs_wROW - sum(id,1)';
    VALU_derived_c_wROW  = sum((repmat(VALU_derived_cs_wROW,1,ncntry+1).*imtx_cs_c_wROW),1)';

    %% (E) Gross Exports
    
    % Gross exports of intermediate goods and services from domestic
    % sector s in country c
    EXGR_INT_cs_cs = GRTR_INT_cs_cs.*(ones(ncntry*nsec)-imtx_cs_cs);
    EXGR_INT_cs_c = nan(ncntry*nsec,ncntry);
    for k = 1:ncntry
        EXGR_INT_cs_c(:,k)= sum(EXGR_INT_cs_cs(:,((k-1)*nsec+1):nsec*k),2);
    end
    EXGR_INT_cs = sum((EXGR_INT_cs_cs),2);
    EXGR_INT_c = sum(repmat(EXGR_INT_cs,1,ncntry).*imtx_cs_c,1)';
    
    % Gross exports of final demand goods and services from domestic
    % sector s in country c
    EXGR_FNL_cs_c = GRTR_FNL_cs_c.*(ones(ncntry*nsec,ncntry)-imtx_cs_c);
    EXGR_FNL_cs = sum(GRTR_FNL_cs_c.*(ones(ncntry*nsec,ncntry)-imtx_cs_c),2);
    EXGR_FNL_c = sum(repmat(EXGR_FNL_cs,1,ncntry).*imtx_cs_c,1)';
    
    % Total gross exports (country-sector x country)
    EXGR_cs_c = EXGR_INT_cs_c + EXGR_FNL_cs_c;
    EXGR_c_c = imtx_c_cs*EXGR_cs_c;
     
    % Total gross exports (country-sector x 1)
    EXGR_cs = EXGR_INT_cs + EXGR_FNL_cs;
    % EXGR_cs = sum(GO_cs_c.*(ones(ncntry*nsec,ncntry)-imtx_cs_c),2);
    % EXGR_cs = sum(GOndom_cs_c,2);
    
    % Total gross exports (country x 1)
    EXGR_c = EXGR_INT_c + EXGR_FNL_c;
    % EXGR_c = sum(repmat(EXGR_cs,1,ncntry).*imtx_cs_c,1)';
    % EXGR_c = sum(EXGR_c_c,2);
    
    %clear GOdom GX imtx3
    
    %% (F) Gross Imports: (Imported Intermediates)
    
    % Gross Imports of Intermediates (by country-sector, and by country)
    IMGR_INT_cs = sum(GRTR_INT_cs_cs.*(ones(ncntry*nsec)-imtx_cs_cs),1)';
    IMGR_INT_c = sum((repmat(IMGR_INT_cs,1,ncntry).*imtx_cs_c),1)';
    
    % Gross Imports of Final Demand goods and services (by country)
    IMGR_FNL_c = sum(GRTR_FNL_cs_c.*(ones(ncntry*nsec,ncntry)-imtx_cs_c),1)';
 
    % Total gross imports (by country)
    IMGR_c = IMGR_INT_c + IMGR_FNL_c;
    %IMGR_c = sum(GOndom,1)';
    
    %% (G) Gross trade balance
    
    BALGR_c = EXGR_c - IMGR_c;
      
    %% (H) Demand for Domestic Inputs (Use of Domestic Intermediates)
    
    % Gross Domestic Intermediate demand for domestic inputs by country-sector
    DDGR_INT_cs = sum(GRTR_INT_cs_cs.*imtx_cs_cs,1)';
    DDGR_INT_c = sum((repmat(DDGR_INT_cs,1,ncntry).*imtx_cs_c),1)';
        
    % Gross Domestic Final demand of domestic inputs by country-sector
    DDGR_FNL_c = sum(GRTR_FNL_cs_c.*imtx_cs_c,1)';
    
    %% (I) Domestic and Foreign Final Demand

    GRTR_FNL_DOM_cs_c = GRTR_FNL_cs_c.*imtx_cs_c;
    GRTR_FNL_DOM_cs = sum(GRTR_FNL_DOM_cs_c,2);
    
    % By sector
    GRTR_FNL_DOM_cs_ck = fd(1:ncntry*nsec,1:ncntry*nfd).*imtx_cs_ck;
    % Sum across the thrid dimension, across countries for each of the 6 components of final demand
    GRTR_FNL_DOM_cs_nfd = sum(reshape(GRTR_FNL_DOM_cs_ck,ncntry*nsec,nfd,[]),3);
    
    GRTR_FNL_FOR_cs_c = GRTR_FNL_cs_c.*(ones(ncntry*nsec,ncntry)-imtx_cs_c);
    GRTR_FNL_FOR_cs = sum(GRTR_FNL_FOR_cs_c,2);
    
    % By sector
    GRTR_FNL_FOR_cs_ck = fd(1:ncntry*nsec,1:ncntry*nfd).*(ones(ncntry*nsec,ncntry*nfd)-imtx_cs_ck);
    % Sum across the thrid dimension, across countries for each of the 6 components of final demand
    GRTR_FNL_FOR_cs_nfd = sum(reshape(GRTR_FNL_FOR_cs_ck,ncntry*nsec,nfd,[]),3);
    
    
    
    %% (J) Compute the VA vector indirectly (just to check that no problems with inverses)

    % A matrix, input-output coefficients (share of gross output)
    Amat = GRTR_INT_cs_cs./repmat(GO_cs,1,ncntry*nsec)'; 
    Amat(isnan(Amat))=0;
    Amat(isinf(Amat))=0;

    % VA shares
    va_vec_cs=1-sum(Amat)'; %vector of value added shares
    V_hat= eye(ncntry*nsec) - diag(sum(Amat,1)); %diagonal matrix of value added shares
    
    % Leontief inverse
    IminusA=eye(ncntry*nsec)-Amat;
    Bmat=inv(IminusA); % Leontief inverse
    
    % Total Value Added by country-sector
    BY=Bmat*sum(GRTR_FNL_cs_c,2);
    va_cs=va_vec_cs.*BY;
    

    %% (K) DVA and FVA of gross exports (From V*B*E)
    
    TiVA=V_hat*Bmat*diag(EXGR_cs);
    
    EXGR_DVA_cs = sum(TiVA.*imtx_cs_cs,1)';
    EXGR_FVA_cs = sum(TiVA.*(ones(ncntry*nsec)-imtx_cs_cs),1)';
        
    EXGR_DVA_c = sum(repmat(EXGR_DVA_cs,1,ncntry).*imtx_cs_c,1)';
    EXGR_FVA_c = sum(repmat(EXGR_FVA_cs,1,ncntry).*imtx_cs_c,1)';
    
    VS1_cs = sum(TiVA.*(ones(ncntry*nsec)-imtx_cs_cs),2);
    VS1_c = sum(repmat(VS1_cs,1,ncntry).*imtx_cs_c,1)';
    
   
    %% (L) Compute VA matrices (from V*B*Y)
    % Off-diagonal elements give you the VAX components
    VA_cs_c = V_hat*Bmat*GRTR_FNL_cs_c;
    
    % Total VAX (= VAX1 + VAX2 + VAX3); VAX_c is same as FFD_DVA
    VAX_cs_c = VA_cs_c.*(ones(ncntry*nsec,ncntry)-imtx_cs_c);
    VA_c_c = imtx_c_cs*VA_cs_c; % aggregate across rows by country
    VAX_c_c = VA_c_c.*(ones(ncntry,ncntry)-eye(ncntry)); % value added of exports only (exclude value-added of domestic goods)
    VAX_c = sum(VAX_c_c,2);

    % Term 1 in Equation 36 in Koopman et al. (2014)
    VAX1_cs_c = V_hat*(Bmat.*imtx_cs_cs)*(GRTR_FNL_cs_c.*(ones(ncntry*nsec,ncntry)-imtx_cs_c));
    VAX1_c_c = imtx_c_cs*VAX1_cs_c; % aggregate across rows by country
    VAX1_c = sum(VAX1_c_c,2);
    
    % Term 2 in Equation 36 in Koopman et al. (2014)
    VAX2_cs_c = V_hat*(Bmat.*(ones(ncntry*nsec)-imtx_cs_cs))*(GRTR_FNL_cs_c.*imtx_cs_c);
    VAX2_c_c = imtx_c_cs*VAX2_cs_c; % aggregate across rows by country
    VAX2_c = sum(VAX2_c_c,2);

    % Term 3 in Equation 36 in Koopman et al. (2014)
    VAX3_cs_c_sum1 = V_hat*(Bmat.*(ones(ncntry*nsec)-imtx_cs_cs))*(GRTR_FNL_cs_c.*(ones(ncntry*nsec,ncntry)-imtx_cs_c));
    VAX3_cs_c_sum2 = VAX3_cs_c_sum1.*(ones(ncntry*nsec,ncntry)-imtx_cs_c);
    VAX3_c_c = imtx_c_cs*VAX3_cs_c_sum2; % aggregate across rows by country
    VAX3_c = sum(VAX3_c_c,2);
        
    % Term 4 in Equation 36 in Koopman et al. (2014)
    DVA4_cs_c = V_hat*(Bmat.*(ones(ncntry*nsec)-imtx_cs_cs))*(GRTR_FNL_cs_c.*(ones(ncntry*nsec,ncntry)-imtx_cs_c));
    DVA4_c_c = (imtx_c_cs*DVA4_cs_c).*imtx_c_c;  % aggregate across rows by country, and take just the diagonal elements
    DVA4_c = sum(DVA4_c_c,2);
    
    % Term 5 in Equation 36 in Koopman et al. (2014)
    DVA5_cs_c = V_hat*(Bmat.*(ones(ncntry*nsec)-imtx_cs_cs))*(Amat.*(ones(ncntry*nsec)-imtx_cs_cs))*(inv(eye(ncntry*nsec)-Amat).*imtx_cs_cs)*(GRTR_FNL_cs_c.*imtx_cs_c);
    DVA5_c_c = (imtx_c_cs*DVA5_cs_c).*imtx_c_c;  % aggregate across rows by country, and take just the diagonal elements
    DVA5_c = sum(DVA5_c_c,2);
    
    % Term 6 in Equation 36 in Koopman et al. (2014)
    DVA6_c = EXGR_DVA_c - VAX_c - DVA4_c - DVA5_c;
    
    % Additional VS1 term

    VS1i_cs_c_sum1 = (Bmat.*(ones(ncntry*nsec)-imtx_cs_cs))*(Amat.*(ones(ncntry*nsec)-imtx_cs_cs))*GO_cs_c;
    VS1i_cs_c_sum2 = V_hat*(VS1i_cs_c_sum1.*(ones(ncntry*nsec,ncntry)-imtx_cs_c));
    VS1i_c_c = imtx_c_cs*VS1i_cs_c_sum2; % aggregate across rows by country
    VS1i_c = sum(VS1i_c_c,2);
    
    % DFD_FVA (Foreign Value Added in Domestic Final Demand)
    DFD_FVA_c = sum(VAX_c_c,1)';
                
    %% (M) Export data
 
    data_export_c = [GO_c EXGR_INT_c EXGR_FNL_c EXGR_c ...
                    IMGR_INT_c IMGR_FNL_c IMGR_c BALGR_c ...
                    DDGR_INT_c DDGR_FNL_c ...
                    EXGR_DVA_c EXGR_FVA_c VS1_c...
                    VAX_c DFD_FVA_c ...
                    VAX1_c VAX2_c VAX3_c DVA4_c DVA5_c DVA6_c ...
                    VALU_c VALU_derived_c VALU_derived_c_wROW(1:ncntry,1)];
                
  
    cd('...\output_from_matlab')
    filename2 = ['data_c' year '.csv'];
    dlmwrite(filename2,data_export_c,'precision','%.6f');
    
    display(['Year: ' year ' complete']);

    toc;
end