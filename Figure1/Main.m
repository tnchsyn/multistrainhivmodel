clc
clear

load('Data.mat');

T=Data;

z=0;
for i=1:1707
    
   S= T.CompMutList(i);
   S=convertStringsToChars(S);
   [V]=str_char_improved(S);
   
   for k=1:length(V)
   z=z+1;    
       W{z}=V{k};
       
   end
   
end

W=unique(W);
d=0;
for i=1:1707

if ~isnan(T.TC(i))
d=d+1; 
S= T.CompMutList(i);
S=convertStringsToChars(S);
[V]=str_char_improved(S);
for k=1:length(V)
z=z+1;
for j=1:length(W)
if convertCharsToStrings(W{j})==convertCharsToStrings(V{k})           
INP_3TC(j,d)=1;
end
end
end
OUT_3TC(d,1)=log10(T.TC(i));
end    
 
end
 
d=0;
for i=1:1707
if ~isnan(T.ABC(i))
d=d+1; 
S= T.CompMutList(i);
S=convertStringsToChars(S);
[V]=str_char_improved(S);
for k=1:length(V)
z=z+1;
for j=1:length(W)
if convertCharsToStrings(W{j})==convertCharsToStrings(V{k})           
INP_ABC(j,d)=1;
end
end
end
OUT_ABC(d,1)=log10(T.ABC(i));
end
end

d=0;
for i=1:1707
if ~isnan(T.AZT(i))
d=d+1; 
S= T.CompMutList(i);
S=convertStringsToChars(S);
[V]=str_char_improved(S);
for k=1:length(V)
z=z+1;
for j=1:length(W)
if convertCharsToStrings(W{j})==convertCharsToStrings(V{k})           
INP_AZT(j,d)=1;
end
end
end
OUT_AZT(d,1)=log10(T.AZT(i));
end
end

d=0;
for i=1:1707
if ~isnan(T.D4T(i))
d=d+1; 
S= T.CompMutList(i);
S=convertStringsToChars(S);
[V]=str_char_improved(S);
for k=1:length(V)
z=z+1;
for j=1:length(W)
if convertCharsToStrings(W{j})==convertCharsToStrings(V{k})           
INP_D4T(j,d)=1;
end
end
end
OUT_D4T(d,1)=log10(T.D4T(i));
end
end

d=0;
for i=1:1707
if ~isnan(T.DDI(i))
d=d+1; 
S= T.CompMutList(i);
S=convertStringsToChars(S);
[V]=str_char_improved(S);
for k=1:length(V)
z=z+1;
for j=1:length(W)
if convertCharsToStrings(W{j})==convertCharsToStrings(V{k})           
INP_DDI(j,d)=1;
end
end
end
OUT_DDI(d,1)=log10(T.DDI(i));
end
end

d=0;
for i=1:1707
if ~isnan(T.TDF(i))
d=d+1; 
S= T.CompMutList(i);
S=convertStringsToChars(S);
[V]=str_char_improved(S);
for k=1:length(V)
z=z+1;
for j=1:length(W)
if convertCharsToStrings(W{j})==convertCharsToStrings(V{k})           
INP_TDF(j,d)=1;
end
end
end
OUT_TDF(d,1)=log10(T.TDF(i));
end
end

Final{1}=[INP_3TC;OUT_3TC'];
Final{2}=[INP_ABC;OUT_ABC'];
Final{3}=[INP_AZT;OUT_AZT'];
Final{4}=[INP_D4T;OUT_D4T'];
Final{5}=[INP_DDI;OUT_DDI'];
Final{6}=[INP_TDF;OUT_TDF'];


