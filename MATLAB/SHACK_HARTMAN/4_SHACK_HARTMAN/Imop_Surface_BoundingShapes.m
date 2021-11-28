function [err_message, threshold, barycenter, bc_radius, bc_energy, bs_side, bs_energy] = Imop_Surface_BoundingShapes(Surface)

% IMOP_SURFACE_BOUNDINGSHAPES Find the bounding square and bounding circle parameters centered on surface barycenter.
%    Bouding square (resp. circle) is defined as the smallest square (resp. circle) such that
%    SUM(values at (x,y) if (x,y) is in square(resp. circle)) > threshold.
%    Surface must be normalized, i.e. sum(pixels of surface = 1 -> see Imop_Surface_Prepare method)
% 
%    Surface      Surface object adress.
%                 
%    err_message  Error message, empty if no error occured.
%                 
%    threshold    Energy threshold (btween 0 and 1)
%                 
%    barycenter   Surface barycenter coordinates.
%                 
%    bc_radius    Bounding circle radius
%                 
%    bc_energy    Real energy value inside bounding circle
%                 
%    bs_side      Bounding square side size
%                 
%    bs_energy    Real energy value inside bounding circle
%                 
% 

if nargin ~= 1
	error('The "Imop_Surface_BoundingShapes" function requires 1 input argument(s).');
end
err_message = char(ones(256,1,'int8'));
threshold = 0;
barycenter = [];
bc_radius = 0;
bc_energy = 0;
bs_side = 0;
bs_energy = 0;

[err_nb, err_message, barycenter, bc_radius, bc_energy, bs_side, bs_energy] = calllib('WaveKitRuntime', 'Imop_Surface_BoundingShapes', err_message, Surface, threshold, barycenter, bc_radius, bc_energy, bs_side, bs_energy);


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
