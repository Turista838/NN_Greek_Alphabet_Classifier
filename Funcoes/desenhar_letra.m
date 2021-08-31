function desenhar_letra()
     
     cd Imagens;
      hold on;
      axis off;
      h = drawfreehand('Closed',false, 'color', 'black', 'FaceAlpha', 0, 'LineWidth', 50, 'MarkerSize', 30, 'InteractionsAllowed', 'none');
      while isvalid(h)
          pause(0.1); 
      end
      cd ..;
end

