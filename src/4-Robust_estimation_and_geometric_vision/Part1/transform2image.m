function output = transform2image(input1, input2, H)

transformed = maketform('projective', H);

[img_1,xdata_range,ydata_range]=imtransform(input1,transformed, 'nearest');

xdataout=[min(1,xdata_range(1)) max(size(input2,2),xdata_range(2))];
ydataout=[min(1,ydata_range(1)) max(size(input2,1),ydata_range(2))];

img_1=imtransform(input1,transformed,'nearest','XData',xdataout,'YData',ydataout);
img_2=imtransform(input2,maketform('affine',eye(3)),'nearest','XData',xdataout,'YData',ydataout);

height = size(img_1,1);
width = size(img_1,2);
output = img_1;

for i = 1:numel(img_1)
    if(output(i) == 0)
        output(i) = img_2(i);
    elseif(output(i) ~= 0 && img_2(i) ~= 0)
        output(i) = img_1(i)/2 + img_2(i)/2;
    end
end
end