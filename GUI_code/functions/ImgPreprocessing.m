function [ Sino_plot, center ] = ImgPreprocessing( Projection_Images, Background_image_ave, thread, axis_x )
% determine location info
numPro = size(Projection_Images,3);
up_boundary=[]; bot_boundary=[];

for i = 1:numPro
    [up_bound,bot_bound] = edgeFind(Projection_Images(:,:,i),thread,axis_x);
    up_boundary(i,:) = up_bound;
    bot_boundary(i,:) = bot_bound;
end
center=(up_boundary+bot_boundary)./2; 
% determine sloping degree, least square method
for i = 1:numPro
p(i,:) = polyfit(axis_x,center(i,:),1);
degree(i) = 180*atan(p(i,1))./pi;       % max(degree) = 0.1721, needs rotation
end

%{  
%show images 
[mp,np]=size(bot_boundary);
xlabel = 1:np;
figure,
 for i = 1:96
 plot(xlabel,bot_boundary(i,:),xlabel,up_boundary(i,:))
 hold on
 end
%}

% transform to Sino_Plots, statistically
Sino_plot = Sino(Projection_Images,Background_image_ave);
Sino_plot(isnan(Sino_plot)) = 0;

Img_Copy = Projection_Images;   % double check accuracy 
for i = 1:numPro
    Sino_plot(:,:,i) = imrotate(Sino_plot(:,:,i),degree(i),'bicubic','crop');
    Img_Copy(:,:,i) = imrotate(Img_Copy(:,:,i),degree(i),'bicubic','crop');
    [up_bound,bot_bound] = edgeFind(Img_Copy(:,:,i),thread,axis_x);
    up_boundary(i,:) = up_bound;
    bot_boundary(i,:) = bot_bound;
end

center=(up_boundary+bot_boundary)./2; % max(abs(degree)) = 0.0226

%{
show Sino_plot Images
figure,
for i = 1:size(Sino_plot,3)
    imagesc(max(Sino_plot(:,:,i),0)); colormap(gray); axis image; axis equal; colorbar;
    title(num2str(i));
    pause(0.01);
end
%}
end

