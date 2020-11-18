function [ edge ] = edgeApproxi( edge )
%{
exp_start_pos = max(x(1),edge(1,2));
xx = (edge(:,2) == exp_start_pos);
start_posi = find(xx,1,'first');
exp_end_pos = min(x(end),max(edge(:,2)));
xx = (edge(:,2) == exp_end_pos);
end_posi = find(xx,1,'first');

X_axis = edge(start_posi:end_posi,2);
Y_value = edge(start_posi:end_posi,1);
%}

% p = polyfit(x,edge,1);
% y = polyval(p,x);

j=[]; k=[];
uniValue = unique(edge);
num = histc(edge,uniValue);
[x,y] = max(num);
CommonValue = uniValue(y);
    for j = 1:length(uniValue)
        if num(j)<200 && abs(uniValue(j)-CommonValue)>10  % inconsistent point
            maskValue = (edge == uniValue(j));
            k = find(maskValue,1,'first');
            if k == 1
               edge(maskValue) = CommonValue;
            else
               edge(maskValue) = edge(k-1);
            end    
        end
    end
    
end