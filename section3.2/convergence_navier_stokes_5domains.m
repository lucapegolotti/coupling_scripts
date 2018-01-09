clear all
close all
clc

% author: Luca Pegolotti on 11/12/2017

set = 3;

if (set == 1)
    U = 1;
    u1ex = @(x) U*sin(x(2,:)*pi);
    u2ex = @(x) 0*x(2,:).^0;
    pex = @(x) -pi^2*U*sin(x(2,:)*pi).*x(1,:);
    
    u1exdx = @(x) 0*x(2,:).^0;
    u1exdy = @(x) pi*U*cos(x(2,:)*pi);
    u1exdxdx = @(x) 0*x(2,:).^0;
    u1exdydy = @(x) -pi^2*U*sin(x(2,:)*pi);
    
    u2exdx = @(x) 0*x(2,:).^0;
    u2exdy = @(x) 0*x(2,:).^0;
    u2exdxdx = @(x) 0*x(2,:).^0;
    u2exdydy = @(x) 0*x(2,:).^0;
    
    graduex = @(x) [u1exdx(x) u1exdy(x);u2exdx(x) u2exdy(x)];
    
    pexdx = @(x)  -pi^2*U*sin(x(2,:)*pi);
    pexdy = @(x)  -pi^3*U*cos(x(2,:)*pi).*x(1,:);
    
    mu = 1;
    nu = mu;
    fun = @(x) [-mu*(u1exdxdx(x)+u1exdydy(x)) + u1ex(x).*u1exdx(x) + u2ex(x).*u1exdy(x) + pexdx(x);
        -mu*(u2exdxdx(x)+u2exdydy(x)) + u1ex(x).*u2exdx(x) + u2ex(x).*u2exdy(x) + pexdy(x)];
    
    dirichlet_functions = @(x) [u1ex(x).*(x(2,:)==0) u2ex(x).*(x(2,:)==0);
        u1ex(x).*(x(1,:)==1) u2ex(x).*(x(1,:)==1);
        u1ex(x).*(x(2,:)==1) u2ex(x).*(x(2,:)==1);
        u1ex(x).*(x(1,:)==0) u2ex(x).*(x(1,:)==0)]';
    neumann_functions = @(x) [(mu*graduex(x)*[0;-1]-pex(x)*[0;-1]).*(x(2,:)==0), ...
        (mu*graduex(x).*[1;0]-pex(x)*[1;0]).*(x(1,:)==1), ...
        (mu*graduex(x).*[0;1]-pex(x)*[0;1]).*(x(2,:)==1), ...
        (mu*graduex(x).*[-1;0]-pex(x)*[-1;0]).*(x(1,:)==0)];
elseif (set == 2)
    U = 1;
    u1ex = @(x) 0*x(2,:).^0;
    u2ex = @(x) U*sin(x(1,:)*pi);
    pex = @(x) -pi^2*U*sin(x(1,:)*pi).*x(2,:);
    
    u1exdx = @(x) 0*x(2,:).^0;
    u1exdy = @(x) 0*x(2,:).^0;
    u1exdxdx = @(x) 0*x(2,:).^0;
    u1exdydy = @(x) 0*x(2,:).^0;
    
    u2exdx = @(x) pi*U*cos(x(1,:)*pi);
    u2exdy = @(x) 0*x(2,:).^0;
    u2exdxdx = @(x) -pi^2*U*sin(x(1,:)*pi);
    u2exdydy = @(x) 0*x(2,:).^0;
    
    graduex = @(x) [u1exdx(x) u1exdy(x);u2exdx(x) u2exdy(x)];
    
    pexdx = @(x)  -pi^3*U*cos(x(1,:)*pi).*x(2,:);
    pexdy = @(x)  -pi^2*U*sin(x(1,:)*pi);
    
    mu = 1;
    nu = mu;
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
elseif (set == 3)
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
    nu = mu;
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
    
