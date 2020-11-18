function [ Sino_plot ] = Sino(Projection_Images,Background_image_ave)
% stastically remove noise
TotalPhotons = sum(sum(Background_image_ave));
ProPlot = Background_image_ave./TotalPhotons;
CalibPart = Background_image_ave(341:350,341:350);
ProPart = Background_image_ave(341:350,341:350)./TotalPhotons;
Calib_Value_ave = mean(mean(CalibPart));
Pro_ave = mean(mean(ProPart));
for i = 1:size(Projection_Images,3)
    RealPart = Projection_Images(341:350,341:350,i);
    Real_Value_ave = mean(mean(RealPart));
    TotalPhotons = round(Real_Value_ave/Pro_ave);
    I0_plot = round(TotalPhotons*ProPlot);
    Sino_plot(:,:,i) = -log(double(Projection_Images(:,:,i))./I0_plot);
end
end
