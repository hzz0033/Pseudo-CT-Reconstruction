img = Projection_Images(:,;,1);

thread = 0.1;
BW = edge(img,'canny',thread);

[H,T,R] = hough(BW);
figure,imshow(H,[],'XData',T,'YData',R,...
            'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;

P  = houghpeaks(H,10,'threshold',ceil(0.3*max(H(:))));
x = T(P(:,2)); y = R(P(:,1));
plot(x,y,'s','color','white');

lines = houghlines(BW,T,R,P,'FillGap',5,'MinLength',7);
figure, imagesc(img),colormap(gray),axis off, hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end

% RANSAC
% figure, imagesc(img),colormap(gray),axis off, hold on   
% plot(150:900,up_bound,'LineWidth',2,'Color','green');
% plot(150:900,bot_bound,'LineWidth',2,'Color','green');
%    % Plot beginnings and ends of lines
% plot(150,up_bound(1),'x','LineWidth',2,'Color','yellow');
% plot(900,up_bound(751),'x','LineWidth',2,'Color','red');
% plot(150,bot_bound(1),'x','LineWidth',2,'Color','yellow');
% plot(900,bot_bound(751),'x','LineWidth',2,'Color','red');
%
 
% re-arrange lines data as input of RANSAC algorithm (point set)
dataset = [];
 for k = 1:length(lines)
     x1 = lines(k).point1(:,1);
     y1 = lines(k).point1(:,2);
     x2 = lines(k).point2(:,1);
     y2 = lines(k).point2(:,2);
     mm = [];
     for j = 1:x2-x1
        mm(j,1) = x1+j;
        mm(j,2) = y1+(y2-y1)/(x2-x1)*j;
     end
     dataset = [dataset;mm];  %(x,y) format
 end

 % HOUGH + RANSAC
 % divide set into two categories: up_bound region and bot_bound_region
 up = [];
 bot = [];
 for k = 1 : size(dataset,1)
     if dataset(k,2) > 512
         bot = [bot;dataset(k,:)];
     else
         up = [up;dataset(k,:)];
     end
 end
up_b = RANSAC(up(:,2)',up(:,1)');   % newY = RANSAC(y,x)
bot_b = RANSAC(bot(:,2)',bot(:,1)');
figure, imagesc(img),colormap(gray),axis off, hold on  
plot(bot(:,1)',bot_b,'LineWidth',2,'Color','green');
plot(up(:,1)',up_b,'LineWidth',2,'Color','green');
 
start = find(bot(:,1) == min(bot(:,1)));
end_p = find(bot(:,1) == max(bot(:,1)));
plot(bot(start,1),bot_b(start),'x','LineWidth',2,'Color','yellow');
plot(bot(end_p,1),bot_b(end_p),'x','LineWidth',2,'Color','red');

start = find(up(:,1) == min(up(:,1)));
end_p = find(up(:,1) == max(up(:,1)));
plot(up(start,1),up_b(start),'x','LineWidth',2,'Color','yellow');
plot(up(end_p,1),up_b(end_p),'x','LineWidth',2,'Color','red');