elseif (set == 4)
    U = 1;
    u1ex = @(x) U*sin(x(2,:)*pi);
    u2ex = @(x) U*sin(x(1,:)*pi);
    pex = @(x) -pi^2*U*sin(x(2,:)*pi).*x(1,:)-pi^2*U*sin(x(1,:)*pi).*x(2,:);
    
    u1exdx = @(x) 0*x(2,:).^0;
    u1exdy = @(x) pi*U*cos(x(2,:)*pi);
    u1exdxdx = @(x) 0*x(2,:).^0;
    u1exdydy = @(x) -pi^2*U*sin(x(2,:)*pi);
    
    u2exdx = @(x) pi*U*cos(x(1,:)*pi);
    u2exdy = @(x) 0*x(2,:).^0;
    u2exdxdx = @(x) -pi^2*U*sin(x(1,:)*pi);
    u2exdydy = @(x) 0*x(2,:).^0;
    
    graduex = @(x) [u1exdx(x) u1exdy(x);u2exdx(x) u2exdy(x)];
    
    pexdx = @(x)  -pi^2*U*sin(x(2,:)*pi)-pi^3*U*cos(x(1,:)*pi).*x(2,:);
    pexdy = @(x)  -pi^3*U*cos(x(2,:)*pi).*x(1,:)-pi^2*U*sin(x(1,:)*pi);
    
    mu = 1;
    nu = mu;
    fun = @(x) [-mu*(u1exdxdx(x)+u1exdydy(x)) + u1ex(x).*u1exdx(x) + u2ex(x).*u1exdy(x) + pexdx(x);
                -mu*(u2exdxdx(x)+u2exdydy(x)) + u1ex(x).*u2exdx(x) + u2ex(x).*u2exdy(x) + pexdy(x)];
    
    dirichlet_functions = @(x) [u1ex(x).*(x(2,:)==0) u2ex(x).*(x(2,:)==0);
        u1ex(x).*(x(1,:)==1) u2ex(x).*(x(1,:)==1);
        u1ex(x).*(x(2,:)==1) u2ex(x).*(x(2,:)==1);
        u1ex(x).*(x(1,:)==0) u2ex(x).*(x(1,:)==0)]';
    neumann_functions = @(x) [(mu*graduex(x)*[0;-1]-pex(x)*[0;-1]).*(x(2,:)==0), ...
        (mu*graduex(x)*[1;0]-pex(x)*[1;0]).*(x(1,:)==1), ...
        (mu*graduex(x)*[0;1]-pex(x)*[0;1]).*(x(2,:)==1), ...
        (mu*graduex(x)*[-1;0]-pex(x)*[-1;0]).*(x(1,:)==0)];
end
n_elementsx = [16 32 64 128];%128];

h = 1./n_elementsx;
errH1u = [];
errL2p = [];
err = [];

xline1 = 0.3;
yline1 = 0.2;

xline2 = 0.6;
yline2 = 0.4;

