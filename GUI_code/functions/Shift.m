function [ SinoPl ] = Shift( Sino_plot, center )
[m,n,num] = size(Sino_plot);
ds = floor((m-1)/2);
for i = 1:num
    center_info = round(mean(center(i,:)));
    if 2*center_info > m
        d = round(2*center_info - m);
        s = [Sino_plot(:,:,i);zeros(d,n)];
        SinoPl(:,:,i) = s(center_info-ds:center_info+ds,:);
    else
        d = round(m - 2*center_info);
        s = [zeros(d,n);Sino_plot(:,:,i)];
        SinoPl(:,:,i) = s(center_info+d-ds:center_info+d+ds,:);
    end
end

%{
show result images
figure,
for i = 1:96
    imagesc(SinoPl(:,:,i),[0,1.2]),colormap(gray)
    title(num2str(i))
    pause(0.5)
%}
end