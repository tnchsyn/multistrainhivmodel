function [Z] = PK_RESULTS(IC50,PK,IC)
Z=[];
parfor j=1:131072
M=[];
disp(j)
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
M=[M;Z_generate(S,IC,1,IC50,j,PK,1,DR)];
        end
    end
end
Z=[Z,M];
end

end