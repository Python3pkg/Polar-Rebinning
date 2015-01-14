function polData = polarRebinIntegrals(polData)

cartBins = polData.cartBins;
rBins = polData.rBins;
thBins = polData.thBins;

rMax = cartBins-0.5; % Maximum radius of polar image
dr = rMax/rBins; % Radius increment
dt = pi/2/thBins; % Angular increment
thBins_red = ceil(thBins/2); 
comp_mat = [];
sub_thBins_red = ceil(thBins_red/4);

progStep = 1;
progBar = ParforProgMon('Polar Integrals Progress:', rBins*thBins_red, progStep, 400, 70);

spmd
    for tind = 1+(labindex-1)*sub_thBins_red:min(labindex*sub_thBins_red,thBins_red)
        t = dt*(tind-1);
        for rind = 1:rBins
            r = dr*(rind-1);
            for x = ceil(r*cos(t+dt)+0.5):min(cartBins,floor((r+dr)*cos(t)+1.5))
                for y = ceil(r*sin(t)+0.5):min(cartBins,floor((r+dr)*sin(t+dt)+1.5))
                    if sqrt((x-0.5)^2+(y-0.5)^2)>r&&sqrt(max(x-1.5,0)^2+max(y-1.5,0)^2)<r+dr&&atan2(y-0.5,x-1.5)>t&&atan2(y-1.5,x-0.5)<t+dt
                        int = overlapIntegral(x,y,r,dr,t,dt);
                        if int>0
                            comp_mat(end+1,:) = [sub2ind([rBins,thBins_red],rind,tind),sub2ind([cartBins,cartBins],x,y), int];
                        end
                    end
                end
            end
            progBar.increment();
        end
    end
end

progBar.delete();

comp_mat = [comp_mat{1};comp_mat{2};comp_mat{3};comp_mat{4}];
polData.overlapVals = sparse(comp_mat(:,1),comp_mat(:,2),comp_mat(:,3),thBins_red*rBins,cartBins^2);

end