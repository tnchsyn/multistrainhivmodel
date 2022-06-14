function [X,Q,ML]=M_generate()

X=cell(2^17,1);

X{1}=0;
V=1:17;
m=1;
Q(1)=2;
for i=1:17
C=nchoosek(V,i); 
h=0;
for j=m+1:m+size(C,1)
h=h+1;
X{j}=C(h,:);        
end
Q(i+1)=j+1;
m=m+size(C,1);
end

for i=1:17
   ML(i,1)=1;
   ML(i,2)=i+1;    
end
k=17;
for q=1:16   
w1=Q(q):Q(q+1)-1;
w2=Q(q+1):Q(q+2)-1;

for j1 = w1
for j2 = w2

if ismember(X{j1},X{j2})

k=k+1;
ML(k,1)=j1;    
ML(k,2)=j2; 

end
end
end
end

end
