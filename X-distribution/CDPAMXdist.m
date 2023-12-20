function Elist = CDPAMXdist(mm,beta,n)
degree=zeros(1,n);

m=40;
list= zeros(m*n,2);
count=2;

list(1,1)=1;
list(1,2)=2;
degree(1)=1;
degree(2)=1;
for j=3:n
    
    if(j<=20*mm)
       % while(1)
       if(j<=mm)
            x1=randi(j-1,1,1);
       else
           x1=randi(j-1,mm,1);
       end
       list(count:(count+length(x1)-1),1)=x1;
       list(count:(count+length(x1)-1),2)=j;
       count=count+length(x1);
       degree(j)=degree(j)+length(x1);
       degree(x1)=degree(x1)+1;
    else
       v=((beta+0.5)*degree(1:j-1)-mm)/(2*beta*j);
%     v=mm*p/sum(p);
      % v=(beta+degree(1:j-1));
            p1=v-rand(1,j-1);
            x1=find(p1>=0);
            if(~isempty(x1))
            %x1=x(x1);


        %             for k=1:length(x)
        %                 if(rand(1,1)<p)
                             list(count:(count+length(x1)-1),1)=x1;
                             list(count:(count+length(x1)-1),2)=j;
                             count=count+length(x1);
                             degree(j)=degree(j)+length(x1);
                             degree(x1)=degree(x1)+1;
                         %    break;
        %                 end
        %             end
            end
       % end
%     if(mod(j,10^5)==0)
%      j
%     end
    end
end

count=count-1;
Elist=list(1:count,:);
end