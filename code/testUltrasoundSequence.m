% your code here

clc;
clear;
close all hidden;

load('../data/usseq.mat');
num=0;

N=size(frames,3);

rect=zeros(4,N);
rect(:,1)=[255 105 310 170]';
figure;

for i=1:N-1
    It=frames(:,:,i);
    It1=frames(:,:,i+1);
    rec=rect(:,i);
    
    [u,v]=LucasKanadeInverseCompositional(It, It1, rec);
    rect(:,i+1)=rect(:,i)+[u v u v]';    
    
    if (i==5|| i==25|| i==50|| i==75)
        num=num+1;
        subplot(2,3,num);
        imshow(frames(:,:,i));
        hold on;
        
        wei=abs(rec(1)-rec(3));
        hei=abs(rec(2)-rec(4));
        rectangle('Position',[rec(1) rec(2) wei hei],'EdgeColor','r','LineWidth',2);
        
        title(['frame=',num2str(i)]);
        hold off;
    end    
    
     if (i==99)
        num=num+1;
        subplot(2,3,num);
        imshow(frames(:,:,i));
        hold on;
        
        wei=abs(rec(1)-rec(3));
        hei=abs(rec(2)-rec(4));
        rectangle('Position',[rec(1) rec(2) wei hei],'EdgeColor','r','LineWidth',2);
        
        title(['frame=',num2str(i+1)]);
        hold off;      
     end    
    
end

rect=rect';
save('usseqrects.mat','rect');