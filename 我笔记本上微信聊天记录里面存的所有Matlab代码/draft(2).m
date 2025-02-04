clear all
n=5;
% input the data
filename = 'Z:\Jamal Khan\2023-10-20 Jamal Friends\test.xlsx';
sheetname0 = 'Sheet2';
sheetname1 = 'Sheet1';

% Read data from range D17:H17 and convert to matrix
data_x0 = readtable(filename, 'Sheet', sheetname0, 'Range', 'D17:H17');
x0 = table2array(data_x0);

data_x1 = readtable(filename, 'Sheet', sheetname1, 'Range', 'D17:H17');
x1 = table2array(data_x1);

% Read data from range D4:H8 and convert to matrix
data_z0 = readtable(filename, 'Sheet', sheetname0, 'Range', 'D4:H8');
z0 = table2array(data_z0);

data_z1 = readtable(filename, 'Sheet', sheetname1, 'Range', 'D4:H8');
z1 = table2array(data_z1);

% Read data from range I4:I8 and convert to matrix
data_dhh0 = readtable(filename, 'Sheet', sheetname0, 'Range', 'I4:I8');
d.dhh0 = table2array(data_dhh0);

data_dhh1 = readtable(filename, 'Sheet', sheetname1, 'Range', 'I4:I8');
d.dhh1 = table2array(data_dhh1);

% Read data from range J4:J8 and convert to matrix
data_nporg0 = readtable(filename, 'Sheet', sheetname0, 'Range', 'J4:J8');
d.nporg0 = table2array(data_nporg0);

data_nporg1 = readtable(filename, 'Sheet', sheetname1, 'Range', 'J4:J8');
d.nporg1 = table2array(data_nporg1);

% Read data from range K4:K8 and convert to matrix
data_gov0 = readtable(filename, 'Sheet', sheetname0, 'Range', 'K4:K8');
d.gov0 = table2array(data_gov0);

data_gov1 = readtable(filename, 'Sheet', sheetname1, 'Range', 'K4:K8');
d.gov1 = table2array(data_gov1);

% Read data from range L4:L8 and convert to matrix
data_cap0 = readtable(filename, 'Sheet', sheetname0, 'Range', 'L4:L8');
d.cap0 = table2array(data_cap0);

data_cap1 = readtable(filename, 'Sheet', sheetname1, 'Range', 'L4:L8');
d.cap1 = table2array(data_cap1);

% Read data from range M4:M8 and convert to matrix
data_iv0 = readtable(filename, 'Sheet', sheetname0, 'Range', 'M4:M8');
d.iv0 = table2array(data_iv0);

data_iv1 = readtable(filename, 'Sheet', sheetname1, 'Range', 'M4:M8');
d.iv1 = table2array(data_iv1);

% Read data from range N4:N8 and convert to matrix
data_exp0 = readtable(filename, 'Sheet', sheetname0, 'Range', 'N4:N8');
e0 = table2array(data_exp0);

data_exp1 = readtable(filename, 'Sheet', sheetname1, 'Range', 'N4:N8');
e1 = table2array(data_exp1);

fd0 = d.dhh0 + d.nporg0 + d.gov0 + d.cap0 + d.iv0;
fd1 = d.dhh1 + d.nporg1 + d.gov1 + d.cap1 + d.iv1;

w0=sum(z0,2);
w1=sum(z1,2);

