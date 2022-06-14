function [ad] = simulation2(y0,IC,~,ML_C,wwa,PK,IC50,da,db)
N=2^17;
TF=20*365;
% F=zeros(73,3*N+2);
% rt=0.6;
% ad=0.5;
% TF=2;
% load('NRTI_INF','NRTI_INF');
% load('NETS','NETS');
% load('FITS','FITS');
% load('MEANC','MEANC');
% disp(wwa);

tau=0;
ad1=0;
ad2=1;
ad=(ad1+ad2)/2;
error=1;
while error>0.01

D=zeros(1,TF+1);
    
Y0=zeros(1,3*N+2);
Y0(1)=10^6;
Y0(N+2)=1.5*10^2;
% Y0(311:end)=10.*rand(1,154);
Y0(1+y0)=1;
Y0(N+2+y0)=1;
SS=y0;
if da~=db
S(1)=da;
S(2)=db;
DR=zeros(1,2);
else
S(1)=da;
DR=0;
end

% Solving Differential Equations
aids=0;
t=0;
TD=10^10;
while t<TF && aids==0
t=t+1;
% tic;

TC=2:N+1;
MC=N+3:2*N+2;
TCC=3*N+3:4*N+2;
MCC=4*N+3:5*N+2;

% tic;
% S1=find(Y0(TC)~=0);
% S2=find(Y0(MC)~=0);
% SS=union(S1,S2);
NN=length(SS);
% t1=toc;

if t<=tau
D(t)=0;
else
if rand<ad
if TD~=10^10
DR=drug_blood_itself(DR,fix(t+1-TD),t+1-TD,PK(S,:));
end
D(t)=1;
TD=t;
end
end

% D=zeros(1,length(S))+0;
% D=D+0.1;
% tic;
VC=2*N+3:3*N+2;
Z0=[Y0(1),Y0(TC(SS)),Y0(N+2),Y0(MC(SS)),Y0(VC(SS)),zeros(1,2*length(SS))];
IN=[1,TC(SS),N+2,MC(SS),VC(SS),TCC(SS),MCC(SS)];
[~,yy]=ode23(@(t,y) within_host(t,y,length(SS),PK,S,IC,D,IC50,SS,TD,DR),[t-1,t],Z0);
Y0=zeros(1,5*N+2); 
Y0(1,IN)=yy(end,:);
H0=zeros(1,5*N+2); 
H0(1,IN)=Z0;
% t2=toc;
% tic;
% t3=toc;
% Y0=Y0.*4900;
% H0=H0.*4900;

y(1,:)=H0;
y(2,:)=Y0;
% [tt,y]=ode45(@(t,y) within_host2(t,y,M,S,D,IC50,net,INPUT,FITS),[t-1,t],Y0);
Growth1=(y(end,3*N+3:4*N+2)-y(1,3*N+3:4*N+2));
Growth1(Growth1<0)=0; 
Growth2=(y(end,4*N+3:5*N+2)-y(1,4*N+3:5*N+2));
Growth2(Growth2<0)=0;
nu=10^-5;
for hh=1:NN
h=TC(SS(hh))-1;    
d=ML_C{h};   
e=poissrnd(Growth1(h)*nu); 
if e>0
eee=randi(length(d),1,e);
for j=1:e
Y0(1+d(eee(j)))=Y0(1+d(eee(j)))+1;
p=find(SS==d(eee(j)), 1);
if isempty(p)
SS=[SS,d(eee(j))];
end
if Y0(1+h)>=1
Y0(1+h)=Y0(1+h)-1;
end
end
end
e=poissrnd(Growth2(h).*nu); 
if e>0
eee=randi(length(d),1,e);
for j=1:e
Y0(N+2+d(eee(j)))=Y0(N+2+d(eee(j)))+1;
p=find(SS==d(eee(j)), 1);
if isempty(p)
SS=[SS,d(eee(j))];
end
if Y0(N+2+h)>=1
Y0(N+2+h)=Y0(N+2+h)-1;
end
end
end
end
% Y0=Y0./4900;

% 
% for h=1:17
% MutMap=Mut{h};
% mic=rand(Growth(MutMap(:,1)));
% Y0(310+MutMap(:,1))=Y0(310+MutMap(:,1))-mic;
% Y0(310+MutMap(:,2))=Y0(310+MutMap(:,2))+mic;
% end

% if sum(mic)>0
% f=1;    
% end
 
%  if mod(t,1)==0
%  F_T(t/1,:)=Y0(1);
%   F_M(t/1,:)=Y0(N+2);
%   for a=1:length(SS)
%    F_TS(t/1,a)=Y0(1+SS(a));
%   F_MS(t/1,a)=Y0(N+2+SS(a));
%    F_V(t/1,a)=Y0(2*N+2+SS(a));
%   end
%  end
 
if Y0(1)/1000<=200
    aids=1;
    TAIDS=t;
else
    V=Y0(1,2*N+3:3*N+2);%Virus 
    if sum(V)<1
        aids=1;
    end
    TAIDS=TF;
end
% tt(t)=toc;

end

if TAIDS==7300
ad2=ad;
else
ad1=ad;
end
adold=ad;
ad=(ad1+ad2)/2;
error=abs(ad-adold);
clear D S F V Ti T Mi M CPP
end

end