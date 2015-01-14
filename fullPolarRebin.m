function pol = fullPolarRebin(image,x0,y0,polData)

sx = size(image,2);
sy = size(image,1);
nimages = size(image,3);

cartBins = polData.cartBins;

image = [zeros(sy,max(0,cartBins-x0),nimages),image(:,max(1,x0+1-cartBins):min(sx,x0-1+cartBins),:),zeros(sy,max(0,cartBins-1-(sx-x0)),nimages)];
image = [zeros(max(0,cartBins-y0),size(image,2),nimages);image(max(1,y0+1-cartBins):min(sy,y0-1+cartBins),:,:);zeros(max(0,cartBins-1-(sy-y0)),size(image,2),nimages)];

pol = [flipdim(polarRebin(foldQuadrant(image,cartBins,cartBins,[1,0,0,0]),polData),2),...
       polarRebin(foldQuadrant(image,cartBins,cartBins,[0,1,0,0]),polData),...
       flipdim(polarRebin(foldQuadrant(image,cartBins,cartBins,[0,0,1,0]),polData),2),...
       polarRebin(foldQuadrant(image,cartBins,cartBins,[0,0,0,1]),polData)];

end