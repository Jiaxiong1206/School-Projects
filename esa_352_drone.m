function esa_352_drone
clc 
[~,~]=graph(@controller, @path);
end

function [ params ] = sys_params()
% sys_params System parameters

params.gravity = 9.81;
params.mass = 0.3;
params.Ixx = 0.00055;
end
function des_state = path(t, ~)

a = zeros(2,1);     %desired ay and az is zero
v = zeros(2,1);     %desired vy and vz is zero 
if t < 1
  yz = zeros(2,1);  %pos= y and z position is at zero
elseif (t>1) && (t<=4)
  yz = [0.0; 1.0];
else 
  yz = [2.0;1.0];
end

des_state.pos = yz;
des_state.vel = v;
des_state.acc = a;

end
function [ u1, u2 ] = controller(~, state, des_state, ~)
params = sys_params;

g=params.gravity;
m=params.mass;
Ixx=params.Ixx;

Kpy=0.7;
Kpz=0.93;
Kdy=1.4;
Kdz=1.25;
Kdphi=9.5;
Kpphi=28.7;
a=des_state.acc;
%%controller equation%%
phi_c=(-1/g)*(a(1)+Kdy*(des_state.vel(1)-state.vel(1))+Kpy*(des_state.pos(1)-state.pos(1)));
u2 = Ixx*(Kdphi*(0-state.omega)+Kpphi*(phi_c-state.rot)); %%phi dot is zero
u1 = m*(g+a(2)+Kdz*(des_state.vel(2)-state.vel(2))+Kpz*(des_state.pos(2)-state.pos(2)));
end
function [ xdot ] = sys_eom(t, x, controller, traj, params)

% State:
% current state x=[y; z; phi; y_dot; z_dot; phi_dot]
 state.pos = x(1:2);
 state.rot = x(3);
 state.vel = x(4:5);
 state.omega = x(6);

des_state = traj(t, state);
[u1, u2] = controller(t, state, des_state, params);

xdot = [x(4);                                       %vy                                               
        x(5);                                       %vz
        x(6);                                       %v_phi
        -u1*sin(x(3))/params.mass;                  %ay
        u1*cos(x(3))/params.mass - params.gravity;  %az
       u2/params.Ixx];                              %a_phi
end
function [t,x] = graph(controller, traj)
params = sys_params;
t=[0 20];                                                               %time span 0-20s
x=[0 0 0 0 0 0];                                                        %initial condition of x

[t, x] = ode45(@(t,x) sys_eom(t, x, controller, traj, params), t, x);   %solve ode
figure(1)

%simulation of the drone
 hold on
 for i=1:length(t)
              plot(x(i,1),x(i,2),'>','linewidth',3)
              hold on 
              plot(x(1:i,1),x(1:i,2),'--','linewidth',3)
              axis([-0.5 2 0 2])
              grid on
              xlabel('y(m)')
              ylabel('z(m)')
              title('simulation')
              pause(0.01)
                       
             if i~=length(t)
                  clf
              end
end
%output response
figure(2)        
subplot(3,1,1);
plot(t,x(:,1))
xlabel('t(s)')
ylabel('y(m)')
title('y output response')
grid on
subplot(3,1,2);
plot(t,x(:,2))
xlabel('t(s)')
ylabel('z(m)')
title('z output response')
grid on
subplot(3,1,3);
plot(t,x(:,3))
xlabel('t(s)')
ylabel('phi(rad)')
title('phi output response')
grid on
end



