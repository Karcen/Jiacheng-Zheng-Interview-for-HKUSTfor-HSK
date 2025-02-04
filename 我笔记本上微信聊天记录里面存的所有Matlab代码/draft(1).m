% var loop depends on dataset

% equation 6
equation6.x1 = diag(u) * d + diag(u) * A * x + e; % checked
equation6.R = inv(eye(size(diag(u) * A)) - diag(u) * A); % checked
equation6.x2 = R * (diag(u) * d + e); % checked

% equation 7
equation7.zhatx=diag(z)*(R*(diag(u)*d+diag(e))); % checked

% equation 8
Delta.equation8.zhatx1=diag(z)*(x_1-x_0); % checked
Delta.equation8.zhatx2= diag(z)* (R_1 * (diag(u_0) * d_1 + e_1) - R_0 * (diag(u_0) * d_0 + e_0)); % checked

% equation 9
Delta.equation9.zhatx1 = diag(z_hat) * (R_1 * diag(u_1) * d_1 + R_1 * e_1 - R_0 * diag(u_0) * d_0 - R_0 * e_0 + R_1 * diag(u_1) * d_0 - R_1 * diag(u_1) * d_0 + R_1 * e_0 - R_1 * e_0 + R_1 * diag(u_0) * d_0 - R_1 * diag(u_0) * d_0); % checked

Delta.equation9.zhatx2= diag(z) * (R_1 * diag(u_1) * (d_1 - d_0) + R_1 * (e_1 - e_0) + R_1 * (diag(u_1) - diag(u_0)) * d_0 + (R_1 - R_0) * diag(u_0) * d_0 + (R_1 - R_0) * e_0); % checked

Delta.equation9.zhatx3= diag(z) * (R_1 * diag(u_1) * delta_d + R_1 * delta_e + R_1 * diag(delta_u )* d_0 + delta_R * (diag(u) * d_0 + e_0)); % checked

% equation 10
Delta.equation10.R_1= R_1 - R_0; % checked

Delta.equation10.R2= -R_1 * ((inv(R_1) - inv(R_0)) * R_0); % checked

Delta.equation10.R3= -R_1 * ((eye(size(diag(u_1) * A_1)) - diag(u_1) * A_1 - eye(size(diag(u_0) * A_0)) + diag(u_0) * A_0) * R_0); % checked

Delta.equation10.R4= R_1 * (diag(u_1) * A_1 - diag(u_0) * A_0) * R_0; % checked

% equation 11
Delta.equation11.R_1= R_1 * (diag(u_1) * (A_1 - A_0) + (diag(u_1) - diag(u_0)) * A_0) * R_0; % checked

Delta.equation11.R2= R_1 * (diag(u_1) * (A_1 - A_0) + ((diag(u_1) - diag(u_0)) * A_0)) * R_0; % checked 

Delta.equation11.R3 = R_1 * diag(u_1) * delta_A * R_0 + R_1 * delta_u * A_0 * R_0; % checked


Delta.equation12.zhatx1 = diag(z) * (R_1 * diag(u_1) * delta_d + R_1 * delta_e + R_1 * diag(delta_u) * d_0 + R_1 * diag(u_1) * delta_A * R_0 * (diag(u_0) * d_0 + e_0) + R_1 * diag(delta_u) * A_0 * R_0 * (diag(u_0) * d_0 + e_0)); % checked

Delta.equation12.zhatx2 = diag(z) * (R_1 * diag(u_1) * delta_d + R_1 * delta_e + R_1 * diag(delta_u) * d_0 + R_1 * diag(delta_u) * A_0 * x_0 + R_1 * diag(u_1) * delta_A * x_0); % checked

Delta.equation12.zhatx3 = diag(z) * (R_1 * diag(u_1) * delta_d + R_1 * delta_e + R_1 * diag(delta_u) * (d_0 + A_0 * x_0) + R_1 * diag(u_1) * delta_A * x_0); % checked

Delta.equation12.zhatx4= diag(z) * (R_1 * diag(u_1) * delta_d + R_1 * delta_e + R_1 * diag(delta_u) * (d_0 + w_0) + R_1 * diag(u_1) * delta_A * x_0); % checked

% equation 13
eq13_1=(A_1-A_0)
eq13_2=(A_1(I,:)-A_0(I,:))+(A_1(N,:)-A_0(N,:));


% equation 14
zleft1 = diag(z)*R_1 * diag(u_1) * delta_A(I,:) * x;
zright1 = diag(z)*R_1 * diag(u_1) * delta_A(I,:) * x; + diag(z)*R_1 * diag(u_1) * delta_A(N,:)  * x;


% equations below locate between eq.13 and eq.14
lambda = (mu * d_1) ./ (mu* d_0);
left1 = diag(z)*R_1 *diag(u_1) * delta_d;
right1 = diag(z) *R_1 *diag(u_1) * (d_1 - d_0);
left2= diag(z) *R_1*diag(u_1)*lambda*d_0; 
right2 = diag(z) *R_1* diag(u_1) * (d_1 + lambda*d_0 - lambda*d_0 - d_0);

% equation 15
zrud1=diag(z)*R_1*diag(u_1) * delta_d;
zrud2=diag(z)*R_1* diag(u_1) * (lambda-1) * d0 + diag(z)*R_1* diag(u) * (d_1 - lambda * d_0);

% equation 16
eq16_1 = diag(z)*R_1 * diag(u_1) * delta_d;

eq16_2 = 0;
eq16_3 = 0;

for h=1:loop
eq16_2 =eq16_2 +diag(z)*R_1 * diag(u_1) * delta_d(h,:);
end

for h=1:loop
eq16_3 =eq16_3 + diag(z)*R_1 * diag(u_1) *  ((lambda-1) * d_0(h,:) + (d_1(h,:) - lambda * d_0(h,:)));
end



