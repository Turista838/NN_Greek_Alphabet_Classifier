function [net, tr, accuracyTotal, accuracyTeste] = redes_neuronais_b_GUI(f_treino, f_ativa, mat_topologia, pasta, perc_treino, perc_val, perc_teste, but)

clc
if (pasta == "Pasta123")
    
            diretoria1 = 'Datasets greek\\Pasta1';

        d1 = dir([diretoria1 '/*.jpg']);

        [~, reindex] = sort( str2double( regexp( {d1.name}, '\d+', 'match', 'once' )));

        d1 = d1(reindex) ;




        diretoria2 = 'Datasets greek\\Pasta2';

        d2 = dir([diretoria2 '/*.jpg']);

        [~, reindex] = sort( str2double( regexp( {d2.name}, '\d+', 'match', 'once' )), 'descend');

        d2 = d2(reindex) ;




        diretoria3 = 'Datasets greek\\Pasta3';

        d3 = dir([diretoria3 '/*.jpg']);

        [~, reindex] = sort( str2double( regexp( {d3.name}, '\d+', 'match', 'once' )));

        d3 = d3(reindex) ;

        prim = 1;
        seg = 1;
        terc = 1;
        total_cont = 1;

        d_total = string.empty;

        for i=1:10
            d_total(total_cont) = d1(prim).name;
            prim = prim + 1;
            total_cont = total_cont + 1;

            for k=1:10
                d_total(total_cont) = d2(seg).name;
                total_cont = total_cont + 1;
                seg = seg + 1;
            end

            for j=1:4
                d_total(total_cont) = d3(terc).name;
                total_cont = total_cont + 1;
                terc = terc + 1;
            end

        end
        
         cont = 0;
 
    for i=1:150
        directory = sprintf(d_total(i));
        image = imread(directory);
        image = imresize(image,0.035);
        image = imbinarize(image); %põe a imagem a 0's e 1's
        binary_matrix = image(:); %põe todos os bits numa coluna
        cont = cont+1;
        if i>1
            main_matrix = [main_matrix binary_matrix];
        else
            main_matrix = binary_matrix;
        end
    end
    
else
    
        diretoria = 'Datasets greek\\';

        diretoria = append(diretoria, pasta);

        fprintf('\nDiretoria------- %s\n\n', diretoria)

        d = dir([diretoria '/*.jpg']);

        if strcmp(diretoria,'Datasets greek\\Pasta2')   
            [~, reindex] = sort( str2double( regexp( {d.name}, '\d+', 'match', 'once' )), 'descend');
        else
            [~, reindex] = sort( str2double( regexp( {d.name}, '\d+', 'match', 'once' )));
        end

        d = d(reindex) ;



     cont = 0;

    for i=1:size(d)
        directory = sprintf(d(i).name);
        image = imread(directory);
        image = imresize(image,0.035);
        image = imbinarize(image); %põe a imagem a 0's e 1's
        binary_matrix = image(:); %põe todos os bits numa coluna
        cont = cont+1;
        if i>1
            main_matrix = [main_matrix binary_matrix];
        else
            main_matrix = binary_matrix;
        end
    end

end

r = cont/10;
target = zeros(10,cont);

linha = 1;
k = r;

for i=1:cont
        target(linha,i) = 1;
        if i == r
            r = r + k;
            linha = linha + 1;
        end
    
end

%target

% CRIAR E CONFIGURAR A REDE NEURONAL
% INDICAR: N? camadas escondidas e nos por camada escondida
% INDICAR: Funcao de treino: {'trainlm', 'trainbfg', traingd'}
% INDICAR: Funcoes de ativacao das camadas escondidas e de saida: {'purelin', 'logsig', 'tansig'}
% INDICAR: Divisao dos exemplos pelos conjuntos de treino, validacao e teste

%net = feedforwardnet; %default

%EXCEL - 1º Quadro
%net = feedforwardnet([50]);
%net = feedforwardnet([40 40 40 40]);
net = feedforwardnet(mat_topologia);
%net = feedforwardnet([10 10]); % 10 10
sz_top = size(mat_topologia);
% COMPLETAR A RESTANTE CONFIGURACAO
%EXCEL - 2º Quadro
%se não estivesse aqui nada abaixo, é treino default (trainlm)
net.trainFcn = f_treino; 
%net.TrainParam.epochs = 5000; %assim tira os defaults das 1000

for l=1:sz_top
    net.layers{l}.transferFcn = f_ativa;
end

%EXCEL - 3º Quadro
%net.layers{1}.transferFcn = 'netinv';
%net.layers{2}.transferFcn = 'radbasn'; %este aqui é default mas não tenho a certeza
%net.layers{3}.transferFcn = 'satlins'; %Não esquecer que para fazer isto teriamos de por 2 camadas net = feedforwardnet([10 10]); ou 5 5
%net.layers{4}.transferFcn = 'hardlims';
%net.layers{3}.transferFcn = 'logsig';

%EXCEL - 4º Quadro
net.divideFcn = 'dividerand';
%net.divideFcn='';
net.divideParam.trainRatio = perc_treino;
net.divideParam.valRatio = perc_val;
net.divideParam.testRatio = perc_teste;
% somar sempre até aos 100%

%treinar a rede
[net,tr] = train(net, main_matrix, target); %nome_rede = train(nome_rede, input, target)
%save net %load net
 
y = sim(net, main_matrix); % sim(nome_rede, input)

%simular a rede e guardar o resultado na variavel y

%plotconfusion(target, y) %alinea B
if(strcmp(but,'On'))
plotconfusion(target, y) %alinea B
end
%Calcula e mostra a percentagem de classificacoes corretas no total dos exemplos (medidas de desempenho)
r=0;
for i=1:size(y,2)                
  [a b] = max(y(:,i));          
  [c d] = max(target(:,i));  
  if b == d                       
      r = r+1;
  end
end

accuracyTotal = r/size(y,2)*100;
fprintf('\nPrecisao total %f\n\n', accuracyTotal)


% SIMULAR A REDE APENAS NO CONJUNTO DE TESTE
Tmain = main_matrix(:, tr.testInd);
Ttarget = target(:, tr.testInd);
y = sim(net, Tmain);
%fprintf('\nTmain---------\n')
%Tmain
%fprintf('\nTtarget---------\n')
%Ttarget

r=0;
for i=1:size(tr.testInd,2)                
  [a b] = max(y(:,i));          
  [c d] = max(Ttarget(:,i));  
  if b == d                       
      r = r+1;
  end
end

accuracyTeste = r/size(tr.testInd,2)*100;

fprintf('Precisao teste %f\n', accuracyTeste)


end


