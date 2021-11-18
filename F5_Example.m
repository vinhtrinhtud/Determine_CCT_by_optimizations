function Out=F5_Example(testSpectrum)
%==========================================================================
%******---Input is a matrix (401,1) of a spectrum--------------------------
%---------------- OR ------------------------------------------------------
%******---Input is a matrix (401,n) of n spectra --------------------------
%----------Output are CCT and Duv -----------------------------------------
%-can select 2° or 10° depending on the option "standard_31"/"standard_64"
%--It's the combination of the ideas of VinhTrinh (about 80%) & ----Babillon
% (about 20%) -------------------------------------------------------------
%--VT does the idea of optimization directly with plack law----------------
%--BB does the idea of the start point ------------------------------------
%---Copyright is FGLT - TU Darmstadt - 2018 -------------------------------
%==========================================================================
% =========================================================================
%--------------------------------------------------------------------------                                                                    
load('F0_standard_observer.mat');                        % Load CMC-xyz (31) for 2° and (64) for 10°
assignin('base','standard_31',standard_31);
assignin('base','standard_64',standard_64);
% =========================================================================
% ----- calculate CCT of test light source --------------------------------
Out_basic=F3c_lamp_data_r2xyz_BB_pur(380,780,testSpectrum,2);                                % 2° tristimulus values of test illuminant -> standard_31
n_McCamy=(Out_basic.x-0.3320)./(Out_basic.y-0.1858);                                    % use method of McCamy to set initial value for finding CCT
start_point_CCT=-449.*(n_McCamy).^3 + 3525.*(n_McCamy).^2 - 6823.3.*n_McCamy + 5520.33; % use method of McCamy to set initial value for finding CCT
%--------------------------------------------------------------------------
Out1= F1_Calc_CCT_VT(start_point_CCT,Out_basic.u,Out_basic.v,2);
Out = Out_basic;
Out.CCT=Out1.CCT;
Out.Duv=Out1.Duv;
Out.Abs_SPD=testSpectrum;
% =========================================================================

