clc
clear
DR={'3TC','ABC','AZT','D4T','DDI','TDF'};
load('PKRES.mat')

PKRES=PKRES(:,2:end).*4*10^-8;
r=0;
for da=1:6
    for db=1:6
        if da>=db
r=r+1;
if da==db
name{r}=sprintf('%s',DR{db});
else
name{r}=sprintf('%s - %s',DR{da},DR{db});
end

        end
    end
end

figure1 = figure;

for i=1:21
A=PKRES(i,:);
ST(i,1)=min(A);
ST(i,2)=max(A);
ST(i,3)=mean(A);
ST(i,4)=std(A);
ST(i,5)=median(A);
ST(i,6)=mode(A);
ST(i,7:8)=quantile(A,[0.25 0.75]);

subplot(5,5,i)
subplot1 = subplot(5,5,i,'Parent',figure1);
hold(subplot1,'on');

% Create histogram
histogram(PKRES(i,:),'Parent',subplot1,...
    'Normalization','probability',...
    'NumBins',50);
% Create ylabel
ylabel('P(X=\beta_{i})');

% Create xlabel
xlabel('\beta_{i}');

% Create title
title(name{i});

box(subplot1,'on');
grid(subplot1,'on');
hold(subplot1,'off');
% Set the remaining axes properties
set(subplot1,'FontAngle','italic','FontSize',12,'FontWeight','bold','YScale','log');
end

