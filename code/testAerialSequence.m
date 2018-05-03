% your code here

clc;
clear;
close all hidden;

load('../data/aerialseq.mat');
num=0;

N=size(frames,3);

figure;
for i=1:N-1
    im1=frames(:,:,i);
    im2=frames(:,:,i+1);
    
    mask = SubtractDominantMotion(im1, im2);
    
    if (i==30|| i==60|| i==90|| i==120)
        num=num+1;
        subplot(2,2,num);
        C=imfuse(im1,mask);
        imshow(C);
       
        title(['frame=',num2str(i)]);
        
    end    
end
