% typedef struct R_DCAMREC_OPEN_ {
% 	int32		size;		// sizeof(*this)
% 	int32		reserved;		//
% 	unsigned long long int		hrec;		// handle for dcamrec functions
% 	//TCHAR seems to cause issues
% 	const TCHAR*		path;		// destination path
% 	const TCHAR*		ext;		// extension of destination file
% 	int32		maxframepersession;		// maximum per session
% 	int32		userdatasize;		// user data size
% 	int32		userdatasize_session;		// user data size for session
% 	int32		userdatasize_file;		// user data size for file
% 	int32		usertextsize;		// user text size
% 	int32		usertextsize_session;		// user text size for session
% 	int32		usertextsize_file;		// user text size for file

% } R_DCAMREC_OPEN;
classdef C_DCAMREC_OPEN_ < C_BASIC_TYPES
    properties    
      reserved;
      hrec;
      path;
      ext;
      maxframepersession;
      userdatasize;
      userdatasize_session;
      userdatasize_file;
      usertextsize;
      usertextsize_session;
      usertextsize_file;
    end
    methods 
        function obj = C_DCAMREC_OPEN_(reserved, hrec, path, ext, ... 
            maxframepersession, userdatasize, userdatasize_session, ... 
            userdatasize_file, usertextsize, usertextsize_session, ... 
            usertextsize_file)
                    obj.size = 60;  % [in] sizeof(DCAMREC_OPEN) 

                    obj.reserved = reserved;
                    obj.hrec = hrec;
                    obj.path = path;
                    obj.ext = ext;
                    obj.maxframepersession = maxframepersession;
                    obj.userdatasize = userdatasize;
                    obj.userdatasize_session = userdatasize_session;
                    obj.userdatasize_file = userdatasize_file;
                    obj.usertextsize = usertextsize;
                    obj.usertextsize_session = usertextsize_session;
                    obj.usertextsize_file = usertextsize_file;
                
                    pstruct.size = obj.size;
                    pstruct.reserved = obj.reserved;
                    pstruct.hrec = obj.hrec;
                    pstruct.path = obj.path;
                    pstruct.ext = obj.ext;
                    pstruct.maxframepersession = obj.maxframepersession;
                    pstruct.userdatasize = obj.userdatasize;
                    pstruct.userdatasize_session = obj.userdatasize_session;
                    pstruct.userdatasize_file = obj.userdatasize_file;
                    pstruct.usertextsize = obj.usertextsize;
                    pstruct.usertextsize_session = obj.usertextsize_session;
                    pstruct.usertextsize_file = obj.usertextsize_file;
                
                
                
                    obj.matlabPtr = libpointer('R_DCAMREC_OPEN_', pstruct);                
        end
        function Refresh(obj)
            
                    obj.reserved = obj.GetPtr().Value.reserved;
                    obj.hrec = obj.GetPtr().Value.hrec;
                    obj.path = obj.GetPtr().Value.path;
                    obj.ext = obj.GetPtr().Value.ext;
                    obj.maxframepersession = obj.GetPtr().Value.maxframepersession;
                    obj.userdatasize = obj.GetPtr().Value.userdatasize;
                    obj.userdatasize_session = obj.GetPtr().Value.userdatasize_session;
                    obj.userdatasize_file = obj.GetPtr().Value.userdatasize_file;
                    obj.usertextsize = obj.GetPtr().Value.usertextsize;
                    obj.usertextsize_session = obj.GetPtr().Value.usertextsize_session;
                    obj.usertextsize_file = obj.GetPtr().Value.usertextsize_file;           

        end
    end
end