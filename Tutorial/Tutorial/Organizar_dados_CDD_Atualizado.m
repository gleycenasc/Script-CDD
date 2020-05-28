clc
clear all
close all


dados = {'Entre com o primeiro ano de análise:','Entre com o último ano de análise:', 'Entre com o nome da área de estudo(sem espaço e sem acento):'};
titulo = 'Dados de entrada';
linhas=1;
resposta=inputdlg(dados,titulo,linhas);
year_01 =str2num(char(resposta(1)));
year_02 =str2num(char(resposta(2)));
name_area = char(resposta(3));
format bank

B= xlsread ( 'Dados.xlsx' );


if min (B(:,1))==year_01 & max (B(:,1))==year_02

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

A= ones([P,33])*99.9;
A (:,1)=a;
A (:,2)=b;


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





c = BF;




    
    
    
    year = year_01:year_02;
    
    
    I=[ 'f(1:',num2str(length (year)),',2)=zeros;'];
    eval (I);
    
    for j=1:length (year)
        match = c(:,1) == year (j);
        extracted_data = c(match,:);
        
        A = ['year' , num2str(year (j)) , '= extracted_data;'];
        eval (A);
        
        
        
        
        G = ['p=size(year',num2str(year (j)),');'];
        eval (G);
        
        H =[ 'f(',num2str(j),',1:2)=p;'];
        eval (H);
        
        
    end
    
    if f(:,1)==12 & f(:,2)==33
        
        
        
        
        
        
        
        
        for j=1:length (year)
            match = c(:,1) == year (j);
            extracted_data = c(match,:);
            
            A = ['year' , num2str(year (j)) , '= extracted_data;'];
            
            eval (A);
            
            extracted_data = extracted_data';
            h = length (extracted_data);
            aux(h-2,1)=zeros;
            
            for i=1:length (extracted_data(1,:)) %cada i representa um mês
                
                if i==1
                    aux(:,1)=extracted_data(3:h,1);
                else
                    aux1(:,1)= extracted_data(3:h,i);
                    aux = vertcat(aux,aux1);
                    
                end
                
            end
            %aux será os dados de cada ano
            %
            aux (aux==-11)=[];
            
            if j==1
                data_end = aux;
            else
                data_end1 = aux;
                data_end = vertcat (data_end,data_end1);
            end
            
            clear aux
            clear aux1
        end
        
        
        y= '/01/01';
        p= '/12/31';
        
        J = [ num2str(year_01), y];
        
        K = [num2str(year_02), p];
        
        
        date2 = datenum( J ):datenum(K);
        date2 = datevec(date2);
        
        
        
        
        
        if length (date2)==length (data_end)
            
            
            aux = [2 3];
            Gleyce = [date2(:,1:3) data_end];
            
            Gleyce(:, aux) = [];
            
            
            for i=1:length (year)-1
                aux1= ones([731 2])*-11;
                
                match1 = Gleyce(:,1) == year (i);
                gley1 = Gleyce(match1,:);
                match2 = Gleyce(:,1) == year (i+1);
                gley2 = Gleyce(match2,:);
                
                aux1 = vertcat (gley1,gley2);
                A = ['Dias_cons_fin' , num2str(year (i)),'_',num2str(year (i+1)),'= aux1;'];
                eval (A);
                
                
                if length(aux1)== 730
                    h=[-11 -11];
                    aux1 = vertcat (aux1, h);
                else
                    aux1=aux1;
                end
                
                if i == 1
                    
                    Dias_cons_fin = aux1;
                    
                else
                    Dias_cons_fin = [ Dias_cons_fin   aux1];
                end
                
                
            end
            
            Dias_cons_01 =  Dias_cons_fin;
            
            aux2 = (1:2:length (Dias_cons_fin(1,:)));
            
            Dias_cons_fin(:, aux2) = [];
            
            Dias_cons_fin (:,length (year)) = NaN;
            
            Dias_cons_fin (1:length (gley2),length (year)) = gley2 (:,2);
            
            
            
            q=length (year);
            
            Results_Names = strings([1,q]);
            
            for i=1:length (year)
                
                
                
                if i== length (year)
                    
                    Results_Names(1,i)= year_02;
                    
                else
                    h1= num2str (year (i));
                    h2=num2str (year(i+1));
                    Anos_name1 = [h1,'/',h2,' ' ];
                    
                    Results_Names(1,i)=Anos_name1;
                    
                    
                end
            end
            
            
            
            o=length (year);
            
            
            
            filename = ['Dados_',name_area,'.xls'];
            
            Results_Values= Dias_cons_fin;
            xlRange='A2';
            sheet=1;
            xlswrite(filename,Results_Values,sheet,xlRange);
            xlRange='A1';
            xlswrite(filename,Results_Names,sheet,xlRange);
            %     winopen(filename);
            
            fprintf ('\n\n')
            
            fprintf ('////////////////////////////////////////////////////////Fim/////////////////////////////////////////////////////\n\n')
            
            fprintf ('                                     SEUS DADOS FORAM BAIXADOS COMO:  %s\n\n',filename)
            
            fprintf ('////////////////////////////////////////////////////////Fim/////////////////////////////////////////////////////\n\n')
            
            clear all
            
            
        else
            
            fprintf ('\n \n \n')
            fprintf (2,'////////////////////////////////////////////////////////////////////////////////////////////////////////////////\n\n')
            
            
            fprintf (2,'                              HOUVE ERRO NO PREENCHIMENTO DOS DIAS INEXISTENTES (-11)\n\n')
            
            
            fprintf (2,'                                        VERIFIQUE NA PLANILHA EXCEL\n\n')
            
            fprintf (2,'////////////////////////////////////////////////////////////////////////////////////////////////////////////////\n\n')
            
            clear  all
            
            return
            
            
            
        end
        
        
        
        
        
    else
        fprintf (2,'/////////////////////////////////////////////////////////////ERRO/////////////////////////////////////////////////////\n\n')
        
        fprintf(2,'                                                   OS DADOS ESTÃO INCOMPLETOS\n\n');
        
        fprintf (2,'/////////////////////////////////////////////////////////////ERRO/////////////////////////////////////////////////////\n\n')
        
        k= find (f(:,1) ~= 12);
        
        
        K = isempty(k);
        
        
        if   K ==0
            
            for j=1:length (k)
                p= k(j,1);
                
                
                K= ['                                        O ano de ' , num2str(year (p)),' está com um ou mais meses faltosos'];
                disp (K);
                
                
            end
        end
        fprintf('\n')
        fprintf ('                                                  VERIFIQUE NA PLANILHA EXCEL\n\n')
        
        clear  all
        return
    end
    
    
else
    
    
    fprintf ('\n \n \n')
    
    fprintf (2,'////////////////////////////////////////////////////////ERRO/////////////////////////////////////////////////////\n\n')
    
    fprintf(2,'                                   OS ANOS ADICIONADOS ESTÃO INCORRETOS, TENTE NOVAMENTE \n\n');
    
    fprintf (2,'////////////////////////////////////////////////////////ERRO/////////////////////////////////////////////////////\n\n')
    
    clear all

    
    return
    
end








