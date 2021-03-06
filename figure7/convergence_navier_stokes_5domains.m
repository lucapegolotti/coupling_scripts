clc
clear all
close all

% define exact solution and boundary conditions
u1ex = @(x) sin(x(2,:)*pi);
u2ex = @(x) exp(x(1,:));
pex = @(x) -0.5*x(1,:).^2;

u1exdx = @(x) 0;
u1exdy = @(x) pi*cos(x(2,:)*pi);
u1exdxdx = @(x) 0;
u1exdydy = @(x) -pi^2*sin(x(2,:)*pi);

u2exdx = @(x) exp(x(1,:));
u2exdy = @(x) 0;
u2exdxdx = @(x) exp(x(1,:));
u2exdydy = @(x) 0;

graduex = @(x) [u1exdx(x) u1exdy(x);u2exdx(x) u2exdy(x)];

pexdx = @(x) -x(1,:);
pexdy = @(x) 0;

mu = 1;
fun = @(x) [-mu*(u1exdxdx(x)+u1exdydy(x)) + u1ex(x).*u1exdx(x) + u2ex(x).*u1exdy(x) + pexdx(x);
    -mu*(u2exdxdx(x)+u2exdydy(x)) + u1ex(x).*u2exdx(x) + u2ex(x).*u2exdy(x) + pexdy(x)];

dirichlet_functions = @(x) [u1ex(x).*(x(2,:)==0) u2ex(x).*(x(2,:)==0);
    u1ex(x).*(x(1,:)==1) u2ex(x).*(x(1,:)==1);
    u1ex(x).*(x(2,:)==1) u2ex(x).*(x(2,:)==1);
    u1ex(x).*(x(1,:)==0) u2ex(x).*(x(1,:)==0)]';
neumann_functions = @(x) [(mu*graduex(x)*[0;-1]-pex(x)*[0;-1])*(x(2,:)==0), ...
    (mu*graduex(x)*[1;0]-pex(x)*[1;0])*(x(1,:)==1), ...
    (mu*graduex(x)*[0;1]-pex(x)*[0;1])*(x(2,:)==1), ...
    (mu*graduex(x)*[-1;0]-pex(x)*[-1;0])*(x(1,:)==0)];

% number of elements for omega 1 in the x direction
n_elementsx = [16 23 32 44 64 91 128];

h = 1./n_elementsx;
errH1u = [];
errL2p = [];
err = [];

xline1 = 0.15;
yline1 = 0.15;

xline2 = 0.7;
yline2 = 0.35;

