function [seqno timestamp accxyz gyroxyz]=csv_conv(filename,cal_offset)

m=csvread(filename,1,2);
seqno=m(:,1);
timestamp=m(:,2);
accxyz=m(:,3:5);
gyroxyz=m(:,6:8);

of= cal_offset(1,:);
sens= cal_offset(2,:);
ofg= cal_offset(3,:);
sensg= cal_offset(4,:);

accxyz(:,1)=(accxyz(:,1)-of(1)-2048)*sens(1);
accxyz(:,2)=(accxyz(:,2)-of(2)-2048)*sens(2);
accxyz(:,3)=(accxyz(:,3)-of(3)-2048)*sens(3);

gyroxyz(:,1)=(gyroxyz(:,1)-ofg(1)-2048)*sensg(1);
gyroxyz(:,2)=(gyroxyz(:,2)-ofg(2)-2048)*sensg(2);
gyroxyz(:,3)=(gyroxyz(:,3)-ofg(3)-2048)*sensg(3);