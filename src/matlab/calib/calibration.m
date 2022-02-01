gyro_range=500;gyrox = [];gyroy= [];gyroz=[];acx=[];acy=[];acz=[];
i = 4;
if i == 1;
    fname = 'c261a';
else
    if i == 2
        fname = 'cof19';
    else
        if i == 3
            fname = 'codc4';
        else
            if i == 4
                fname = 'coefb';
            end
        end
    end
end
fn = pwd;
pth = [fn '\calib\' fname '\'];
pos = importdata([pth 'plus_x_acc.csv']);
neg = importdata([pth 'minus_x_acc.csv']);
max1 = mean(pos.data(:,5));
min1 = mean(neg.data(:,5));
gyrox=[gyrox; pos.data(:,8)];
gyrox=[gyrox; neg.data(:,8)];
gyroy=[gyroy; pos.data(:,9)];
gyroy=[gyroy; neg.data(:,9)];
gyroz=[gyroz; pos.data(:,10)];
gyroz=[gyroz; neg.data(:,10)];
midpoint = (max1 + min1)/2 ;
ofx = midpoint - 2048;
tmp1 = max1 - ofx - 2048;
tmp2 = min1 - ofx - 2048;
tmp = tmp1 - tmp2;
sensx = 9.8*2 / tmp;
pos = importdata([pth 'plus_y_acc.csv']);
neg = importdata([pth 'minus_y_acc.csv']);
max1 = mean(pos.data(:,6));
min1 = mean(neg.data(:,6));
midpoint = (max1 + min1)/2 ;
ofy = midpoint - 2048;
tmp1 = max1 - ofy - 2048;
tmp2 = min1 - ofy - 2048;
tmp = tmp1 - tmp2;
sensy = 9.8*2 / tmp;
gyrox=[gyrox; pos.data(:,8)];
gyrox=[gyrox; neg.data(:,8)];
gyroy=[gyroy; pos.data(:,9)];
gyroy=[gyroy; neg.data(:,9)];
gyroz=[gyroz; pos.data(:,10)];
gyroz=[gyroz; neg.data(:,10)];
pos = importdata([pth 'plus_z_acc.csv']);
neg = importdata([pth 'minus_z_acc.csv']);
max1 = mean(pos.data(:,7));
min1 = mean(neg.data(:,7));
midpoint = (max1 + min1)/2 ;
ofz = midpoint - 2048;
tmp1 = max1 - ofz - 2048;
tmp2 = min1 - ofz - 2048;
tmp = tmp1 - tmp2;
sensz = 9.8*2 / tmp;
gyrox=[gyrox; pos.data(:,8)];
gyrox=[gyrox; neg.data(:,8)];
gyroy=[gyroy; pos.data(:,9)];
gyroy=[gyroy; neg.data(:,9)];
gyroz=[gyroz; pos.data(:,10)];
gyroz=[gyroz; neg.data(:,10)];
ofgx =  (mean(gyrox) - 2048);
ofgy =  (mean(gyroy) - 2048);
ofgz =  (mean(gyroz) - 2048);
sensgx = gyro_range/2048;
sensgy = gyro_range/2048;
sensgz = gyro_range/2048;
acc_rawx = pos.data(:,5);
acc_x = (acc_rawx - ofx - 2048)*sensx;
mean_x = mean(acc_x);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
acc_rawy = pos.data(:,6);
acc_y = (acc_rawy - ofy - 2048)*sensy;
mean_y = mean(acc_y);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
acc_rawz = pos.data(:,7);
acc_z = (acc_rawz - ofz - 2048)*sensz;
mean_z =  mean(acc_z);
tot_acc = norm([mean_z mean_x mean_y]);
anx = acosd(mean_x/tot_acc);
any = acosd(mean_y/tot_acc);
anz = acosd(mean_z/tot_acc);
ax = acc_x - tot_acc * cosd(anx);
ay = acc_y - tot_acc * cosd(any);
az = acc_z - tot_acc * cosd(anz);
[rw cl] = size(ax);
axps = [];axmin=[];aymin=[];ayps=[];azps=[];azmin=[];
for i = 1:rw
    if(ax(i)>=0)
        axps(end+1) = ax(i);
    else
        axmin(end+1) = ax(i);
    end
    if(ay(i)>=0)
        ayps(end+1) = ay(i);
    else
        aymin(end+1) = ay(i);
    end
    if(az(i)>=0)
        azps(end+1) = az(i);
    else
        azmin(end+1) = az(i);
    end
end
limpx = mean(axps);limmx=mean(axmin);
limpy = mean(ayps);limmy=mean(aymin);
limpz = mean(azps);limmz=mean(azmin);
gyrox = (gyrox - ofgx - 2048)*sensgx;
gyroy = (gyroy - ofgy - 2048)*sensgy;
gyroz = (gyroz - ofgz - 2048)*sensgz;
[rw cl] = size(gyrox);
gxps=[];gxmin=[];gyps=[];gymin=[];gzps=[];gzmin=[];
for i = 1:rw
    if(gyrox(i)>=0)
        gxps(end+1) = gyrox(i);
    else
        gxmin(end+1) = gyrox(i);
    end
    if(gyroy(i)>=0)
        gyps(end+1) = gyroy(i);
    else
        gymin(end+1) = gyroy(i);
    end
    if(gyroz(i)>=0)
        gzps(end+1) = gyroz(i);
    else
        gzmin(end+1) = gyroz(i);
    end
end
limpgx = mean(gxps);limmgx=mean(gxmin);
limpgy = mean(gyps);limmgy=mean(gymin);
limpgz = mean(gzps);limmgz=mean(gzmin)
save([pth fname '_cal'],'limpgx','limpgy','limpgz','limpx','limpy','limpz','limmgx','limmgy','limmgz','limmx','limmy','limmz','sensx','sensy','sensz','ofx','ofy','ofz','ofgx','ofgy','ofgz','sensgx','sensgy','sensgz');
%offset accel ofx ofy ofz
%gyro ofgx ofgy ofgz
%sensitivity sensx sensy sensz for accel
% sensgx sensgy sensgz for gyro