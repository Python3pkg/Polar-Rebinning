function area = overlapIntegral(x,y,r,dr,t,dt)

tmin = max(t,atan2(y-1.5,x-0.5));
tmax = min(t+dt,atan2(y-0.5,x-1.5));

rout = @(th) min(r+dr,min((x-0.5)./cos(th),(y-0.5)./sin(th)));
rin = @(th) max(r,max((x-1.5)./cos(th),(y-1.5)./sin(th)));

area = 1/2.*arrayfun(@(minTh,maxTh)integral(@(th)max(rout(th).^2-rin(th).^2,0),minTh,maxTh),tmin,tmax);

end