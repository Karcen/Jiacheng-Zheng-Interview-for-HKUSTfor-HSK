clear all
n=5;
% input the data
filename = 'C:\Users\Jiacheng Zheng\Desktop\test.xlsx';
sheetname0 = 'Sheet2';
sheetname1 = 'Sheet1';

data_x = readtable(filename, 'Sheet', sheetname0, 'Range', 'D17:H17');
x = table2array(data_x);


data_z = readtable(filename, 'Sheet', sheetname0, 'Range', 'D4:H8');
z = table2array(data_z);

data_y = readtable(filename, 'Sheet', sheetname0, 'Range', 'I4:N9');
y = table2array(data_f);

f=sum(y,2);

A=z./x;


% page 5
x=A*x+f;
Adiag=diag(diag(A));

% page 6
x=A*x-Adiag*x+Adiag*x+f;
I=eye(sizes(A);
x=Adiag*x+(A-Adiag)*x+inv(I-Adiag)*f;
x=inv(I-Adiag)*(A-Adiag)*x+inv(I-Adiag)*f;
Astar=inv(I-Adiag)*(A-Adiag)*x+inv(I-Adiag)*f;

% page 7
x=Astar*x+inv(I-Adiag)*f;
x=Astar^2*x+(I+Astar)*inv(I-Adiag)*f;
x=inv(I-A*^2)(I+Astar)*inv(I-Adiag)*f;

% page 8
x=inv(I-Astar^2)*(I+Astar)*inv(I-Adiag)*f;
