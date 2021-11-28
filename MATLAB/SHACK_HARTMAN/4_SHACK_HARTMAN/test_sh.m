Imop_Runtime_Load_x64();
Imop_Enums;
config_file_path = 'C:/Program Files (x86)/Imagine Optic/WaveKitX64/Matlab/Examples\Data/config_file_haso.dat';
message = char(ones(256,1,'int8'));
[message,h_camset] = Imop_CameraSet_NewFromConfigFile(config_file_path);
size_specific_feature = 0;
[message,size_specific_feature] = Imop_CameraSet_GetSpecificFeaturesListSize(h_camset);
feature_name = char(ones(256,1,'int8'));
for i=0:size_specific_feature-1
		[message,feature_name] = Imop_CameraSet_GetSpecificFeatureName(h_camset,i);
		fprintf('specific feature name : %s \n', feature_name);
end
size_parameters_list = 0;
[message,size_parameters_list] = Imop_CameraSet_GetParametersListSize(h_camset);
parameter_name = char(ones(256,1,'int8'));
min = 0;
max = 0;
for i=0:size_parameters_list-1
		[message,parameter_name] = Imop_CameraSet_GetParameterName(h_camset,i);
		[message,type] = Imop_CameraSet_GetParameterType(h_camset,parameter_name);
		[message,is_settable,is_gettable,has_default_value,has_limits,is_string_enum,is_settable_on_fly,is_gettable_on_fly] = Imop_CameraSet_GetParameterOption(h_camset,parameter_name);
% 		%% switch on correct type and test if option is available
		if (type == E_TYPE_INT && has_limits)
			[message,min,max] = Imop_CameraSet_GetParameterIntLimits(h_camset,parameter_name);
			fprintf('parameter name : %s \n', parameter_name);
			fprintf('parameter min value : %d \n', min);
			fprintf('parameter max value : %d \n', max);
        end
end
[message] = Imop_CameraSet_Delete(h_camset);
Imop_Runtime_Unload_x64();
clear; 
