function Elist = CPMXdist(p,n)
m=40;
list= zeros(m*n,2);
count=2;

list(1,1)=1;
list(1,2)=2;
for j=3:n
    
    i=randi(j-1,1,1);
    list(count,1)=i;
    list(count,2)=j;
    
    x=find(list(1:count-1,2)==i); % out-degree of node i
%     y=find(list(1:count-1,1)==i); % in-degree of node i
    count=count+1;
    
    p1=rand(1,length(x))-p;
%     p2=rand(1,length(y))-p;
    x1=find(p1<=0);
%     y1=find(p2<0);
    if(~isempty(x1))
    x1=x(x1);
    
    
%             for k=1:length(x)
%                 if(rand(1,1)<p)
                     list(count:(count+length(x1)-1),1)=list(x1,1);
                     list(count:(count+length(x1)-1),2)=j;
                     count=count+length(x1);
%                 end
%             end
    end
%     if(~isempty(y1))
%     y1=y(y1);
% %              for k=1:length(y)
% %                 if(rand(1,1)<p)
%                      list(count:(count+length(y1)-1),1)=list(y1,2);
%                      list(count:(count+length(y1)-1),2)=j;
%                      count=count+length(y1);
% %                 end
% %             end
%     end
 
%     if(mod(j,10^5)==0)
%         j
%     end
    
end

count=count-1;
Elist=list(1:count,:);
end
