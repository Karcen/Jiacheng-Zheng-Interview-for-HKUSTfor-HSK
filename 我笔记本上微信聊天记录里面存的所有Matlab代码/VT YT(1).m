% Yd=[];
% B=[];
% V=[];
DiagYd=diag(Yd);
DiagVd=diag(V);

YT=V*B*DiagYd;
VT=DiagVd*B*Yd;
diagVBY=DiagYd*B*DiagYd;

for i=1:12
    DiagB(i,i)=B(i,i);
end