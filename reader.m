%2D graphic reader

function y = reader(n, x0, xf, y0, yf, RGB)

% read figure (cropped on the line axis) -> all pixels will be stored in a matrix
[A,map]=imread('image.jpg');

[H,L,M] = size(A);

k = 1;
m = 1;

B = zeros(1,2);

% store all pixels with value equal to a specific or range color number.
for i = 1:L
    for j = 1:H
        if( ((A(j,i,1) <= RGB(1,2)) && (A(j,i,1) >= RGB(1,1))) && ((A(j,i,2) <= RGB(2,2)) && ...
            (A(j,i,2) >= RGB(2,1))) && ((A(j,i,3) <= RGB(3,2)) && (A(j,i,3) >= RGB(3,1))) ) %color: [0 0 0]->black, [255 255 255]->white
            B(k+1,1) = i;
            B(k+1,2) = j;
            k = k + 1;
        end
    end
end

[h,l] = size(B);
N = max([0 min([round(n*h/100) h])]);
fprintf('amount of pixels stored: %12i\n',N);

% calculate x and y values to a pixel
for i = 2:h

    if ( mod( i - round(k/(2*N)),round(k/N) ) == 0 )
        C(m,1) = (x0 + (xf-x0)*(B(i,1)-1)/(L-1));
        C(m,2) = yf - (yf-y0)*(B(i,2)-1)/(H-1);
        m = m + 1;
    end

end

% save intermediate pixel among all the pixels belong to a single experimental point.
save('pixel.dat','C','-ascii');
