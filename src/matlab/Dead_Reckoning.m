fs = 50;%Sampling Rate
t=1/fs;
%% INITIALIZATION
%N =100;
%N=size(acc,2);
orien = [1 0 0 0];
%offset= 0*[0.4028    0.3500    0];
position = [0 0 0]';
velocity = [0 0 0]';
%% INPUTS
% acc = randn(3,N);
%angular_rate = randn(3,N)*0.02;
acc=accxyz';
%acc=acc(:,60:200);
N=size(acc,2);
angular_rate=gyroxyz'*0;
% g = [0.1386    0.0256    9.7374]';
g = mean(accxyz(3:12,:));
g = g';
tmp = pi/180;
% becomes g = mean of the rest value - [ofx ofy ofz]';
%% Dead Reckoning
pos = position; v = velocity;
for i = 1:N
    wx = tmp*angular_rate(1,i)*t;wy = tmp*angular_rate(1,i)*t;wz = tmp*angular_rate(1,i)*t;
    orien = quatmultiply(orien,angle2quat(wx,wy,wz));
    a = quatrotate(quatinv(orien),(acc(:,i))')' - g;
    for jk = 1:3
        if(abs(a(jk))<=0.22)
            a(jk)=0;
        end
    end
    temp(i,:)=a;
    pos = pos + v *t + 0.5*a*t^2;
    v = v + a * t;
    position(:,i+1) = pos;
end
