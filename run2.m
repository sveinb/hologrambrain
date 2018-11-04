s=loadseries('pa000001/st000001/se000003'); % 3 or 8
x = (-size(s,1):2:size(s,1)-1)/size(s,2);
y = (-size(s,2)/2:size(s,2)/2-1)/size(s,2);
z = (-size(s,3)/2:size(s,3)/2-1)/size(s,2);
global ss;
ss=griddedInterpolant({x, y, z}, s, 'cubic', 'nearest'); 
