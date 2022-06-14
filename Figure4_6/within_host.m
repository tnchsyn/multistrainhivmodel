function [dy]=within_host(t,y,N,PK,S,IC,D,IC50,SS,TD,DR)

s1=10*1000;s2=0.15*1000;
format long
K5=38;K6=35;
d1=0.01;d2=0.4;d3=0.001;d4=0.001;d5=2.4;
Vi(:,1)=y(2*N+3:3*N+2);

RT1=Z_generate(S,IC,D,IC50,SS,PK,t,TD,DR);
RT= (4.0000e-08).*RT1;

K2=RT;
K4=RT./1000;

pT=0.0077.*(y(1).*sum(Vi))./(sum(Vi)+300);
pM=0.0025.*(y(N+2).*sum(Vi))./(sum(Vi)+220);

dy = zeros(5*N+2,1);

dy(1) = s1 -d1*y(1)-sum(K2.*Vi')*y(1)+pT;
dy(2:N+1) =(K2'.*Vi).*y(1)-d2*y(2:N+1);
dy(N+2) = s2 -sum(K4.*Vi')*y(N+2)-d3*y(N+2)+pM;
dy(N+3:2*N+2) =(K4'.*Vi).*y(N+2)-d4*y(N+3:2*N+2);
dy(2*N+3:3*N+2) = K5.*y(2:N+1)+ K6.*y(N+3:2*N+2)-d5*Vi;
dy(3*N+3:4*N+2) =(K2'.*Vi).*y(1);
dy(4*N+3:5*N+2) =(K4'.*Vi).*y(N+2);
end