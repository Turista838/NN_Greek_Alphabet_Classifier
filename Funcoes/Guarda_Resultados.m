function Guarda_Resultados(nom_Fich, Total, Teste)

    cd Saves;
    strT = '.txt';
    nom_Fich = append(nom_Fich, strT);
    fid = fopen( 'fich.txt', 'wt' );
    fprintf( fid, 'Precisão Total: %0.2f\n\nPrecisão de Teste: %0.2f', Total, Teste);
    fclose(fid);
    d = dir ('*txt');
    for i=1:size(d)
        if strcmp(d(i).name,'fich.txt')
        movefile(d(i).name, nom_Fich);
        end
    end
    cd ..;

end

