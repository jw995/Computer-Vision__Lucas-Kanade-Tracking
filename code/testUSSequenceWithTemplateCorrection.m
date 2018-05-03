
clc;
clear;
close all hidden;

load('../data/usseq.mat');
num=0;
N=size(frames,3);

rect=zeros(4,N);
rect1=zeros(4,N);
rect(:,1)=[255 105 310 170]';
rect1(:,1)=[255 105 310 170]';

% record the first frame this time
frame1=frames(:,:,1);
rect_frame1=[255 105 310 170]';

figure;
for i=1:N-1
    It=frames(:,:,i);
    It1=frames(:,:,i+1);
    rec=rect(:,i);
    
    [u,v]=LucasKanadeInverseCompositional(It, It1, rec);
    rect(:,i+1)=rect(:,i)+[u v u v]'; 
    rect1(:,i+1)=rect1(:,i)+[u v u v]'; 
    
    pp=rect(:,i+1)-rect_frame1;
    pp=[pp(1) pp(2)]';
    [u1,v1] = LKWithTemplateCorrection(frame1, It1, rect_frame1, pp);
    
    delta_p=[u1 v1]'-pp-[u v]';
    
    if (norm(delta_p)<10) % threshold
        p_new=[u1 v1]'-pp;
        u_new=p_new(1); 
        v_new=p_new(2);
    else
        u_new=u; v_new=v; 
    end
    
    rect(:,i+1)=rect(:,i)+[u_new v_new u_new v_new]'; 
    
    
    if (i==5|| i==25|| i==50|| i==75|| i==99)
        
        num=num+1;
        subplot(2,3,num);
        imshow(frames(:,:,i));
        hold on;
        
        % origin
        ree1=rect1(:,i);
        wei1=abs(ree1(1)-ree1(3));
        hei1=abs(ree1(2)-ree1(4));
        rectangle('Position',[ree1(1) ree1(2) wei1 hei1],'EdgeColor','g','LineWidth',2);
        hold on;
        
        % with correction
        ree=rect(:,i);
        wei=abs(ree(1)-ree(3));
        hei=abs(ree(2)-ree(4));
        rectangle('Position',[ree(1) ree(2) wei hei],'EdgeColor','r','LineWidth',2);
        hold on;
        
        if (i==99)
        title(['frame=',num2str(i+1)]);
        else 
        title(['frame=',num2str(i)]);
        end
        hold off;
        
    end    
end

rect=rect';
save('usseqrects-wcrt.mat','rect');

