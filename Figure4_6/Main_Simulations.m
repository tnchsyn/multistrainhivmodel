clc
clear
load('Mutation_Data');
load('IC');
load('ML_C');
load('COMMON_ISOLATES');
load('PK');
load('IC50');
load('MTT.mat')
load('INITINAL_GUESS.mat')

for k=1:512
R(k,1)=round(366.*rand);
R(k,2)=rand;
end

x=R(:,2);
y=R(:,1);

% w=0;
% for da=1:6
%     for db=1:6
% 
% 
%         if da>=db
% w=w+1;
%             DTT(w,1)=da;
%             DTT(w,2)=db;
%         end
% 
%     end
% end
% 
% for p=1:5
%     for pp=1:5
%         y0=MTT(p,pp);
%         disp(p)
%         disp(pp)
% W=cell(1,21);
% parfor w=1:21
% a=simulation2(y0,IC,ML,ML_C,w,PK,IC50,DTT(w,1),DTT(w,2));
% b=simulation3(y0,IC,ML,ML_C,w,PK,IC50,DTT(w,1),DTT(w,2));
% W{w}=[a,b];
% end
% for w=1:21
% DTM(p,pp,w,:)=W{w};
% end
% 
% 
%     end
% end
% save('INITINAL_GUESS','DTM');

%Previous part produces INITIAL_GUESS data.

DAT_A=cell(1,length(x));
DAT_S=cell(1,length(x));
DAT_D=cell(1,length(x));

for p=1:5
DT=squeeze(DTM(p,1,:,:));   
name=sprintf('SIM_RESULTS_CASE_1_%0d',p);
y0=MTT(p,1);
parfor j=1:size(R,1)
ad=x(j);  
tau=y(j);  
[DAT_A{j},DAT_S{j},DAT_D{j}]=simulation(ad,tau,y0,IC,ML,ML_C,j,PK,IC50,DT);
end
save(name,"DAT_A","DAT_D","DAT_S","x","y")
clear DAT_S DAT_A DAT_D
end

DAT_A=cell(1,length(x));
DAT_S=cell(1,length(x));
DAT_D=cell(1,length(x));

for p=1:5
    DT=squeeze(DTM(p,2,:,:));   
name=sprintf('SIM_RESULTS_CASE_2_%0d',p);
y0=MTT(p,2);
parfor j=1:size(R,1)
ad=x(j);  
tau=y(j);  
[DAT_A{j},DAT_S{j},DAT_D{j}]=simulation(ad,tau,y0,IC,ML,ML_C,j,PK,IC50,DT);
end
save(name,"DAT_A","DAT_D","DAT_S","x","y")
clear DAT_S DAT_A DAT_D
end


DAT_A=cell(1,length(x));
DAT_S=cell(1,length(x));
DAT_D=cell(1,length(x));

for p=1:5
    DT=squeeze(DTM(p,3,:,:));   
name=sprintf('SIM_RESULTS_CASE_3_%0d',p);
y0=MTT(p,3);
parfor j=1:size(R,1)
ad=x(j);  
tau=y(j);  
[DAT_A{j},DAT_S{j},DAT_D{j}]=simulation(ad,tau,y0,IC,ML,ML_C,j,PK,IC50,DT);
end
save(name,"DAT_A","DAT_D","DAT_S","x","y")
clear DAT_S DAT_A DAT_D
end

DAT_A=cell(1,length(x));
DAT_S=cell(1,length(x));
DAT_D=cell(1,length(x));

for p=1:5
    DT=squeeze(DTM(p,4,:,:));   
name=sprintf('SIM_RESULTS_CASE_4_%0d',p);
y0=MTT(p,4);
parfor j=1:size(R,1)
ad=x(j);  
tau=y(j);  
[DAT_A{j},DAT_S{j},DAT_D{j}]=simulation(ad,tau,y0,IC,ML,ML_C,j,PK,IC50,DT);
end
save(name,"DAT_A","DAT_D","DAT_S","x","y")
clear DAT_S DAT_A DAT_D
end

DAT_A=cell(1,length(x));
DAT_S=cell(1,length(x));
DAT_D=cell(1,length(x));

for p=1:5
    DT=squeeze(DTM(p,5,:,:));   
name=sprintf('SIM_RESULTS_CASE_5_%0d',p);
y0=MTT(p,5);
parfor j=1:size(R,1)
ad=x(j);  
tau=y(j);  
[DAT_A{j},DAT_S{j},DAT_D{j}]=simulation(ad,tau,y0,IC,ML,ML_C,j,PK,IC50,DT);
end
save(name,"DAT_A","DAT_D","DAT_S","x","y")
clear DAT_S DAT_A DAT_D
end