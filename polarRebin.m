function pol = polarRebin(images, polData)

if ischar(polData)
    polData = load(polData);
end

numIms = size(images,3);

pol = reshape([polData.overlapVals;polData.overlapVals(reshape(fliplr(reshape(1:end-mod(polData.thBins,2)*polData.rBins,polData.rBins,[])),1,[]),reshape(reshape(1:end,[1,1]*polData.cartBins)',1,end))]*reshape(images,[],numIms),polData.rBins,polData.thBins,numIms);

end