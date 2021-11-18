function [Target] = F2_Opt_function_CCT_VT(current_CCT,u_Test,v_Test,standard_observer_opt) 
%------------This function is to find the CCT based on fminsearch----------
%--------------------------------------------------------------------------
%--------Inputs: Current CCT, u_Test, v_Test and Standard_Obserer 2/10°----
%--------Outputs: Color Difference between Test & Standard ----------------
%--------------------------------------------------------------------------
%---Copyright is FGLT - TU Darmstadt - 2018 -------------------------------
%--------------------------------------------------------------------------
%---Vinh changes all on 22.11.2018
Reference = F4_planck_BB(380,780,current_CCT);                      % Current_CCT can be vector
%--------------------------------------------------------------------------
Out_ref=F3c_lamp_data_r2xyz_BB_pur(380,780,Reference,standard_observer_opt); % Output is structure, properties can be a vector
%--------------------------------------------------------------------------
Target=sqrt((Out_ref.u-u_Test).^2+(Out_ref.v-v_Test).^2);           % Target and inputs can be vectors  
sign_CCT=v_Test-Out_ref.v;assignin('base','sign_CCT',sign_CCT);     % Sign_CCT can be a vectors
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
end