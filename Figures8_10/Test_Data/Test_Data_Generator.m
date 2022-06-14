clc
clear
DR={'3TC','ABC','AZT','D4T','DDI','TDF'};
load('IC');
load('IC50');
load('PK');
load('Mutation_Data');
ii=0;

for p=1:25

namedata=sprintf('SIM_TEST_RESULTS__%0d',p);   

[ZM] = Prior_Estimate(y0,IC50,PK,IC,ML); 


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

if SR>0.02  
sr=sr+1;

CC=[ZM(rr,1),mean(ZM(rr,:)),max(ZM(rr,:))];
    ii=ii+1;
    %ML Test Data
    BDX(ii,:)=CC;
    BDY(ii)=SR;

end
   

        end
    end
end

clear BARVEC BARNAME
end

save("Machine_Learning_Test_Data.mat","BDY","BDX")
