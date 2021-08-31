function redes_neuronais_d()

clc

greek_letters = ["Alfa" "Beta" "Gama" "Épsilon" "Eta" "Teta" "Pi" "Ró" "Psi" "Ômega"];

base_directory = 'teste_200_200.jpg';

load rede.mat;
      
image = imread(base_directory);
image = rgb2gray(image); %importante
image = imresize(image, [106 106]); % 106 * 106 pixeis (ou 3,5%)
image = imbinarize(image); %põe a imagem a 0's e 1's
binary_matrix = image(:); %põe todos os bits numa coluna


[val, idx] = max(net(binary_matrix)); %[valor maior, index]

fprintf('\nLetra lida pela rede neuronal: %s\n', greek_letters(idx));

end


