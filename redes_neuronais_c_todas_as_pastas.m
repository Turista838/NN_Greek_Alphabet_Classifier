function redes_neuronais_c_todas_as_pastas()

clc

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

%net = feedforwardnet; %default

%EXCEL - 1º Quadro
%net = feedforwardnet([50]);
net = feedforwardnet([40 40 40 40]);
%net = feedforwardnet([50 50 50 50 50 50]);
%net = feedforwardnet([10 10]); % 10 10

% COMPLETAR A RESTANTE CONFIGURACAO
%EXCEL - 2º Quadro
%se não estivesse aqui nada abaixo, é treino default (trainlm)
net.trainFcn = 'traincgb'; 

%EXCEL - 3º Quadro
%net.layers{1}.transferFcn = 'netinv';
%net.layers{2}.transferFcn = 'radbasn';
%net.layers{3}.transferFcn = 'satlins';
%net.layers{4}.transferFcn = 'hardlims';
%net.layers{3}.transferFcn = 'logsig';

%EXCEL - 4º Quadro
net.divideFcn = 'dividerand';
%net.divideFcn='';
net.divideParam.trainRatio = 0.70;
net.divideParam.valRatio = 0.15;
net.divideParam.testRatio = 0.15;
% somar sempre até aos 100%

%treinar a rede
[net,tr] = train(net, main_matrix, target); %nome_rede = train(nome_rede, input, target)
%save net %load net


%load rede.mat;

y = sim(net, main_matrix); % sim(nome_rede, input)

%simular a rede e guardar o resultado na variavel y

plotconfusion(target, y) 

%Calcula e mostra a percentagem de classificacoes corretas no total dos exemplos (medidas de desempenho)
r=0;
for i=1:size(y,2)                
  [a b] = max(y(:,i));          
  [c d] = max(target(:,i));  
  if b == d                       
      r = r+1;
  end
end

accuracy = r/size(y,2)*100;
fprintf('\nPrecisão total %0.2f\n\n', accuracy)

% SIMULAR A REDE APENAS NO CONJUNTO DE TESTE
Tmain = main_matrix(:, tr.testInd);
Ttarget = target(:, tr.testInd);
y = sim(net, Tmain);

r=0;
for i=1:size(tr.testInd,2)                
  [a b] = max(y(:,i));          
  [c d] = max(Ttarget(:,i));  
  if b == d                       
      r = r+1;
  end
end

accuracy = r/size(tr.testInd,2)*100;

fprintf('Precisão de teste %0.2f\n', accuracy)

view(net)

prompt = '\n\nDeseja guardar a rede? [S/N]\n';
str = input(prompt,'s');
if(str == 'S' || str == 's')
    save rede net tr 
    fprintf('Rede guardada\n')
else
    fprintf('Rede não guardada\n')
end

end


