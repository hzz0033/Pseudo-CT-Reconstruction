function [up_edge_appro,bot_edge_appro] = edgeFind( img2d, thread, axis_x )
% 'canny' edge detect 
up_edge = []; bot_edge = [];

BW = edge(img2d,'canny',thread); % inconsistent edge info
BW = bwareaopen(BW,32); % remove small irrelevant part

% [ B,L ] = bwboundaries(BW,'noholes'); % obtain edge info
[m,n] = size(img2d);
for j= axis_x(1):axis_x(end)
    head = m/4;
    tail = m-m/4;
    while (BW(head,j)==0)
        head = head+1;
    end
    up_edge(j-axis_x(1)+1) = head;
    while (BW(tail,j)==0)
        tail = tail-1;
    end
    bot_edge(j-axis_x(1)+1) = tail;
end

%{
figure, imshow(BW) % show images
hold on
for k = 1:length(B) % depicting edges
boundary = B{k};
plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2),pause(0.1)
end
%}

%{
k = 1;
for i = 1:length(B)
    if length(B{i}) > 2*(size(img2d,2)-2)
        record(k) = i;
        k=k+1;
    end
end
if length(record) == 2
    edge1 = B{record(1)};
    edge2 = B{record(2)];
else 
    error('too many edges, selected manually');
end
%}
    
%{
for i = 1:length(B)
    x(i) = length(B{i});
end
xx = (x == max(x));
posi = find(xx,1);
edge1 = B{posi}; 
x(posi) = 0;
xx = (x == max(x));
posi = find(xx,1);
edge2 = B{posi};

if mean(edge1(:,1)) < mean(edge2(:,1))
    up_edge = edge1;
    bot_edge = edge2;
else
    up_edge = edge2;
    bot_edge = edge1;
end
%}
    
% up_edge_appro = edgeApproxi(up_edge);    % edge approxi
% bot_edge_appro = edgeApproxi(bot_edge);  % edge approxi

up_edge_appro = RANSAC(up_edge, axis_x);    % edge approxi
bot_edge_appro = RANSAC(bot_edge, axis_x);  % edge approxi
end
