function Out= F1_Calc_CCT_VT(start_point_CCT,u_Test,v_Test,standard_observer)
%% function to calculate CCT of test illuminant given by coordinates (u_Test,v_Test)
%% Start with the default options
%---Copyright is FGLT - TU Darmstadt - 2018 -------------------------------
%---Vinh changes all on 22.11.2018
options = optimset;
options = optimset(options,'Display', 'off');
%==========================================================================  
for i=1:1:size(start_point_CCT,2)   
    [Out.CCT(1,i),Out.Duv(1,i),~,~] = fminsearch(@(x)F2_Opt_function_CCT_VT(x,u_Test(1,i),v_Test(1,i),standard_observer),start_point_CCT(1,i),options);
    if evalin( 'base', 'exist(''sign_CCT'',''var'') == 1' )
        Out.sign_CCT(1,i)=evalin('base','sign_CCT');
    end
end
%==========================================================================  
Out.CCT(Out.CCT<0)=0;
%==========================================================================  
Out.sign_CCT(Out.sign_CCT<0)=-1;
Out.sign_CCT(Out.sign_CCT>=0)=1;
Out.Duv=Out.Duv.*Out.sign_CCT;
%==========================================================================  
end
