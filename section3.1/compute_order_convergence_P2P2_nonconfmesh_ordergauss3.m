clear all
close all
clc

% author: Luca Pegolotti on 30/11/2017

% This script computes the convergence order obtained on non conforming meshes
% presented in Section 3, but using a quadrature rule of order 3 at the interface

% NOTE: the script is actually the same as
% compute_order_convergence_P2P2_confmesh.m and 
% compute_order_convergence_P2P2_nonconfmesh.m exept for little details. For
% this reason, the code is cleared from unnecessary comments.

set(0,'defaulttextinterpreter','latex')

run load_exact_solution_and_f.m

dir_functions = @(x) [0;0;0;0];
neu_functions = @(x) [0;0;0;0];

N = [20 28 40 56 80 114 160];

typerror = 'H1';

brokenerror_nonconforming = [];

% we pick a low order quadrature rule for the integrals at the interface
quadrature_order = 3;

for n_elements = N    
    n1x = n_elements/2;
    n2x = n_elements/2;
    n1y = n_elements;
    % we make the mesh non-conforming by adding 1 element in the y
    % direction for the right subdomain
    n2y = n_elements + 1;
    
    xp1 = 0;
    yp1 = 0;
    L1 = 0.5;
    H1 = 1;
    
    mesh1 = create_mesh(xp1,yp1,L1,H1,n1x,n1y);
    
    xp2 = L1;
    yp2 = 0;
    L2 = 0.5;
    H2 = 1;
    
    mesh2 = create_mesh(xp2,yp2,L2,H2,n2x,n2y);
    
    bc1 = [1 0 1 1];
    fespace1 = create_fespace(mesh1,'P2',bc1);
    
    [A1,rhs1] = assembler_poisson(fespace1,fun,mu,dir_functions,neu_functions);
    
    bc2 = [1 1 1 0];
    fespace2 = create_fespace(mesh2,'P2',bc2);
    
    [A2,rhs2] = assembler_poisson(fespace2,fun,mu,dir_functions,neu_functions);
    
    n1 = size(A1,1);
    n2 = size(A2,1);
    
    indices1 = 1:n1;
    indices2 = n1+1:n1+n2;
    
    n_iterations = 16;
    
    B1 = [];
    B2 = [];
    
    brokenerrors = [];
    
    for i = 1:n_iterations
        disp(['n_elements = ', num2str(n_elements) ...
              ', iteration n = ', num2str(i)]);
        
        b1 = zeros(n1,1);
        b2 = zeros(n2,1);
        
        freq = i - 1;

        if (i == 1)
            b1 = apply_neumann_bc(fespace1,b1,@(x) [0;1;0;0]);
            
            B1 = [B1;b1'];
            
            b2 = apply_neumann_bc(fespace2,b2,@(x) [0;0;0;1]);
            
            B2 = [B2;b2'];
        else
            b1 = apply_neumann_bc(fespace1,b1,@(x) [0;sin(x(2) * pi * freq);0;0],quadrature_order);
            B1 = [B1;b1'];
            
            b1 = b1*0;
            
            b1 = apply_neumann_bc(fespace1,b1,@(x) [0;cos(x(2) * pi * freq);0;0],quadrature_order);
            B1 = [B1;b1'];
            
            b2 = apply_neumann_bc(fespace2,b2,@(x) [0;0;0;sin(x(2) * pi * freq)],quadrature_order);
            B2 = [B2;b2'];
            
            b2 = b2*0;
            
            b2 = apply_neumann_bc(fespace2,b2,@(x) [0;0;0;cos(x(2) * pi * freq)],quadrature_order);
            B2 = [B2;b2'];
        end        
        n3 = size(B1,1);
        
        A = sparse([A1 sparse(n1,n2) -B1'; sparse(n2,n1) A2 B2'; -B1 B2 sparse(n3,n3)]);
        
        f = [rhs1;rhs2;zeros(n3,1)];
        
        sol = A\f;
        
        sol1 = sol(indices1);
        sol2 = sol(indices2);
        
        err1 = compute_error(fespace1,sol1,uex,graduex,typerror);
        err2 = compute_error(fespace2,sol2,uex,graduex,typerror);
        err = sqrt(err1^2+err2^2);
        
        disp(['Total ', typerror ' error = ', num2str(err)]);
        
        brokenerrors = [brokenerrors; err];                
    end
    brokenerror_nonconforming = [brokenerror_nonconforming brokenerrors];
end

if (exist('data','dir') == 0)
    disp('error')
    mkdir data;
end
save('data/brokenerror_nonconforming_gaussorder3.mat','brokenerror_nonconforming');