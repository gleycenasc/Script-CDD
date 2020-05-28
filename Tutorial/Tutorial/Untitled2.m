clc
clear all
close all
year_01 =1994;
year_02 = 2018;

a = year_01:year_02;
a= a';

a1=a;
for i=1:11
    a=vertcat (a,a1);
end

b (length (a),1)= 0;

j=0;
for i= 1:12
    
    b(j+1:length (a1)+j) = i;
    j=j+25;
end

P=length (a);

A= ones([P,33])*NaN;
A (:,1)=a;
A (:,2)=b;

B= xlsread ( 'Dados.xlsx' );

for k = 1:length (A)
    
    if B(k,1:2)== A (k,1:2)
        
       
    else
        if k==1
            
            B1(1,:) = A(k,:);
            B = vertcat (B1, B);
            
        else
            B1= B (1:(k-1),:);
            A1 = A(k,:);
            BF = vertcat (B1, A1);
                       
            r=B(k:end,:);
            B2= vertcat (BF , r);
            B=B2;
        end
    end
    
end

if length (BF) == length (A)
    
    BF=BF;
    
elseif length (B) == length (A)
    BF=B;
else
    fprintf(2,'\\\\\\\\\\\\\\\\\\\\\\\Erro\\\\\\\\\\\\\\\\\\\\\\')
end
    
    

% BF é a matriz final

anos_b = (1904:4:2032);

for k = 1:length (BF)
    
    if BF(k,2)== 1|BF(k,2)== 3|BF(k,2)==5|BF(k,2)==7|BF(k,2)==8|BF(k,2)==10|BF(k,2)==12 %meses com 31 dias
        
        
        
    elseif BF(k,2)== 4|BF(k,2)==6|BF(k,2)==9|BF(k,2)==11 %meses com 30 dias
        
        
        BF(k,33)= -11;
        
    elseif BF(k,2)== 2
        
        h=BF (k,1);
        aux =ismember(h,anos_b);
        
        
        if aux ==1  %O ano é bissexto
            BF(k,32:33)= -11;
        else
            BF(k,31:33)= -11;
        end
        
    end
    
end





