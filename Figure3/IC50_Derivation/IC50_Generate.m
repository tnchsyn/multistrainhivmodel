clc
clear
load('map');
load('NETS');
load('Mutation_Data');
Z=1:1224;
INPUT=zeros(2^17,1224);
for q=2:2^17
C=Z(map(X{q}));
INPUT(q,C)=1;   
end

IC=zeros(6,2^17);
for i=1:6  
    for j=1:50
IC(i,:)=IC(i,:)+NETS{i,j}(INPUT');
    end
end
IC=IC./50;

save('IC.mat','IC')