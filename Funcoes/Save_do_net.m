function Save_do_net(nom_Fich,net, tr)


    cd Saves;
    strT = '.mat';
    nom_Fich = append(nom_Fich, strT);
    
       save fich net tr;
%       save fich ola adeus;
    d = dir ('*.mat');
    for i=1:size(d)
        if strcmp(d(i).name,'fich.mat')
        movefile(d(i).name, nom_Fich);
        end
    end
    cd ..;
    
end




