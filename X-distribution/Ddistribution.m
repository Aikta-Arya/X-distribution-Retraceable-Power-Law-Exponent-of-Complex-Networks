

clc;
clear;
itr=100;
gamma=zeros(1,itr);
alpha=0;
xmin=0;
L=0;
D1=0;

for it=1:itr
% Elist = ROC12(.4,.9,100000); % if p=q, ROC1, otherwise ROC2 gamma=1/q
% Elist = NRMXdist(.2,.8,100000); % gamma=1/(beta+(1-beta)p)
% Elist = CDPAMXdist(10,10,100000); %mm, beta,n gamma=2*beta/(0.5+beta)
% Elist = DMSXdist(10,10,100000); % mm, beta, n, gamma=2+beta/mm
  Elist = DMSXdist(4,0,100000); % BA model gamma=2
% Elist = CPMXdist(.8,100000);% gamma=1/p

m=length(Elist);
list=zeros(1,2*m);
list(1:m)=Elist(:,1);
list(m+1:2*m)=Elist(:,2);
n=length(unique(list));
X=zeros(1,n);
list=list';
n=length(unique(list));
D=tabulate(list(:,1));
Degree=zeros(n,1);
Degree(D(:,1))=(D(:,2));
[alpha, xmin, L, D1]= plfit(Degree,'range',[1.001:0.001:11.001]);
gamma(it)=alpha;
it
end

mean(gamma)

std(gamma)