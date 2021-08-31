function [net_l, tr_l] = Load_do_net(nom_Fich)
        
    filepath = 'Saves\';

    strT = '.mat';
    nom_Fich = append(nom_Fich, strT);
    
    load(strcat(filepath,nom_Fich));

    net_l = net;
    tr_l = tr;
end