for nx = n_elementsx
    % create the mesh and fespaces for domain 1
    xp1 = 0;
    yp1 = yline2;
    L1 = 1;
    H1 = 1-yline2;
    
    n1x = nx;
    n1y = floor(n1x*H1);
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
    
    n2x = nx/2;
    n2y = nx/2;
    mesh2 = create_mesh(xp2,yp2,L2,H2,n2x,n2y);
    
    bc_flags = [1 0 0 0];
    fespace2_u = create_fespace(mesh2,'P2',bc_flags);
    fespace2_p = create_fespace(mesh2,'P1',bc_flags);
    
    % create the mesh and fespaces for domain 3
    xp3 = xline1;
    yp3 = 0;
    L3 = 1-xline1-L2;
    H3 = yline2;
    
    n3x = nx/2;
    n3y = floor(nx/2*0.9);
    mesh3 = create_mesh(xp3,yp3,L3,H3,n3x,n3y);
    
    bc_flags = [1 0 0 0];
    fespace3_u = create_fespace(mesh3,'P2',bc_flags);
    fespace3_p = create_fespace(mesh3,'P1',bc_flags);
    
    % create the mesh and fespaces for domain 4
    xp4 = 0;
    yp4 = 0;
    L4 = xline1;
    H4 = yline1;
    
    n4x = floor(nx/2*0.9);
    n4y = nx/2;
    mesh4 = create_mesh(xp4,yp4,L4,H4,n4x,n4y);
    
    bc_flags = [1 0 0 1];
    fespace4_u = create_fespace(mesh4,'P2',bc_flags);
    fespace4_p = create_fespace(mesh4,'P1',bc_flags);
    
    % create the mesh and fespaces for domain 5
    xp5 = 0;
    yp5 = yline1;
    L5 = xline1;
    H5 = 1-yline1-H1;
    
    n5x = nx/2;
    n5y = nx/2;
    mesh5 = create_mesh(xp5,yp5,L5,H5,n5x,n5y);
    
    bc_flags = [0 0 0 1];
    fespace5_u = create_fespace(mesh5,'P2',bc_flags);
    fespace5_p = create_fespace(mesh5,'P1',bc_flags);
    
    draw_multimesh({mesh1, mesh2, mesh3, mesh4, mesh5})
    pause();
    
    
    fespaces_u = {fespace1_u,fespace2_u,fespace3_u,fespace4_u,fespace5_u};
    fespaces_p = {fespace1_p,fespace2_p,fespace3_p,fespace4_p,fespace5_p};
    
    % store number of degrees of freedom for one component of the velocity
    n1u = size(fespace1_u.nodes,1);
    n2u = size(fespace2_u.nodes,1);
    n3u = size(fespace3_u.nodes,1);
    n4u = size(fespace4_u.nodes,1);
    n5u = size(fespace5_u.nodes,1);

    
    % store number of degrees of freedom for the pressure
    n1p = size(fespace1_p.nodes,1);
    n2p = size(fespace2_p.nodes,1);
    n3p = size(fespace3_p.nodes,1);
    n4p = size(fespace4_p.nodes,1);
    n5p = size(fespace5_p.nodes,1);

    n1 = 2*n1u+n1p;
    n2 = 2*n2u+n2p;
    n3 = 2*n3u+n3p;
    n4 = 2*n4u+n4p;
    n5 = 2*n5u+n5p;
 
    indices1 = 1:n1;
    indices2 = n1+1:n1+n2;
    indices3 = n1+n2+1:n1+n2+n3;
    indices4 = n1+n2+n3+1:n1+n2+n3+n4;
    indices5 = n1+n2+n3+n4+1:n1+n2+n3+n4+n5;
    
    % build matrices and righ handsides for the 5 domains
    [A1,rhs1] = assembler_steady_navier_stokes(fespace1_u,fespace1_p,fun,nu,dirichlet_functions,neumann_functions);
    [A2,rhs2] = assembler_steady_navier_stokes(fespace2_u,fespace2_p,fun,nu,dirichlet_functions,neumann_functions);
    [A3,rhs3] = assembler_steady_navier_stokes(fespace3_u,fespace3_p,fun,nu,dirichlet_functions,neumann_functions);
    [A4,rhs4] = assembler_steady_navier_stokes(fespace4_u,fespace4_p,fun,nu,dirichlet_functions,neumann_functions);
    [A5,rhs5] = assembler_steady_navier_stokes(fespace5_u,fespace5_p,fun,nu,dirichlet_functions,neumann_functions);
    
    A = @(u) blkdiag(A1(u(indices1)),A2(u(indices2)),A3(u(indices3)),A4(u(indices4)),A5(u(indices5)));
    
    sol_appr = zeros(n1+n2+n3+n4+n5,1);
    sollm = [];
    
    errsL2u = [];
    
    bcs_flags = [-1 0 0 0; 0 0 1 1; 0 -1 1 1;0 -1 1 0;-1 -1 1 0]';
    
    bfs1 = {};
    bfs2 = {};
    
    B = [];
    B_t = [];
    
    gausspoints = 4;
    
    for n_itx = 0:10
        %bf = @(x) legendreP(n_itx,(x(1)-0.5)*2);
        bf = @(x) x(1,:).^(n_itx);

        %bf = @(x) cos(x(1)*pi*n_itx);
        [B1,B1_t] = couple_navier_stokes_solutions_single_basis_xpar(fespaces_u,fespaces_p,bcs_flags,bf,gausspoints);
        B = [B;B1];
        B_t = [B_t B1_t];
        bfs1{end+1} = bf;
        
