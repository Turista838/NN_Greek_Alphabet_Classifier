function redes_neuronais_a()

clc

base_directory = 'Datasets greek\\Pasta1\\%d.jpg';

for i=1:10
    directory = sprintf(base_directory,i);
    image = imread(directory);
    image = imresize(image,0.035);
    image = imbinarize(image); %põe a imagem a 0's e 1's
    binary_matrix = image(:); %põe todos os bits numa coluna
    if i>1
        main_matrix = [main_matrix binary_matrix];
    else
        main_matrix = binary_matrix;
    end
end

target = [1 0 0 0 0 0 0 0 0 0;
          0 1 0 0 0 0 0 0 0 0;
          0 0 1 0 0 0 0 0 0 0;
          0 0 0 1 0 0 0 0 0 0;
          0 0 0 0 1 0 0 0 0 0;
          0 0 0 0 0 1 0 0 0 0;
          0 0 0 0 0 0 1 0 0 0;
          0 0 0 0 0 0 0 1 0 0;
          0 0 0 0 0 0 0 0 1 0;
          0 0 0 0 0 0 0 0 0 1];

%count_rows=height(main_matrix);
%fprintf('Count rows:\n');
%count_rows

%criar a rede chamada net
net = feedforwardnet;
net.divideFcn='';

%Numero de epocas de treino: 100
%net.trainParam.epochs = 100;
net.trainFcn='traincgb'; %trainlm

%valores quando resize 90%:
%traingdx 10/0
%trainc 40% (demora muito)
%traincgb 40 e 60 (rápida)
%traincgf 30/20
%traincgp 10/10
%traingd 10/0
%traingda 10/0
%traingdm 20/10
%trainoss 50/10
%trainr 10/10
%trainrp 50/40/50
%trains 70/30/70
%trainscg 10/50/0

%treinar a rede
[net,tr] = train(net, main_matrix, target); %nome_rede = train(nome_rede, input, target)

%simular a rede e guardar o resultado na variavel y
y = sim(net, main_matrix); % sim(nome_rede, input)
%plotconfusion(target, y) %alinea B

% Mostrar resultado
fprintf('Saida do y:\n');
disp(y);
fprintf('Saida desejada:\n');
disp(target);

% visualizar a arquitetura da rede criada
view(net)


r=0;
for i=1:size(y,2)                
  [a, b] = max(y(:,i));          
  [c, d] = max(target(:,i));  
  if b == d                       
      r = r+1;
  end
end

accuracy = r/size(y,2)*100;
fprintf('\nPrecisao total %f\n\n', accuracy);



end