for nx = n_elementsx
    % create the mesh and fespaces for domain 1
    clear sol;
    xp1 = 0;
    yp1 = yline2;
    L1 = 1;
    H1 = 1-yline2;
    
    n1x = nx;
    n1y = round(n1x*H1);
    mesh1 = create_mesh(xp1,yp1,L1,H1,n1x,n1y);
    
    h_coarse = L1/n1x;
    
    bc_flags = [0 0 1 1];
    fespace1_u = create_fespace(mesh1,'P2',bc_flags);
    fespace1_p = create_fespace(mesh1,'P1',bc_flags);
    
    % create the mesh and fespaces for domain 2
    xp2 = xline2;
    yp2 = 0;
    L2 = 1-xline2;
    H2 = yline2;
    
    n2x = round(L2/h_coarse*2);
    n2y = round(H2/h_coarse*2);
    mesh2 = create_mesh(xp2,yp2,L2,H2,n2x,n2y);
    
    bc_flags = [1 0 0 0];
    fespace2_u = create_fespace(mesh2,'P2',bc_flags);
    fespace2_p = create_fespace(mesh2,'P1',bc_flags);
    
    % create the mesh and fespaces for domain 3
    xp3 = xline1;
    yp3 = 0;
    L3 = 1-xline1-L2;
    H3 = yline2;
    
    n3x = ceil(L3/h_coarse);
    n3y = ceil(H3/h_coarse);
    mesh3 = create_mesh(xp3,yp3,L3,H3,n3x,n3y);
    
    bc_flags = [1 0 0 0];
    fespace3_u = create_fespace(mesh3,'P2',bc_flags);
    fespace3_p = create_fespace(mesh3,'P1',bc_flags);
    
    % create the mesh and fespaces for domain 4
    xp4 = 0;
    yp4 = 0;
    L4 = xline1;
    H4 = yline1;
    
    n4x = round(L4/h_coarse*2);
    n4y = round(H4/h_coarse*2);
    mesh4 = create_mesh(xp4,yp4,L4,H4,n4x,n4y);
    
    bc_flags = [1 0 0 1];
    fespace4_u = create_fespace(mesh4,'P2',bc_flags);
    fespace4_p = create_fespace(mesh4,'P1',bc_flags);
    
    % create the mesh and fespaces for domain 5
    xp5 = 0;
    yp5 = yline1;
    L5 = xline1;
    H5 = 1-yline1-H1;
    
    n5x = ceil(L5/h_coarse);
    n5y = ceil(H5/h_coarse);
    mesh5 = create_mesh(xp5,yp5,L5,H5,n5x,n5y);
    
    bc_flags = [0 0 0 1];
    fespace5_u = create_fespace(mesh5,'P2',bc_flags);
    fespace5_p = create_fespace(mesh5,'P1',bc_flags);
    
    fespaces_u = {fespace1_u,fespace2_u,fespace3_u,fespace4_u,fespace5_u};
    fespaces_p = {fespace1_p,fespace2_p,fespace3_p,fespace4_p,fespace5_p};
    
    % each row of this matrix correspond to one interface
    % The (i,j) element of the matrix is 0 if the jth domain
    % does not include the ith interface; otherwise, it 
    % is equal to the boundary index of the domain (1 bottom boundary,
    % 2 right boundary, 3 top boundary, 4 left boundary).
    domain_connectivity = [1 3 3 0 3; 
                           0 4 2 0 0; 
                           0 0 4 2 2; 
                           0 0 0 3 1];
                     
    normals = [-1 0 0 0; 
                0 0 1 1; 
                0 -1 1 -1; 
                0 1 -1 0; 
                1 1 1 0];
    
    gausspoints = 4;
    typebasisfunctions = 'fourier';
    
    % number of basis functions for each interface.
    % Note: for fourier basis functions, the actual number of basis
    % functions for each component of the normal stress is (2*n-1) the 
    % values in this array.
    nbasisfunctions = [6 5 5 4];
    [mat,rhs,jac,nsys,nus,nps,indices] = build_coupled_system_navier_stokes(fespaces_u, ...
        fespaces_p,fun,mu,dirichlet_functions,neumann_functions,domain_connectivity, ...
        normals,nbasisfunctions,gausspoints,typebasisfunctions);
    
    % solve system with newton's method
    f = @(u) mat(u)*u-rhs;
    
    x0 = zeros(nsys,1);
    tol = 1e-10;
    maxit = 20;
    
    [sol,er,it] = solve_with_newtons_method(f,x0,jac,tol,maxit);
    
    % split global solution into 5 local solutions
    [sols,lm] = split_solutions(sol,fespaces_u,fespaces_p,nus,nps,indices);
    
    % plot solutions and compute errors
    
    figure(1)
    errsu = zeros(5,1);
    errsp = zeros(5,1);
    for i = 1:5
        plot_fe_fluid_function(sols{i},'U',[1 3]);
        hold on
        errsu(i) = compute_H1_error_velocity(fespaces_u{i},sols{i},@(x) [u1ex(x);u2ex(x)],@(x) [u1exdx(x) u1exdy(x); ...
            u2exdx(x) u2exdy(x)]);
        errsp(i) = compute_L2_error(fespaces_p{i},sols{i}.p,pex);
    end
    axis([0 1 0 1])
    axis square
    hold off
    pause(0.1)
    
    errs = errsu + errsp;
    
    err = [err; sqrt(errs'*errs)];
end
save('data_figure7/err','err')
save('data_figure7/h','h')

