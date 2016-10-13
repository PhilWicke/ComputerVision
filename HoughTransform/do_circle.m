function [xunit,yunit] = do_circle(x,y,r)

    th = 0:pi/50:2*pi;
    
    xunit = zeros(size(x,1),size(th,2));
    yunit = zeros(size(x,1),size(th,2));
    for IDX = 1:size(x,1)
        xunit(IDX,:) = r * cos(th) + x(IDX);
        yunit(IDX,:) = r * sin(th) + y(IDX);
    end
end