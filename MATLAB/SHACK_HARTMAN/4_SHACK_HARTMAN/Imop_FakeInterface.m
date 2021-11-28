function Imop_FakeInterface()

% IMOP_FAKEINTERFACE Not available
% 
% 

if nargin ~= 0
	error('The "Imop_FakeInterface" function requires 0 input argument(s).');
end

[err_nb] = calllib('WaveKitRuntime', 'Imop_FakeInterface');


if(err_nb ~= 0)
	err = MException(strcat('IoRuntime:RuntimeError_', num2str(err_nb)) , err_message);
	throw(err)
end
