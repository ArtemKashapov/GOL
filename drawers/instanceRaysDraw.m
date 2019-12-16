function instanceRaysDraw( fig_handler, rays, instance_position, instance_orientation  )
%     R_A_Y_S=rays;
  for i=1:length(instance_position)
        % сперва повернуть r_0 в исходной системе координат
        R_A_Y_S  = rotateRays(rays,instance_orientation(i,:));
        % потом сдвинуть на новую позицию
        R_A_Y_S  = shiftRays( R_A_Y_S,instance_position(i,:));
        
        drawRays(fig_handler, R_A_Y_S);
  end

end

