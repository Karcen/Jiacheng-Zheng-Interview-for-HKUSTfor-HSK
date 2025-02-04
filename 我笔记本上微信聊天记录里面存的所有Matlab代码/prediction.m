yfit = trainedModel1.predictFcn(T2) 
yfit2 = trainedModel1.predictFcn(T2) 

plot(T2, yfit, 'b', 'LineWidth', 2); 
hold on; 


plot(T2, yfit2, 'r', 'LineWidth', 2); 


legend('使用2005-2023年数据', '使用2005-2024年数据');


xlabel('年份');
ylabel('考研报名人数（万）');