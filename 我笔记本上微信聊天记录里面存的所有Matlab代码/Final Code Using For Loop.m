baseDir = 'E:\EORA\';

% Define parameters
S = 189;   % Number of countries
N = 26;    % Number of sectors
nfd = 6;   % Number of final demand categories
num_country = 189;
num_sector = 26;

% Years and shocks to process
years = {'2019', '2001'};
shocks = [0.05, 0.10]; % Shock percentages
orders = [-1, 1]; % Negative and Positive shock
shockTypes = {'row', 'column', 'both'}; % Shock types

for i = 1:length(years)
    targetYear = years{i};
    currentDir = fullfile(baseDir, ['Eora26_' targetYear '_bp']);
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
    FD1 = squeeze(sum(reshape(FD, S*N+1, nfd, []), 2));
    FD1(:, end) = [];  % Delete the last column
    FD1(end, :) = [];  % Delete the last row

    FD1(FD1 == 0) = 0.000001;
    Finaldemand = FD1;

    V1 = readmatrix(V_file);
    VA = sum(V1, 1); % Value added
    VA(:, end) = [];  % Delete the last column

    TI = sum(Z, 1) + sum(VA, 1);

    A = Z ./ TI;
    A(isnan(A)) = 0;
    A(isinf(A)) = 0;

    B = inv(eye(S * N) - A);
    B(isnan(B)) = 0;
    B(isinf(B)) = 0;

    % Apply shocks
    for j = 1:length(shocks)
        shockValue = shocks(j);
        for k = 1:length(orders)
            orderFactor = orders(k);
            shock = shockValue * orderFactor;

            for t = 1:length(shockTypes)
                shockType = shockTypes{t};

                % Apply shock to A matrix
                A_shock = A;
                switch shockType
                    case 'row'
                        % Shock entire row (e.g., country 40)
                        A_shock((40-1)*num_sector+1:40*num_sector, :) = ...
                            A((40-1)*num_sector+1:40*num_sector, :) * (1 + shock);
                    case 'column'
                        % Shock entire column (e.g., country 40)
                        A_shock(:, (40-1)*num_sector+1:40*num_sector) = ...
                            A(:, (40-1)*num_sector+1:40*num_sector) * (1 + shock);
                    case 'both'
                        % Apply shock to rows for country 40
                        A_shock((40-1)*num_sector+1:40*num_sector, :) = ...
                            A((40-1)*num_sector+1:40*num_sector, :) * (1 + shock);
                    
                        % Split column shock into upper and lower block
                        % Upper block (before the rows of country 40)
                        A_shock(1:(40-1)*num_sector, (40-1)*num_sector+1:40*num_sector) = ...
                            A(1:(40-1)*num_sector, (40-1)*num_sector+1:40*num_sector) * (1 + shock);
                    
                    
                        % Lower block (rows after the rows of country 40)
                        A_shock(40*num_sector+1:end, (40-1)*num_sector+1:40*num_sector) = ...
                            A(40*num_sector+1:end, (40-1)*num_sector+1:40*num_sector) * (1 + shock);

                end

                % Apply shock to FD
                FD_shock = FD1;
                FD_shock(:, 40) = FD1(:, 40) * (1 + shock);

                % Calculate impacted matrices
                Y1 = sum(FD1, 2);
                Y2 = sum(FD_shock, 2);

                B_shock = inv(eye(S * N) - A_shock);

                % GDP Calculation
                GDP.Before_shock = diag(VA) * B * diag(Y1);
                GDP.After_shock = diag(VA) * B_shock * diag(Y2);

                GDP.Before_shock_S = sum(GDP.Before_shock, 2);
                GDP.After_shock_S = sum(GDP.After_shock, 2);

                GDP.Before_shock_RS = reshape(GDP.Before_shock_S, [num_sector, num_country]);
                GDP.After_shock_RS = reshape(GDP.After_shock_S, [num_sector, num_country]);

                GDP.Before_shock_RS_S = sum(GDP.Before_shock_RS, 1);
                GDP.After_shock_RS_S = sum(GDP.After_shock_RS, 1);

                GDP.change_GDP = (GDP.After_shock_RS_S - GDP.Before_shock_RS_S) ./ GDP.Before_shock_RS_S;

                % Global GDP change
                GDP.change_GDP_Global = (sum(GDP.After_shock_RS_S) / sum(GDP.Before_shock_RS_S)) - 1;

              % Save all calculated GDP results to individual CSV files
                    outputDir = fullfile(baseDir, 'Results');
                    if ~exist(outputDir, 'dir')
                        mkdir(outputDir);
                    end

                    % Create shock label for filenames
                    shockLabel = sprintf('%s_%+d', shockType, shock * 100); % e.g., "row_+5"
                    
                    % Save GDP.Before_shock
                    fileNameBefore = sprintf('GDP_%s_Before_shock_%s.csv', targetYear, shockLabel);
                    outputFileBefore = fullfile(outputDir, fileNameBefore);
                    writematrix(GDP.Before_shock, outputFileBefore);
                    
                    % Save GDP.After_shock
                    fileNameAfter = sprintf('GDP_%s_After_shock_%s.csv', targetYear, shockLabel);
                    outputFileAfter = fullfile(outputDir, fileNameAfter);
                    writematrix(GDP.After_shock, outputFileAfter);
                    
                    % Save GDP.Before_shock_RS (reshaped)
                    fileNameBeforeRS = sprintf('GDP_%s_Before_shock_RS_%s.csv', targetYear, shockLabel);
                    outputFileBeforeRS = fullfile(outputDir, fileNameBeforeRS);
                    writematrix(GDP.Before_shock_RS, outputFileBeforeRS);
                    
                    % Save GDP.After_shock_RS (reshaped)
                    fileNameAfterRS = sprintf('GDP_%s_After_shock_RS_%s.csv', targetYear, shockLabel);
                    outputFileAfterRS = fullfile(outputDir, fileNameAfterRS);
                    writematrix(GDP.After_shock_RS, outputFileAfterRS);
                    
                    % Save GDP.Before_shock_RS_S (sector sum)
                    fileNameBeforeRSSum = sprintf('GDP_%s_Before_shock_RS_S_%s.csv', targetYear, shockLabel);
                    outputFileBeforeRSSum = fullfile(outputDir, fileNameBeforeRSSum);
                    writematrix(GDP.Before_shock_RS_S, outputFileBeforeRSSum);
                    
                    % Save GDP.After_shock_RS_S (sector sum)
                    fileNameAfterRSSum = sprintf('GDP_%s_After_shock_RS_S_%s.csv', targetYear, shockLabel);
                    outputFileAfterRSSum = fullfile(outputDir, fileNameAfterRSSum);
                    writematrix(GDP.After_shock_RS_S, outputFileAfterRSSum);
                    
                    % Save GDP.change_GDP (percentage change)
                    fileNameChange = sprintf('GDP_%s_change_GDP_%s.csv', targetYear, shockLabel);
                    outputFileChange = fullfile(outputDir, fileNameChange);
                    writematrix(GDP.change_GDP, outputFileChange);
                    
                    % Save global GDP change
                    fileNameGlobalChange = sprintf('GDP_%s_change_GDP_Global_%s.csv', targetYear, shockLabel);
                    outputFileGlobalChange = fullfile(outputDir, fileNameGlobalChange);
                    writematrix(GDP.change_GDP_Global, outputFileGlobalChange);

            end
        end
    end
end
