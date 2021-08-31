function Guarda_Classificacao(nom_Fich, Fich_Imagem, classificacao)

    cd Saves;
    strT = '.txt';
    nom_Fich = append(nom_Fich, strT);
    fid = fopen( 'fich.txt', 'wt' );
    fprintf( fid, 'Nome do fichiro onde esta a imagem: %s \nImagem obtida: %s', Fich_Imagem, classificacao);
    fclose(fid);
     d = dir ('*txt');
     for i=1:size(d)
         if strcmp(d(i).name,'fich.txt')
          movefile(d(i).name, nom_Fich);
         end
     end
    cd ..;
    
end

