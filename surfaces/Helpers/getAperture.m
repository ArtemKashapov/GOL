function ApertureData = getAperture(ApertureType, ApertureData,R_x,R_y)
        if ApertureType==1 %rect

            if ApertureData(1) + ApertureData(3)>abs(R_x)
                ApertureData(1) = abs(R_x);
            end

            if ApertureData(2) + ApertureData(3)>abs(R_y)
                ApertureData(2) = abs(R_y);
            end

        elseif ApertureType==2 %circ
            if ApertureData(1)==0
            d=0;
            else
            d= ApertureData(2)- ApertureData(1);
            end
            if ApertureData(2)>abs(R_x)||ApertureData(2)>abs(R_y)
                ApertureData(2)=min(abs(R_x),abs(R_y));
            end
            if ApertureData(2)-d<0
               ApertureData(1) = 0;
            end
        else
            ApertureData=[0 0 0];
        end
end



