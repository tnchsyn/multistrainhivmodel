function [Cb]=drug_blood_itself(D00,T0,T,V)
if length(D00)==1
D=V(1);
Id=V(2);
F=V(3);
ka=V(4);ke=V(5);
% Id=1
vd=V(6);
D0=D*F/vd+D00;
for tt=1:length(T)
if T0==0
t=T(tt);
Nd=fix(t/Id)+1;
else
t=T(tt)+T0;
Nd=1;
end
Cb(tt)=max(((D0*ka*exp(-ke*t))/((ke-ka)*(exp(Id*ka)-1)))*(1-exp((ke-ka)*t)*(1-exp(Nd*ka*Id))+((exp(ke*Id)-exp(ka*Id))*(exp((Nd-1)*ke*Id)-1)...
    )/(exp(ke*Id)-1) -exp(Id*((Nd-1)*ke+ka))),0);
end

else

D=V(1,1);
Id=V(1,2);
F=V(1,3);
ka=V(1,4);ke=V(1,5);
% Id=1
vd=V(1,6);
D0=D*F/vd+D00(1);
for tt=1:length(T)
if T0==0
t=T(tt);
Nd=fix(t/Id)+1;
else
t=T(tt)+T0;
Nd=1;
end
Cb(1,tt)=max(((D0*ka*exp(-ke*t))/((ke-ka)*(exp(Id*ka)-1)))*(1-exp((ke-ka)*t)*(1-exp(Nd*ka*Id))+((exp(ke*Id)-exp(ka*Id))*(exp((Nd-1)*ke*Id)-1)...
    )/(exp(ke*Id)-1) -exp(Id*((Nd-1)*ke+ka))),0);
end

D=V(2,1);
Id=V(2,2);
F=V(2,3);
ka=V(2,4);ke=V(2,5);
% Id=1
vd=V(2,6);
D0=D*F/vd+D00(2);
for tt=1:length(T)
if T0==0
t=T(tt);
Nd=fix(t/Id)+1;
else
t=T(tt)+T0;
Nd=1;
end
Cb(2,tt)=max(((D0*ka*exp(-ke*t))/((ke-ka)*(exp(Id*ka)-1)))*(1-exp((ke-ka)*t)*(1-exp(Nd*ka*Id))+((exp(ke*Id)-exp(ka*Id))*(exp((Nd-1)*ke*Id)-1)...
    )/(exp(ke*Id)-1) -exp(Id*((Nd-1)*ke+ka))),0);
end

end
if any(isnan(Cb))
    w=1;
end
end