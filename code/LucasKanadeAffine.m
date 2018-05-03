function M = LucasKanadeAffine(It, It1)

% input - image at time t, image at t+1 
% output - M affine transformation matrix

% It=im2double(It);
% It1=im2double(It1);

[hei,wei]=size(It);
[X,Y]=meshgrid(1:wei, 1:hei);
num=length(X(:));
It_points=[X(:)';Y(:)';ones(1,num)];

It_vq=interp2(It,X,Y);
[It_x,It_y]=gradient(It_vq);

%num*6
A=[X(:).*It_x(:)  Y(:).*It_x(:)  It_x(:)...
    X(:).*It_y(:)  Y(:).*It_y(:)  It_y(:)];

p=zeros(6,1);
delta_p=ones(6,1);
norm_p=norm(delta_p);
tol=0.1;

while(norm_p>tol)
    M=[1+p(1) p(2) p(3);
         p(4) 1+p(5) p(6);
          0 0 1];
      
    warp_points=M*It_points;
    warp_x=warp_points(1,:);
    warp_y=warp_points(2,:);
    
    inlier=(warp_x>=1)&(warp_x<=wei)&(warp_y>=1)&(warp_y<=hei);
    A_in=A(inlier,:);
    H=A_in'*A_in;
    
    x=warp_x(:); y=warp_y(:);
    It1_vq=interp2(It1,x,y);
    
    b=It1_vq(:)-It_vq(:);
    b=b(inlier);
    delta_p=inv(H)*A_in'*b;
    
    p=p-delta_p;
    norm_p=norm(delta_p);
end

    M=[1+p(1) p(2) p(3);
         p(4) 1+p(5) p(6);
         0 0 1];
end


