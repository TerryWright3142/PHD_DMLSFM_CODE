%Zernike modes noll indices
BotchF = @(p, th) BotchMain(p, th, 10);

DefF = @(p, th, z, NA, n)   z*NA^2*p.^2/(2*n) ;
HighNAF = @(p, th, z, NA, n) z*sqrt(n^2 - NA^2*p.^2); %this has piston


BotchF1 = @(p, th) -BotchMainF(p, th, 1);
BotchF10 = @(p, th) -BotchMainF(p, th, 10);

% THE - SIGN HERE IS NEEDED DUE TO THE POSITION OF THE STAGE %  what- check
% this
BotchF1W = @(p, th) BotchMainFW(p, th, 1);
BotchF10W = @(p, th) BotchMainFW(p, th, 10);


I1 = @(p, th) 0*p;
%all of these zernike modes are normalised to sqrt(pi)
Z2 = @(p, th) 2*p.*cos(th);
Z3 = @(p, th) 2*p.*sin(th);
Z4 = @(p, th) sqrt(3)*(2*p.^2 - 1);
Z5 = @(p, th) sqrt(6)*p.^2.*sin(2*th);
Z6 = @(p, th) sqrt(6)*p.^2.*cos(2*th);
Z7 = @(p, th) sqrt(8)*(3*p.^3 - 2*p).*sin(th);
Z8 = @(p, th) sqrt(8)*(3*p.^3 - 2*p).*cos(th);
Z9 = @(p, th) sqrt(8)*p.^3.*sin(3*th);
Z10 = @(p, th) sqrt(8)*p.^3.*cos(3*th);
Z11 = @(p, th) sqrt(5)*(6*p.^4 - 6*p.^2 + 1);
Z12 = @(p, th) sqrt(10)*(4*p.^4 - 3*p.^2).*cos(2*th);
Z13 = @(p, th) sqrt(10)*(4*p.^4 - 3*p.^2).*sin(2*th);
Z14 = @(p, th) sqrt(10)*p.^4.*cos(4*th);
Z15 = @(p, th) sqrt(10)*p.^4.*sin(4*th);
Z16 = @(p, th) sqrt(12)*p.^5.*sin(5*th);
Z17 = @(p, th) sqrt(12)*p.^5.*cos(5*th);
Z18 = @(p, th) sqrt(12)*(5*p.^5 - 4*p.^3).*sin(3*th);
Z19 = @(p, th) sqrt(12)*(5*p.^5 - 4*p.^3).*cos(3*th);
Z20 = @(p, th) sqrt(12)*(10*p.^5 - 12*p.^3 + 3*p).*sin(th);
Z21 = @(p, th) sqrt(12)*(10*p.^5 - 12*p.^3 + 3*p).*cos(th);
Z22 = @(p, th) sqrt(14)*p.^6.*sin(6*th);
Z23 = @(p, th) sqrt(14)*p.^6.*cos(6*th);
Z24 = @(p, th) sqrt(14)*(6*p.^6 - 5*p.^4).*sin(4*th);
Z25 = @(p, th) sqrt(14)*(6*p.^6 - 5*p.^4).*cos(4*th);
Z26 = @(p, th) sqrt(14)*(15*p.^6 - 20*p.^4 + 6*p.^2).*sin(2*th);
Z27 = @(p, th) sqrt(14)*(15*p.^6 - 20*p.^4 + 6*p.^2).*cos(2*th);
Z28 = @(p, th) sqrt(7)*(20*p.^6 - 30*p.^4 + 12*p.^2 - 1);