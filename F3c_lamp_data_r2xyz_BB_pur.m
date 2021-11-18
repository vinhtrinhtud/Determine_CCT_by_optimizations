function Out= F3c_lamp_data_r2xyz_BB_pur(startw, endw, spectrum, standard_observer_opt)
%==========================================================================
spectrum=double(spectrum);spectrum(isnan(spectrum))=0; % Delete isnan in Spectrum
%--------------------------------------------------------------------------
%==========================================================================
%*** FUNCTION lamp_data_r2xyz is to calculate xyz by 2° or 10°
%*** Inputs startw and endw are to check the valid lamda & calculations ---
%*** Input Spectrum is Matrix 401 x 1 -------------------------------------
%*** Input standard_observer is to select 2° or 10° -----------------------
%*** Output is a matrix xyz 3 x 1 -----------------------------------------
%*** function [xyz] = lamp_data_r2xyz(startw,endw,spectrum,standard_observer)
%*** computes XYZ tristimulus values of test illuminant given by 'spectrum'
%*** 'spectrum' should be n x 1 vector in 1nm sampling 
%*** type of standard observer is given by variable
%*** the startw and endw variables denote first and last wavelengths
%*** for which 'spectrum' must be 1nm data in the range 380nm - 780nm
%---Copyright is FGLT - TU Darmstadt - 2018 -------------------------------
%---Vinh changes all on 22.11.2018
%==========================================================================
if((startw<380) || (endw>780))
    disp('wavelength range must be within 380nm - 780nm')
    return;
elseif(((startw - floor(startw))>0) || ((endw - floor(endw))>0))
    disp('startw and endw must be integer')
    return;
else
    %====================================================================== 
    switch standard_observer_opt
        case 2
            standard_31=evalin('base','standard_31');
            standard_observer=standard_31;
        case 10
            standard_64=evalin('base','standard_64');
            standard_observer=standard_64;
        case 2015
            standard_2015=evalin('base','CIE201510');
            standard_observer=standard_2015;
        case 2019
            standard_SS=importdata('05_12_2019_SS_in_Use.txt');
            standard_observer=standard_SS.data;
    end
    %======================================================================  
    Out.standard_observer=standard_observer;
    Out.spectrum=(spectrum.*100)./sum(spectrum.*Out.standard_observer(:,2));
    Out.X= sum(Out.spectrum.*Out.standard_observer(:,1));
    Out.Y= sum(Out.spectrum.*Out.standard_observer(:,2));
    Out.Z= sum(Out.spectrum.*Out.standard_observer(:,3));
    %======================================================================  
    Out.XYZ = [Out.X;Out.Y;Out.Z]; % Column=LQ, Row1=X, Row2=y, Row3=Z
    Out.XYZ_sum=sum(Out.XYZ);
    Out.x=Out.XYZ(1,:)./Out.XYZ_sum;
    Out.y=Out.XYZ(2,:)./Out.XYZ_sum;
    Out.z=Out.XYZ(3,:)./Out.XYZ_sum;
    Out.xyz=[Out.x;Out.y;Out.z];
    %======================================================================
    Out.u=4.*Out.x./(-2.*Out.x+12.*Out.y+3);                                 % Calcualte u
    Out.v=6.*Out.y./(-2.*Out.x+12.*Out.y+3);                                 % Calcualte v
    Out.uv=[Out.u;Out.v];
    %======================================================================
    Out.u1=4.*Out.x./(-2.*Out.x+12.*Out.y+3);                                % Calcualte u'
    Out.v1=9.*Out.y./(-2.*Out.x+12.*Out.y+3);                                % Calcualte v'
    Out.uv1=[Out.u1;Out.v1];    
end    

    