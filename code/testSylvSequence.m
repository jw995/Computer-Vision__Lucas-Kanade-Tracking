% your code here
clc;
clear;
close all hidden;

load('../data/sylvseq.mat');
load('../data/sylvbases.mat');
num=0;

N=size(frames,3);

rect=zeros(4,N);
rect1=zeros(4,N);
rect(:,1)=[102 62 156 108]';
rect1(:,1)=[102 62 156 108]';
figure;

for i=1:N-1
    It=frames(:,:,i);
    It1=frames(:,:,i+1);
    rec=rect(:,i);
    rec1=rect1(:,i);
    
    [u,v]=LucasKanadeBasis(It, It1, rec, bases);
    rect(:,i+1)=rect(:,i)+[u v u v]';    
    
    [u1,v1]=LucasKanadeInverseCompositional(It, It1, rec1);
    rect1(:,i+1)=rect1(:,i)+[u1 v1 u1 v1]';    
    
    if (i==1|| i==100|| i==200|| i==300|| i==350|| i==400)
        num=num+1;
        subplot(2,3,num);
        imshow(frames(:,:,i));
        hold on;
        
        wei=abs(rec(1)-rec(3));  wei1=abs(rec1(1)-rec1(3));
        hei=abs(rec(2)-rec(4));  hei1=abs(rec1(2)-rec1(4));
        rectangle('Position',[rec(1) rec(2) wei hei],'EdgeColor','r','LineWidth',2);hold on;
        rectangle('Position',[rec1(1) rec1(2) wei1 hei1],'EdgeColor','g','LineWidth',2);
        
        title(['frame=',num2str(i)]);
        hold off;
        
    end    
end

rect=rect';
save('sylvseqrects.mat','rect');