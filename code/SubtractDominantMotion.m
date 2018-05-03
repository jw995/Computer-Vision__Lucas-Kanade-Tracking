function mask = SubtractDominantMotion(image1, image2)

% input - image1 and image2 form the input image pair
% output - mask is a binary image of the same size

% use a threshold of 0.04 for the aerial dataset
% use a threshold of 0.065 for the usseq dataset
threshold=0.04;

im1=im2double(image1);
im2=im2double(image2);

[hei,wei]=size(im1);
[X,Y]=meshgrid(1:wei, 1:hei);
num=length(X(:));
im1_points=[X(:)';Y(:)';ones(1,num)];

M = LucasKanadeAffine(im1, im2);

warp_points=M*im1_points;
warp_x=warp_points(1,:);
warp_y=warp_points(2,:);
im1_warp=interp2(im2,warp_x,warp_y);
im1_warp=reshape(im1_warp,size(im2));

diff=abs(im1-im1_warp);
mask=zeros(size(diff));
mask(find(diff>threshold))=1;

% remove small objects
% use the size 110 for aerial data set
% use the size 110 for usseq data set
mask=bwareaopen(mask,30);

% make scope around moving object
% use the size of 6 for aerial data set
% use the size of 3 for USSeq data set
se=strel('disk',6);
mask=imdilate(mask,se);


end