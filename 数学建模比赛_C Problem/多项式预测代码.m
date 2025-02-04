function [fitresult, gof] = createFit(x, y)
%CREATEFIT(X,Y)
%  Create a fit.
%
%  Data for '模型拟合预测图' fit:
%      X Input : x
%      Y Output: y
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  另请参阅 FIT, CFIT, SFIT.

%  由 MATLAB 于 17-Feb-2023 18:47:11 自动生成


%% Fit: '模型拟合预测图'.
[xData, yData] = prepareCurveData( x, y );

% Set up fittype and options.
ft = fittype( 'poly9' );
opts = fitoptions( 'Method', 'LinearLeastSquares' );
opts.Robust = 'Bisquare';

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% Create a figure for the plots.
figure( 'Name', 'Polynomial Model Fitting Prediction Graph' );

% Plot fit with data.
subplot( 2, 1, 1 );
h = plot( fitresult, xData, yData);
legend( h, 'Number of  Reported Results vs. Contest Number', 'Model Fitting Prediction Graph', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
xlabel( 'Contest Number', 'Interpreter', 'none' );
ylabel( 'Number of  Reported Results', 'Interpreter', 'none' );
grid on

% Plot residuals.
subplot( 2, 1, 2 );
h = plot( fitresult, xData, yData, 'residuals' );
legend( h, 'Model Fitting Prediction Graph- residuals', 'Zero Line', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
xlabel( 'Contest Number', 'Interpreter', 'none' );
ylabel( 'Residuals', 'Interpreter', 'none' );
grid on


