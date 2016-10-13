
hold on;
xlim([0 100])
ylim([25 60])
[Xc,Yc] = do_circle(X,Y,5);
plot(Yc,Xc,'g.');
plot(inters(:,2),inters(:,1),'ro');
plot(Y,X,'bx')


my_circHough(rgb2gray(imread('pic01.png')),10)
my_circHough(rgb2gray(imread('johannes.png')),10,8)
my_circHough(rgb2gray(imread('realFa.png')),3,0)

roi = cutting(image,roi_lt_dwn,roi_rg_up);


