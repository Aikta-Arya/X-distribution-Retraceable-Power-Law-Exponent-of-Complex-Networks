%This code fits a X-distributional model to data.

clc;
clear;
gamma=zeros(1,100);

for it=1:1
% Elist = ROC12(.4,.2,100000); % if p=q, ROC1, otherwise ROC2 gamma=1/q
% Elist = NRMXdist(.3,.4,100000); % gamma=1/(beta+(1-beta)p)
% Elist = CDPAMXdist(5,100,100000); %mm, beta,n gamma=2*beta/(0.5+beta)
% Elist = DMSXdist(5,20,100000); % mm, beta, n, gamma=2+beta/mm
  Elist = DMSXdist(5,0,100000); % BA model gamma=2
% Elist = CPMXdist(0.7,1000000);% gamma=1/p

% load('court.mat');

Theta=.001:.01:50;
m=length(Elist);

list=zeros(1,2*m);
list(1:m)=Elist(:,1);
list(m+1:2*m)=Elist(:,2);
n=length(unique(list));

D=tabulate(Elist(:,1));
InDegree=zeros(n,1);
InDegree(D(:,1))=(D(:,2));

D=tabulate(Elist(:,2));
outDegree=zeros(n,1);
outDegree(D(:,1))=(D(:,2));
error1=zeros(1,length(Theta));
for j=1:length(Theta)
X=zeros(1,n);
theta=Theta(j);
for i=1:n
    X(i)=(InDegree(i)+outDegree(i)+theta)/(outDegree(i)+theta);
end

X1=(unique(X))';
Xdist=zeros(length(X1),1);

for i=1:length(X1)
    Xdist(i)=length(find(X>=X1(i)));
    
end


Xdist=Xdist/Xdist(1);
X=X1;
Y=Xdist;

p = polyfit(log(X),log(Y),1); 

tempY = polyval(p,log(X));
error=sum(abs(tempY-log(Y)));

% Evaluating Coefficients
a = p(1);

% Accounting for the log transformation
k = exp(p(2));

error1(j)=error;

if(error>error1(1))&&(j>100)
    error1=error1(1:j);
    break;
end

end


X=1:1:length(error1);
p = polyfit(X,error1,10); 

tempY = polyval(p,X);

[val, index]=min(tempY);
theta=Theta(index);
X=zeros(1,n);
for i=1:n
    X(i)=(InDegree(i)+outDegree(i)+theta)/(outDegree(i)+theta);
end

X1=(unique(X))';
Xdist=zeros(length(X1),1);

for i=1:length(X1)
    Xdist(i)=length(find(X>=X1(i)));
    
end
Xdist=Xdist/Xdist(1);



% Setting up data
X=X1;
Y=Xdist;

% Plotting the data
loglog(X,Y,'.','color',[1/(1+theta) .5 0]);
hold on;
grid on;
grid minor;
pause(1)

% Polynomial curve fitting of log values so that we have a linear equation
% Simplifying, log(Y) = log(k*X.^a) = log(X)*a + log(k)
p = polyfit(log(X),log(Y),1); 
tempY = polyval(p,log(X));
error=sum(abs(tempY-log(Y)));

% Evaluating Coefficients
a = p(1);

% Accounting for the log transformation
k = exp(p(2));
error1(j)=error;
gamma(it)=-a;
error;
it
error1(j)=error;

%% Degree distribution

m=length(Elist);
list=zeros(1,2*m);
list(1:m)=Elist(:,1);
list(m+1:2*m)=Elist(:,2);
n=length(unique(list));

list=list';
n=length(unique(list));
D=tabulate(list(:,1));
Degree=zeros(n,1);
Degree(D(:,1))=(D(:,2));
[alpha, xmin, L, D1]= plfit(Degree,'range',[1.001:0.001:11.001]);
gamma(it)=alpha;

hold on;
plplot(Degree,xmin,alpha);


end

