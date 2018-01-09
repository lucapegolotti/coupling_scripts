% define diffusivity
mu_const = 1;
mu = @(x) mu_const;

% define exact solution
alpha = 100;

uexxy = @(x,y) alpha .* (1 - x) .* x .* (1 - y) .* y .* sin(1/3 - x .* y.^2);
uex = @(x) uexxy(x(1),x(2));

uexdx = @(x,y) - alpha * x .* y .* sin(x .* y.^2 - 1/3) .* (y - 1) - ...
                 alpha * y .* sin(x .* y.^2 - 1/3) .* (x - 1) .* (y - 1) - ...
                 alpha * x .* y.^3 .* cos(x .* y.^2 - 1/3) .* (x - 1) .* (y - 1);
uexdy = @(x,y) - alpha * x .* y .* sin(x .* y.^2 - 1/3) .* (x - 1) - ... 
                 alpha * x .* sin(x .* y.^2 - 1/3) .* (x - 1) .* (y - 1) - ...
                 2 * alpha .* x.^2 .* y.^2 .* cos(x .* y.^2 - 1/3) .* (x - 1) .* (y - 1);
graduex = @(x) [uexdx(x(1),x(2));uexdy(x(1),x(2))];

% define forcing term
funxy = @(x,y) 2 * alpha * x .* sin(x .* y.^2 - 1/3) .* (x - 1) + ... 
               2 * alpha * y .* sin(x .* y.^2 - 1/3) .* (y - 1) + ...
               2 * alpha * x .* y.^3 .* cos(x .* y.^2 - 1/3) .* (y - 1) + ...
               4 * alpha * x.^2 .* y.^2 .* cos(x .* y.^2 - 1/3) .* (x - 1) + ...
               2 * alpha * y.^3 .* cos(x .* y.^2 - 1/3) .* (x - 1) .* (y - 1) + ...
               6 * alpha * x.^2 .* y .* cos(x .* y.^2 - 1/3) .* (x - 1) .* (y - 1) - ...
               alpha * x .* y.^5 .* sin(x .* y.^2 - 1/3) .* (x - 1) .* (y - 1) - ...
               4 * alpha .* x.^3 .* y.^3 .* sin(x .* y.^2 - 1/3) .* (x - 1) .* (y - 1);
fun = @(x) funxy(x(1,:),x(2,:));