u0=(x0'-e0)./(fd0+w0);
u1=(x1'-e1)./(fd1+w1);

A0=z0./x0;
A1=z1./x1;

% equation 6 equation6.x0 = diag(u0) * fd0 + diag(u0) * A0 * x0' + e0; %
% checked

equation6.R0 = inv(eye(size(diag(u0) * A0)) - diag(u0) * A0); % checked
R0=equation6.R0;

equation6.R1 = inv(eye(size(diag(u1) * A1)) - diag(u1) * A1); % checked
R1=equation6.R1;

% equation6.x2 = R0 * (diag(u0) * fd0 + e0); % checked

% equation 7
zmatrix = zeros(n);

for row = 1:n
    for col = 1:n
        if col==row
        zmatrix(row, col) = 1;
        zdiag{row,col}=zmatrix;
        end
        zmatrix = zeros(n);
    end
end

equation7.zhatx0 = cell(n);
equation7.zhatx1 = cell(n);
for row=1:n
    for col=1:n
        if row==col
equation7.zhatx0{row,col} = zdiag{row,col}*(R0*(diag(u0)*fd0+diag(e0))); % checked
equation7.zhatx1{row,col} = zdiag{row,col}*(R1*(diag(u1)*fd1+diag(e1))); % checked
        end
    end
end

% equation 8
equation8.zhatx1=cell(n);
equation8.zhatx2=cell(n);
for row=1:n
    for col=1:n
        if row==col
equation8.zhatx1{row,col} = zdiag{row,col}*(x1'-x0'); % checked
equation8.zhatx2{row,col}=zdiag{row,col}*(R1 * (diag(u1) * fd1 + e1) - R0 * (diag(u0) * fd0 + e0)); % checked
        end
    end
end

% equation 9
for row=1:n
    for col=1:n
        if row==col
equation9.zhatx1{row,col} = zdiag{row,col} * (R1 * diag(u1) * fd1 + R1 * e1 - R0 * diag(u0) * fd0 - R0 * e0 + R1 * diag(u1) * fd0 - R1 * diag(u1) * fd0 + R1 * e0 - R1 * e0 + R1 * diag(u0) * fd0 - R1 * diag(u0) * fd0); % checked
equation9.zhatx2{row,col} = zdiag{row,col} * (R1 * diag(u1) * (fd1 - fd0) + R1 * (e1 - e0) + R1 * (diag(u1) - diag(u0)) * fd0 + (R1 - R0) * diag(u0) * fd0 + (R1 - R0) * e0); % checked
        end
    end
end


% equation 10
equation10.R1 = R1 - R0; % checked
equation10.R2 = -R1 * ((inv(R1) - inv(R0)) * R0); % checked
equation10.R3 = -R1 * ((eye(size(diag(u1) * A1)) - diag(u1) * A1 - eye(size(diag(u0) * A0)) + diag(u0) * A0) * R0); % checked
equation10.R4 = R1 * (diag(u1) * A1 - diag(u0) * A0) * R0; % checked

% equation 11
equation11.R1 = R1 * (diag(u1) * (A1 - A0) + (diag(u1) - diag(u0)) * A0) * R0; % checked
equation11.R2 = R1 * (diag(u1) * (A1 - A0) + ((diag(u1) - diag(u0)) * A0)) * R0; % checked

% equation 12
equation12.zhatx1=cell(n);
equation12.zhatx2=cell(n);
equation12.zhatx3=cell(n);
equation12.zhatx4=cell(n);

for row=1:n
    for col=1:n
        if row==col
equation12.zhatx1{row,col} = zdiag{row,col} * (R1 * diag(u1) * (fd1 - fd0) + R1 * (e1 - e0) + R1 * diag(u1-u0) * (fd1 - fd0) + R1 * diag(u1) * (A1-A0) * R0 * (diag(u0) * fd0 + e0) +R1*diag(u1-u0)* A0 * R0 * (diag(u0) * fd0 + e0)); % checked
equation12.zhatx2{row,col} = zdiag{row,col} * (R1 * diag(u1) * (fd1 - fd0) + R1 * (e1 - e0) + R1 * diag(u1) * (fd1 - fd0) + R1 * diag(u1-u0)*A0 * x0' + R1 * diag(u1)*(A1-A0)*x0'); % checked
equation12.zhatx3{row,col} = zdiag{row,col} * (R1 * diag(u1) * (fd1 - fd0) + R1 * (e1 - e0) + R1 * diag(u1-u0) * fd0 + R1 * diag(u1-u0) * A0 * x0' +R1*diag(u1)*(A1-A0)*x0'); % checked
equation12.zhatx4{row,col} = zdiag{row,col} * (R1 * diag(u1) * (fd1 - fd0) + R1 * (e1 - e0) + R1 * diag(u1-u0) * (fd0+w0) + R1 * diag(u1) *(A1-A0)*x0'); % checked
final.domestic{row,col} = zdiag{row,col} * R1 * diag(u1) * (fd1 - fd0);
final.export{row,col} = zdiag{row,col} *R1 * (e1 - e0);
final.import{row,col} = zdiag{row,col} *R1 * diag(u1-u0) * (fd0+w0);
final.technoeff{row,col} = zdiag{row,col} *R1 * diag(u1) *(A1-A0)*x0';
        end
    end
end


result = struct('domestic', zeros(n,1), 'export', zeros(n,1), 'import', zeros(n,1), 'technoeff', zeros(n,1));

for row = 1:n
    for col = 1:n
        if row == col
            result.domestic = result.domestic + final.domestic{row,col};
            result.export = result.export + final.export{row,col};
            result.import = result.import + final.import{row,col};
            result.technoeff = result.technoeff + final.technoeff{row,col};
        end
    end
end

% equation 13
for row=1:n
    eq13.A1tem=A1;
    eq13.A0tem=A0;
    eq13.A1tem(row,:)=0;
    eq13.A0tem(row,:)=0;
    eq13.A1noninter{row}=eq13.A1tem;
    eq13.A0noninter{row}=eq13.A0tem;
    eq13.A1inter{row}=A1-eq13.A1tem;
    eq13.A0inter{row}=A0-eq13.A0tem;
end


% equation 15
mu=ones(1,n);
lambda = (mu * fd1) ./ (mu * fd0);

for row = 1:n
    for col = 1:n
        if row == col
            % result.left{row,col} = zdiag{row,col} * R1 * diag(u1) * (fd1-fd0);
            result.DDDF1{row,col} = zdiag{row,col} * R1 * diag(u1) *(lambda-1)*fd0;
            result.DDDF2{row,col} = zdiag{row,col} * R1 * diag(u1) *(fd1-lambda*fd0);
        end
    end
end

% equation 16 DDC domestic demand categories
for row = 1:n
    for col = 1:n
        if row == col 
            FD.dhh{row,col} = zdiag{row,col} * R1 * diag(u1) * ((lambda - 1) * d.dhh0 +  (d.dhh1 - lambda * d.dhh0));
            FD.nporg{row,col} = zdiag{row,col} * R1 * diag(u1) * ((lambda - 1) * d.nporg0 + (d.nporg1 - lambda * d.nporg0));
            FD.gov{row,col} = zdiag{row,col} * R1 * diag(u1) * ((lambda - 1) * d.gov0 + (d.gov1 - lambda * d.gov0));
            FD.cap{row,col}= zdiag{row,col} * R1 * diag(u1) * ((lambda - 1) * d.cap0 + (d.cap1 - lambda * d.cap0));
            FD.iv{row,col} = zdiag{row,col} * R1 * diag(u1) * ((lambda - 1) * d.iv0 + (d.iv1 - lambda * d.iv0));
            FD.iv_total{row,col} = FD.dhh{row,col} + FD.nporg{row,col} + FD.gov{row,col} + FD.cap{row,col} + FD.iv{row,col};
        end
    end
end

result2 = struct('dhh', zeros(n,1), 'nporg', zeros(n,1), 'gov', zeros(n,1), 'cap', zeros(n,1), 'iv', zeros(n,1));

for row = 1:n
    result2.dhh = result2.dhh + FD.dhh{row,row};
    result2.nporg = result2.nporg + FD.nporg{row,row};
    result2.gov = result2.gov + FD.gov{row,row};
    result2.cap = result2.cap + FD.cap{row,row};
    result2.iv = result2.iv + FD.iv{row,row};
end

