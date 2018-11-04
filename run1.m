%s=loadseries('pa000001/st000001/se000003'); % !
s=loadseries('pa000001/st000001/se000007');
%s=loadseries('pa000001/st000001/se000008'); % !

for i=1:size(s,1),
    image(squeeze(s(i,:,:))/4);
    colormap gray;
%    pause(0.1);
end