%         if (n_itx ~= 0)
%             bf = @(x) sin(x(1)*pi*n_itx);
%             [B1,B1_t] = couple_navier_stokes_solutions_single_basis_xpar(fespaces_u,fespaces_p,bcs_flags,bf,gausspoints);
%             B = [B;B1];
%             B_t = [B_t B1_t];
%         end
    end
    
    for n_ity = 0:10
        %bf = @(x) legendreP(n_ity,(x(2)-0.5)*2);
        bf = @(x) x(2,:).^(n_ity);
        %bf = @(x) cos(x(2)*pi*n_ity);
        [B1,B1_t] = couple_navier_stokes_solutions_single_basis_ypar(fespaces_u,fespaces_p,bcs_flags,bf,gausspoints);
        B = [B;B1];
        B_t = [B_t B1_t];
        bfs2{end+1} = bf;
        
%         if (n_itx ~= 0)
%             bf = @(x) sin(x(2)*pi*n_ity);
%             [B1,B1_t] = couple_navier_stokes_solutions_single_basis_ypar(fespaces_u,fespaces_p,bcs_flags,bf,gausspoints);
%             B = [B;B1];
%             B_t = [B_t B1_t];
%         end
    end
   
    totalagmul = size(B,1);
    zerosp = sparse(totalagmul,totalagmul);
    mat = @(u) [A(u) B_t; B zerosp];
    
    zeroslg = zeros(totalagmul,1);
    
    % solve system with newton's method
    f = @(u) mat(u)*u-[rhs1;rhs2;rhs3;rhs4;rhs5;zeroslg];
    x0 = [sol_appr; zeros(totalagmul-size(sollm,1),1)];
    jac = @(u) [blkdiag(build_jac_navier_stokes(A1,u(indices1),fespace1_u), ...
        build_jac_navier_stokes(A2,u(indices2),fespace2_u), ...
        build_jac_navier_stokes(A3,u(indices3),fespace3_u), ...
        build_jac_navier_stokes(A4,u(indices4),fespace4_u), ...
        build_jac_navier_stokes(A5,u(indices5),fespace5_u)), B_t;
        B zerosp];
    tol = 1e-10;
    maxit = 20;
    
    [sol_apr,er,it] = solve_with_newtons_method(f,x0,jac,tol,maxit);
    
    sol1 = real(sol_apr(indices1));
    sol2 = real(sol_apr(indices2));
    sol3 = real(sol_apr(indices3));
    sol4 = real(sol_apr(indices4));
    sol5 = real(sol_apr(indices5));

    solm = sol_apr(n1+n2+n3+n4+n5+1:end);
    
    solstr1.u1 = sol1(1:n1u);
    solstr1.u2 = sol1(n1u+1:n1u*2);
    solstr1.p  = sol1(2*n1u+1:end);
    solstr1.fespace_u = fespace1_u;
    solstr1.fespace_p = fespace1_p;
    
    solstr2.u1 = sol2(1:n2u);
    solstr2.u2 = sol2(n2u+1:n2u*2);
    solstr2.p  = sol2(2*n2u+1:end);
    solstr2.fespace_u = fespace2_u;
    solstr2.fespace_p = fespace2_p;
    
    solstr3.u1 = sol3(1:n3u);
    solstr3.u2 = sol3(n3u+1:n3u*2);
    solstr3.p  = sol3(2*n3u+1:end);
    solstr3.fespace_u = fespace3_u;
    solstr3.fespace_p = fespace3_p;
    
    solstr4.u1 = sol4(1:n4u);
    solstr4.u2 = sol4(n4u+1:n4u*2);
    solstr4.p  = sol4(2*n4u+1:end);
    solstr4.fespace_u = fespace4_u;
    solstr4.fespace_p = fespace4_p;
    
    solstr5.u1 = sol5(1:n5u);
    solstr5.u2 = sol5(n5u+1:n5u*2);
    solstr5.p  = sol5(2*n5u+1:end);
    solstr5.fespace_u = fespace5_u;
    solstr5.fespace_p = fespace5_p;
    
    figure(1)
    close all
    plot_fe_fluid_function(solstr1,'U');
    hold on
    plot_fe_fluid_function(solstr2,'U');
    plot_fe_fluid_function(solstr3,'U');
    plot_fe_fluid_function(solstr4,'U');
    plot_fe_fluid_function(solstr5,'U');

    axis([0 1 0 1])
    pause(0.01)
    hold off
   
    
    err1 = compute_H1_error_velocity(fespace1_u,solstr1,@(x) [u1ex(x);u2ex(x)],@(x) [u1exdx(x) u1exdy(x); ...
        u2exdx(x) u2exdy(x)]);
    err2 = compute_H1_error_velocity(fespace2_u,solstr2,@(x) [u1ex(x);u2ex(x)],@(x) [u1exdx(x) u1exdy(x); ...
        u2exdx(x) u2exdy(x)]);
    err3 = compute_H1_error_velocity(fespace3_u,solstr3,@(x) [u1ex(x);u2ex(x)],@(x) [u1exdx(x) u1exdy(x); ...
        u2exdx(x) u2exdy(x)]);
    err4 = compute_H1_error_velocity(fespace4_u,solstr4,@(x) [u1ex(x);u2ex(x)],@(x) [u1exdx(x) u1exdy(x); ...
        u2exdx(x) u2exdy(x)]);    
    err5 = compute_H1_error_velocity(fespace5_u,solstr5,@(x) [u1ex(x);u2ex(x)],@(x) [u1exdx(x) u1exdy(x); ...
        u2exdx(x) u2exdy(x)]);
    
    err1p = compute_L2_error(fespace1_p,solstr1.p,pex);
    err2p = compute_L2_error(fespace2_p,solstr2.p,pex);
    err3p = compute_L2_error(fespace3_p,solstr3.p,pex);
    err4p = compute_L2_error(fespace4_p,solstr4.p,pex);
    err5p = compute_L2_error(fespace5_p,solstr5.p,pex);
      
    errsH1u = sqrt(err1^2+err2^2+err3^2+err4^2+err5^2);
    errsL2p = sqrt(err1p^2+err2p^2+err3p^2+err4p^2+err5p^2);
    
    err1 = err1 + err1p;
    err2 = err2 + err2p;
    err3 = err3 + err3p;
    err4 = err4 + err4p;
    err5 = err5 + err5p;

    errH1u = [errH1u;errsH1u]
    errL2p = [errL2p;errsL2p]
    err = [err; sqrt(err1^2 + err2^2 + err3^2 + err4^2 + err5^2)]
end

% loglog(h,errL2u)
% hold on
% loglog(h,h.^3*errL2u(1)/(h(1)^3));
%%
close all
n = length(h);

err = errH1u;

loglog(h(1:end),err(1:end),'.-','Markersize',10)
hold on
expo = 2;
loglog(h,h.^(expo)*min(err(1))/(h(1)^(expo)))