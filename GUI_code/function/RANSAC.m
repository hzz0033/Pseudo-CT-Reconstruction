function [ new_edge ] = RANSAC( edge, axis_x )

 number = length(edge); 
 bestParameter1 = 0; 
 bestParameter2 = 0; 
 sigma = 2;
 pretotal = 0;     
 iter = 100;

 for i=1:iter
     
     idx = randperm(number,2);  % x_value
     sample = edge(idx);        % y_value

     %%% y=kx+b
     line = zeros(1,3);
     x = axis_x(idx);
     y = sample;

     k=(y(1)-y(2))/(x(1)-x(2));      
     b = y(1) - k*x(1);
     line = [k -1 b];

     data = [axis_x;edge];
     mask=abs(line*[data; ones(1,size(data,2))]);    
     total=sum(mask<sigma);              %

     if total>pretotal            
         pretotal = total;
         bestline = line;          
    end  
 end
 new_edge = bestline(1)*axis_x+bestline(3);
end