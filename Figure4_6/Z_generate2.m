function [OUT]=Z_generate2(S,IC,D,IC50,SS,PK,TD,DR)
CM=0.3015;
% [~,c]=ode45(@(t,y) drug_blood(t,y,D),[0,time],[0,0,0]);
ICC=IC;
r=0;
for t=0:0.01:1
r=r+1;
if length(S)==1  
ESS=ICC(S,SS)';
IC=(10.^(ESS./1)).*IC50(S);
% IC(1)=IC50(S);

fc=CM.*ones(length(SS),1);

wt=find(SS==1);
if ~isempty(wt)
fc(wt)=0;
end

if D(1)==0 
if TD==10^10
Z=(1-fc);
else
c=drug_blood_itself(DR,fix(t+1-TD),t+1-TD,PK(S,:));
DR=c;
Z=(1-fc).*(1-c./(IC+c));   
end
else
c=drug_blood_itself(DR,fix(t+1-TD),t+1-TD,PK(S,:));
Z=(1-fc).*(1-c./(IC+c));  
DR=c;

end

else
ESS1=ICC(S(1),SS)';
ESS2=ICC(S(2),SS)';
IC1=(10.^(ESS1./1)).*IC50(S(1));
IC2=(10.^(ESS2./1)).*IC50(S(2));
% IC1(1)=IC50(S(1));
% IC2(1)=IC50(S(2));

fc=CM.*ones(length(SS),1);

wt=find(SS==1);
if ~isempty(wt)
fc(wt)=0;
end


if D(1)==0 
if TD==10^10
Z=(1-fc);
else
c=drug_blood_itself(DR,fix(t+1-TD),t+1-TD,PK(S,:));
DR=c;
if (S(1)==4 && S(2)==3) || (S(1)==6 && S(2)==5)
Z=(1-fc).*(1./(1+c(1)./IC1 +c(2)./IC2));
else
Z=(1-fc).*(1-c(1)./(IC1+c(1))).*(1-c(2)./(IC2+c(2)));  
end
end
else
c=drug_blood_itself(DR,fix(t+1-TD),t+1-TD,PK(S,:));
if (S(1)==4 && S(2)==3) || (S(1)==6 && S(2)==5)
Z=(1-fc).*(1./(1+c(1)./IC1 +c(2)./IC2));
else
Z=(1-fc).*(1-c(1)./(IC1+c(1))).*(1-c(2)./(IC2+c(2)));  
end
end

end

W(r)=Z';

end

OUT=mean(W);
end