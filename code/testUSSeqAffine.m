% your code here

clc;
clear;
close all hidden;

load('../data/usseq.mat');
load usseqrects-wcrt.mat;
num=0;

N=size(frames,3);
rect=floor(rect);

figure;
for i=1:N-1
    im1=frames(:,:,i);
    im2=frames(:,:,i+1);
    
    mask = SubtractDominantMotion(im1, im2);
    frame_rect=rect(i,:);
    x1=frame_rect(1); y1=frame_rect(2);
    x2=frame_rect(3); y2=frame_rect(4);
    
    % generate another mask to only process the points inside the the rect
    mask1=zeros(size(mask));
    mask1(y1:y2, x1:x2)=1;
    mask=mask.*mask1;
    
    if (i==5|| i==25|| i==50|| i==75)
        num=num+1;
        subplot(2,3,num);
        C=imfuse(im1,mask);
        imshow(C);
       
        title(['frame=',num2str(i)]);
    end    
    
     if (i==99)
        num=num+1;
        subplot(2,3,num);

        C=imfuse(im1,mask);
        imshow(C);
       
        title(['frame=',num2str(i+1)]);
     end    
     
end