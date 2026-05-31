function [GM] = pulse_groundmotion(Vp,Tp)
%PULSE_GROUNDMOTON 此处显示有关此函数的摘要
dt=0.01;
t=0:dt:10;
gamma=2;
v=0.1;
ti=0;
tmax=ti+0.5*gamma*Tp;
tf=tmax+0.5*gamma*Tp;
Dr=Vp.*Tp.*(sin(v+gamma.*pi)-sin(v-gamma.*pi))./(4.*pi*(1-gamma.^2));
vp=(0.5.*Vp.*cos(2.*pi.*(t-tmax)./Tp+v)-Dr./(gamma.*Tp)).*(1+cos(2.*pi.*(t-tmax)./(gamma.*Tp))).*(ti<=t).*(t<=tf);
ap=gradient(vp)./gradient(t);
time=t';
GM=ap';
end

