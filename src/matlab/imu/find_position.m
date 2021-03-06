%This function takes the IMU data as the input and returns the plot of x,y,z,theta,phi,psi,u,v,w.
%The data is a 7 coloumn matrix with each row representing a reading of the
%IMU.
%the coloumn should contain the data in the following format:
%col   data
%1     time
%2     Ax
%3     Ay
%4     Az
%5     p(angular rate along x)
%6     q(angular rate along y)
%7     r(angular rate along z)
% Initial is a 3x3 matrix containing initial position and attitude
% [phi theta psi
%  u v w
%  x y z]

function output=find_position(data,initial)
current=initial;
g=9.8;
change=[];
output=[];
format long
for i=1:size(data,1)-1
    change(1,1)=data(i,5)+tan(current(1,2))*(data(i,6)*sin(current(1,1))+data(i,7)*cos(current(1,1)));
    change(1,2)=data(i,6)*cos(current(1,1))-data(i,7)*sin(current(1,1));
    change(1,3)=sec(current(1,2))*(data(i,6)*sin(current(1,1))+data(i,7)*cos(current(1,1)));
    change(2,1)=data(i,2)-data(i,6)*current(2,3)+data(i,7)*current(2,2)-g*sin(current(1,2));
    change(2,2)=data(1,3)-data(i,7)*current(2,1)+data(i,5)*current(2,3)+g*cos(current(1,2))*sin(current(1,1));
    change(2,3)=data(i,4)-data(i,5)*current(2,2)+data(i,6)*current(2,1)+g*cos(current(1,2))*cos(current(1,1));
    change(3,1)=current(2,1)*cos(current(1,2))*cos(current(1,3))+current(2,2)*(sin(current(1,1))*sin(current(1,2))*cos(current(1,3))-cos(current(1,1))*sin(current(1,3)))+current(2,3)*(cos(current(1,1))*sin(current(1,2))*cos(current(1,3))+sin(current(1,1))*sin(current(1,3)));
    change(3,2)=current(2,1)*cos(current(1,2))*sin(current(1,3))+current(2,2)*(sin(current(1,1))*sin(current(1,2))*sin(current(1,3))+cos(current(1,1))*sin(current(1,3)))+current(2,3)*(cos(current(1,1))*sin(current(1,2))*sin(current(1,3))-sin(current(1,1))*cos(current(1,3)));
    change(3,3)=-current(2,1)*sin(current(1,2))+current(2,2)*sin(current(1,1))*cos(current(1,2))+current(2,3)*cos(current(1,1))*cos(current(1,2));
    output(:,:,i)=current;
    current=current+(change*(data(i+1,1)-data(i,1)));
end
plot_trajectory(output);
