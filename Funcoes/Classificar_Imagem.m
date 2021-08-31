function class = Classificar_Imagem(net, imagem)

clc

greek_letters = ["Alfa" "Beta" "Gama" "Épsilon" "Eta" "Teta" "Pi" "Ró" "Psi" "Ômega"];

      
image = imread(imagem);
image = rgb2gray(image); %importante
image = imresize(image, [106 106]); % 106 * 106 pixeis (ou 3,5%)
image = imbinarize(image); %põe a imagem a 0's e 1's
binary_matrix = image(:); %põe todos os bits numa coluna
%count_rows=height(binary_matrix); %Computes number of rows in A
%fprintf('Count rows:\n');
%count_rows

[val, idx] = max(net(binary_matrix)); %[valor maior, index]

fprintf('\nLetra lida pela rede neuronal: %s\n', greek_letters(idx));

class = greek_letters(idx);


end

