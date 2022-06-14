
map=[];
for i=1:1224
   for j=1:17
      
       if length(W{i})==length(Muts_Rest{j})
       if W{i}(2:end)==Muts_Rest{j}(2:end)
           map=[map,i];
       end
       end
   end
    
end