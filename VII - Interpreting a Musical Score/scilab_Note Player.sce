chdir("C:\Users\Marc Castro\Desktop\186");

sheet = imread("old1.png");
sheet = im2bw(sheet,0.2);
scf(); imwrite(sheet, "Thresholded.png");
sheet = imcomplement(sheet);
scf(); imwrite(sheet, "Inverted.png");

SE1 = CreateStructureElement('circle',3);
SE2 = CreateStructureElement('circle',2);
sheet = CloseImage(sheet,SE1);
sheet = OpenImage(sheet,SE2);
scf();imwrite(sheet,"Morphed.png");

Object = SearchBlobs(sheet);
xcent = zeros(1,max(Object));
ycent = zeros(1,max(Object));

for i=1:max(Object)
    [y,x] = find(Object ==i)
    xmean=mean(x)
    ymean=mean(y)
    xcent(i)=xmean
    ycent(i)=ymean
end

C = 261.63; //C = 261.63^2;
D = 293.66; //D = 293.66^2;
E = 329.63; //E = 329.63^2;
F = 349.23; //F = 349.23^2;
G = 392; //G = 392^2;
A = 440; //A = 440^2;
B = 493.88;
C5 = 523.25; //C = 261.63^2;
D5 = 587.33; //D = 293.66^2;
E5 = 659.25; //E = 329.63^2;
F5 = 698.46; //F = 349.23^2;
G5 = 783.99; //G = 392^2;

note = zeros(1,size(ycent,2))
for j=1:size(ycent,2)
    if ycent(1,j)>34 & ycent(1,j)<36
        note(1,j) = C
    end
    if ycent(1,j)>31 & ycent(1,j)<33
        note(1,j) = D
    end
    if ycent(1,j)>28 & ycent(1,j)<30
        note(1,j) = E
    end
    if ycent(1,j)>25 & ycent(1,j)<27
        note(1,j) = F
    end
    if ycent(1,j)>22 & ycent(1,j)<24
        note(1,j) = G
    end
    if ycent(1,j)>19 & ycent(1,j)<21
        note(1,j) = A
    end
    if ycent(1,j)>16 & ycent(1,j)<18
        note(1,j) = B
    end
    if ycent(1,j)>13 & ycent(1,j)<15
        note(1,j) = C5
    end
    if ycent(1,j)>10 & ycent(1,j)<12
        note(1,j) = D5
    end
    if ycent(1,j)>7 & ycent(1,j)<9
        note(1,j) = E5
    end
    if ycent(1,j)>4 & ycent(1,j)<6
        note(1,j) = F5
    end
    if ycent(1,j)>1 & ycent(1,j)<3
        note(1,j) = G5
    end
end

spacing = diff(xcent)
timing=zeros(1,size(xcent,2))
for j=1:size(spacing,2)
    if spacing(j)>60
        timing(j)=4
    end
    if spacing(j)<60
        timing(j)=2
    end
end
timing(1,14)=2

function n = note_function(f,t)
    n = sin(2*%pi*f*linspace(0,t,8192*t));
endfunction

music = []
for i=1:size(note,2)
    music = cat(2,music,note_function(note(1,i),(timing(1,i))))
end
sound(music,8192)
wavwrite(music,"Old1.wav")
