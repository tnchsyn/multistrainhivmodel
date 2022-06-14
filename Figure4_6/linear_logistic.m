function [fobj] = linear_logistic(x,X)
fobj=0;
sig=@(x) 1./(1+exp(-x));
X(:,2)=X(:,2)./365;
for i=1:size(X,1)
    f=sig(x(1).*X(i,1)+x(2).*X(i,2)+x(3));
    fobj=fobj-(X(i,3)*log(f)+(1-X(i,3))*log(1-f));
    
end

end