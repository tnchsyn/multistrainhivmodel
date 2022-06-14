function [Z] = Prior_Estimate(y0,IC50,PK,IC,ML)

V=ML(:,1)==y0;
V=[y0;ML(V,2)];
bp1=10^10;
bp2=10^10;
i=0;
for da=1:6
    for db=1:6
        if da>=db
            if da==db
                S=da;
                DR=0;
            else
            S=[da,db];
            DR=[0,0];
            end
            i=i+1;
         for j=1:length(V)
Z(i,j)=Z_generate2(S,IC,1,IC50,V(j),PK,1,DR);          
         end

    end
end
end
H=Z(:,2:end);
Z=[Z(:,1),sort(H','descend')'];
end