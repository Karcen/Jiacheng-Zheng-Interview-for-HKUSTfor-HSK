clear all

%% data input
V=xlsread('C:\Users\Lenovo\Desktop\Calculating the Agglomeration Index\data.xlsx','sheet1',"C19:N19");
Z=xlsread('C:\Users\Lenovo\Desktop\Calculating the Agglomeration Index\data.xlsx','sheet1',"C3:N14");
Finaldemand=xlsread('C:\Users\Lenovo\Desktop\Calculating the Agglomeration Index\data.xlsx','sheet1',"R3:T14");
G=3; % number of countries
n=4; % number of sectors
Total_output=xlsread('C:\Users\Lenovo\Desktop\Calculating the Agglomeration Index\data.xlsx','sheet1',"C21:N21");
A=Z./Total_output;
B=inv(eye(G*n)-A);
VaD=xlsread('C:\Users\Lenovo\Desktop\Calculating the Agglomeration Index\data.xlsx','sheet1',"C19:N19");
%% CREATE Y, Yd, Yf
Y=sum(Finaldemand,2);

start_id=1;
end_id=n;
for i=1:G
Yd(start_id:end_id)=Finaldemand(start_id:end_id,i);
    start_id=end_id+1;
    end_id=end_id+n;
end
Yd=Yd';

Yf=Y-Yd;

%% BLOCK A
A_subMatrices = cell(3,3);

for i = 1:3
    for j = 1:3
        A_subMatrix = A((4*(i-1)+1):(4*i), (4*(j-1)+1):(4*j));
        A_subMatrices {i,j} = A_subMatrix;
    end
end

%%  CREATE Ad, Af
Ad=zeros(G*n);
start_id=1;
end_id=n;
for i=1:G
Ad(start_id:end_id,start_id:end_id)=A_subMatrices{i,i};
    start_id=end_id+1;
    end_id=end_id+n;
end
Af=A-Ad;

%% CREATE Leontief inverse
L=inv(eye(G*n)-Ad);


%% CALC
% Equation 1
DVAC1=V*B*diag(Y); % distribution of value added across different economy sectors
DVAC2=V*L*diag(Yd)+V*L*diag(Yf)+V*L*Af*L*diag(Yd)+V*L*Af*(B*diag(Y)-L*diag(Yd)); % distribution of value added across different economy sectors

% Equation 2
VaT1=diag(V)*B*Y; % equation 2 describes where value added is absorbed
VaT2=diag(V)*L*Yd+diag(V)*L*Yf+diag(V)*L*Af*L*Yd+diag(V)*L*Af*(B*Y-L*Yd); % equation 2 describes where value added is absorbed


% Equation 3
theta=Yd./Y;

start_id=1;
end_id=n;
for i=1:G
Zd{i}=Z(start_id:end_id,start_id:end_id);
    start_id=end_id+1;
    end_id=end_id+n;
end
Zdmatrix=cell2mat(Zd);
Zdmatrix=Zdmatrix';
Zdmatrix=sum(Zdmatrix,2);
Total_output=Total_output';
garmma=Zdmatrix./Total_output;

AGGB_jrt=theta./sum((garmma./2).*theta);



% Equation 4
V=sum(Z,2);
VaD=VaD';
fai=VaD./V;

AGGF_jrt=theta./sum((garmma./2).*fai);


% Equation 5 6
start_id=1;
end_id=n;
for i=1:G
omega{i}=Total_output(start_id:end_id,1);
AGGB_jrtArray{i}=AGGB_jrt(start_id:end_id,1);
AGGF_jrtArray{i}=AGGF_jrt(start_id:end_id,1);
    start_id=end_id+1;
    end_id=end_id+n;
    AGGB_rt{i}=sum(omega{i}.*AGGB_jrtArray{i}); % expaination is as follows
    AGGF_rt{i}=sum(omega{i}.*AGGF_jrtArray{i});
end

% I believe the author's calculation here is measuring the degree of
% aggregation from an economic perspective. I have divided omega into G
% arrays, where G represents the number of countries. Similarly, AGGB_jrt
% has also been divided into G arrays, with each array containing n sectors
% specific to the corresponding country. Omega{i} is a 4*1 array, assuming
% it to be [1, 2, 3, 4]', and AGGB_jrtArray is also a 4*1 array, assumed to
% be [a, b, c, d]'. So, the expression "sum(omega{i}.*AGGF_jrtArray{i})"
% means 1*a + 2*b + 3*c + 4*d, which represents the multiplication and
% addition of the corresponding elements in the arrays.
