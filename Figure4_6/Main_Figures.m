clc
clear
DR={'3TC','ABC','AZT','D4T','DDI','TDF'};
load('IC');
load('IC50');
load('Mutation_Data');
load('MTT');
load('PK');
load('IC');

ii=0;
u=0;

for pp=1:5

for p=1:5

    if pp~=0
namedata=sprintf('SIM_RESULTS_CASE_%0d_%0d',pp,p);
    else
namedata=sprintf('SIM_RESULTS_CASE_%0d',pp);
    end

load(namedata);
y0=MTT(p,pp);

[ZM] = Prior_Estimate(y0,IC50,PK,IC,ML); 

BARVEC=[];
BARVEC_RF=[];
BARVEC_SF=[];

vv=0;
vcc=[];
rr=0;
sr=0;
for da=1:6
    for db=1:6
        if da>=db
rr=rr+1;
for i=1:512    
    Z(i)=DAT_A{i}(da,db);
    if Z(i)==7300
        E(i)=1;
    else
        E(i)=0;
    
    end
   
end

X=[x,y,E'];
SR=length(find(E==1))/length(E);

options = optimoptions(@fmincon,'MaxFunctionEvaluations',100000);
xx=fmincon(@(x) linear_logistic(x,X),zeros(1,3),[],[],[],[],[],[],[],options);
fun=@(x,y) xx(1).*x+xx(2).*(y/365)+xx(3);

if SR>0.02  
sr=sr+1;

CC=[ZM(rr,1),mean(ZM(rr,:)),max(ZM(rr,:))];
    ii=ii+1;
    %Create further machine learning data
    BDX(ii,:)=CC;
    BDY(ii)=SR;


if da==db
name=sprintf('%s ; SR= %0.3f',DR{db},SR);
name2=sprintf('%s',DR{db});    
else
name=sprintf('%s - %s ; SR= %0.3f',DR{da},DR{db},SR);
name2=sprintf('%s - %s',DR{da},DR{db});
end
    C_D{sr,1}=name;
    C_D{sr,2}=X;
    C_D{sr,3}=fun;

vv=vv+1;
if mod(vv,3)==1
renk=rand(1,3);    
end  
BARVEC=[BARVEC,SR];
BARNAME{vv}=name2;

end
   

        end
    end
end
u=u+1;

[a,b]=sort(BARVEC,'descend');
B=categorical(BARNAME(b(1:min(length(b),8))));
C=BARVEC(b(1:min(length(b),8)));
D=reordercats(B,BARNAME(b(1:min(length(b),8))));

%Figure 6 of the manuscript
figure (1)
sp1=subplot(5,5,u);
for i=1:length(D)
    hold on
    barh(D(i),C(i),'FaceColor',[0 1 0]);   
end

grid(sp1,'on');
set(sp1,'FontAngle','italic','FontWeight','bold');
f=sprintf('G_{%0d%0d}',pp,p);
xlabel('SR')
xlim([0,0.4])
title(f)

m=size(C_D,1);
%Figure 4 of the manuscript

figure (1+u)
for a=1:m
subplot1=subplot(ceil(m/3),3,a);
X=C_D{a,2};
fun=C_D{a,3};
scatter(X(X(:,3)==0,1),X(X(:,3)==0,2),'MarkerEdgeColor',[0 0.447058826684952 0.74117648601532],...
    'MarkerFaceColor',[1 1 1])
hold on
scatter(X(X(:,3)==1,1),X(X(:,3)==1,2),'MarkerEdgeColor',[0 1 0],...
    'MarkerFaceColor',[1 1 1]);
hold on
fimplicit(fun,[0,1,0,365]);
ylabel('\tau');
xlabel('\alpha');
set(subplot1,'FontAngle','italic','FontSize',12,'FontWeight','bold');
title(C_D{a,1})
% axis square
end

figurename=sprintf('DF_G_%0d_%0d.fig',pp,p);
figurename2=sprintf('DF_G_%0d_%0d.png',pp,p);
% saveas(gcf,figurename)
% saveas(gcf,figurename2)
% clf

clear BARVEC BARNAME
end
end

save('Machine_Learning_Data')
