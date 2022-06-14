clc
clear

load('Final.mat');
load('summary.mat')
DR={'3TC','ABC','AZT','D4T','DDI','TDF'};

for i=1:6
    
Xtrain=Final{i}(1:end-1,:);
Ytrain=Final{i}(end,:);

S=zeros(1,length(Ytrain));
for j=1:50

S=S+COL_BESTNET{i,j}(Xtrain);

end

Ypredict=S./50;

subplot1 = subplot(2,3,i);

scatter(Ytrain,Ypredict)
hold on
plot(Ytrain,Ytrain,'LineWidth',2)

MSE=mse(Ytrain,Ypredict);

R=corrcoef(Ytrain,Ypredict);
R=R(1,2);

MSE_V(i)=MSE;
R_V(i)=R;

name=sprintf('%s ; R = %0.3f ; MSE = %0.3f',DR{i},R,MSE);
title(name)
set(subplot1,'FontAngle','italic','FontSize',20,'FontWeight','bold');
grid(subplot1,'on');
ylabel('Prediction');

% Create xlabel
xlabel('Data');
end
