clear; clc; close all

%% Parameters
params.g = 9.81;           
params.rho = 1.225;        
params.CD = 0.1;          
params.r = 0.03;           
params.A = pi*params.r^2;  
params.m = 0.2;            
params.model = 'quadratic';

V0 = 50;                    
theta = deg2rad(35);        

y0 = [0; 0; V0*cos(theta); V0*sin(theta)];

options = odeset('Events',@(t,y) hitGround(t,y),'RelTol',1e-10,'AbsTol',1e-12);


%% Solve with drag
[t_drag,y_drag] = ode45(@(t,y) proj_ode(t,y,params), [0 200], y0, options);
x_drag = y_drag(:,1); y_drag_pos = y_drag(:,2);
y_drag_pos(end) = 0;

%% Solve without drag
T_no_drag = 2*V0*sin(theta)/params.g;
t_nodrag = linspace(0,T_no_drag,length(t_drag));
x_nodrag = V0*cos(theta) * t_nodrag;
y_nodrag = V0*sin(theta)*t_nodrag - 0.5*params.g*t_nodrag.^2;
x_nodrag(end) = V0*cos(theta)*T_no_drag;
y_nodrag(end) = 0;

%% Plot comparison
figure; hold on; grid on; box on;
xlabel('x [m]'); ylabel('y [m]');
title('Projectile trajectory animation: drag vs no-drag');

% Plot the static trajectories first
plot(x_nodrag, y_nodrag, 'r--', 'LineWidth', 1.5);
plot(x_drag, y_drag_pos, 'b-', 'LineWidth', 1.5);
legend('No drag','Quadratic drag');

% --- Add comet animation ---
% Option 1: animate no-drag
figure; hold on; grid on; box on;
xlabel('x [m]'); ylabel('y [m]');
title('Projectile animation');
comet(x_nodrag, y_nodrag);
comet(x_drag, y_drag_pos);

%% ODE function
function dydt = proj_ode(~,y,params)
vx = y(3);
vy = y(4);
v = sqrt(vx^2 + vy^2) + 1e-12;

switch params.model
    case 'quadratic'
        FD = 0.5 * params.rho * params.CD * params.A * v^2;
        ax = - (FD/params.m) * (vx / v);
        ay = - params.g - (FD/params.m) * (vy / v);
    case 'linear'
        c1 = 0.1;
        ax = - (c1/params.m) * vx;
        ay = - params.g - (c1/params.m) * vy;
    case 'none'
        ax = 0;
        ay = -params.g;
    otherwise
        error('Unknown drag model');
end

dydt = [vx; vy; ax; ay];
end

%% Hit the ground function
function [value,isterminal,direction] = hitGround(~,y)
value = y(2);       % y-position
isterminal = 1;     % stop integration
direction = -1;     % only when y decreasing
end
