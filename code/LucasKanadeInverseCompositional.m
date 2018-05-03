function [u,v] = LucasKanadeInverseCompositional(It, It1, rect)

% input - image at time t, image at t+1, rectangle (top left, bot right coordinates)
% output - movement vector, [u, v] in the x- and y-directions.

% interpolate the image
rect=floor(rect);
[X,Y]=meshgrid(rect(1):rect(3), rect(2):rect(4));

It=im2double(It);
It1=im2double(It1);

It_vq=interp2(It,X,Y);

[It_x,It_y] = gradient(It_vq);
A=[It_x(:) It_y(:)];
H=A'*A;

p=[0 0]';
delta_p=[5 5]';
norm_p=norm(delta_p);
tol=0.02;

while(norm_p>tol)
    [x,y]=meshgrid(rect(1)+p(1):rect(3)+p(1), rect(2)+p(2):rect(4)+p(2));
    It1_vq=interp2(It1,x,y);
    
    b=It1_vq-It_vq;
    delta_p=inv(H)*A'*b(:);
    
    p=p-delta_p;
    norm_p=norm(delta_p);
end

u=p(1); v=p(2);

end

