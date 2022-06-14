clc
clear

load('Final.mat');

for i=1:6
    
Xtrain=Final{i}(1:end-1,:);
Ytrain=Final{i}(end,:);

BESTPER=10^5;
for N=5:5
  
    for r=1:50
        disp(i)
        disp(r)
for s=1:100

x = Xtrain;
t = Ytrain;

% Create a Fitting Network
hiddenLayerSize = N;
trainFcn='trainscg';
net = fitnet(hiddenLayerSize,trainFcn);

% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 80/100;
net.divideParam.valRatio = 10/100;
net.divideParam.testRatio = 10/100;
net.trainParam.min_grad=10^-10;
net.trainParam.epochs=1000;
net.input.processFcns = {'mapminmax'};
net.output.processFcns = {'mapminmax'};
% net.trainParam.max_fail=100;
% Train the Network
[net,tr] = train(net,x,t,'useGPU','yes');

y = net(x);
e = gsubtract(t,y);
performance = perform(net,t,y);
% 
% % Recalculate Training, Validation and Test Performance
trainTargets = t .* tr.trainMask{1};
valTargets = t .* tr.valMask{1};
testTargets = t .* tr.testMask{1};
% 
trainPerformance = perform(net,trainTargets,y);
valPerformance = perform(net,valTargets,y);
testPerformance = perform(net,testTargets,y);


if testPerformance<BESTPER
BESTPER=testPerformance;
BESTNET=net;
% V=sprintf('BEST_SIM_DATA_EXCLUDE_%.0f.mat',i);
% save(V);
end

end
NETS{i,r}=BESTNET;
    end
end

end
save('NETS.mat',"NETS")