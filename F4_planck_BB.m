function Ref_PL= F4_planck_BB(startw,endw,temperature)
% temperature must be n rows, 1 column
%========================================================================
%*** FUNCTION planck
%*** Inputs startw & endW are to check ------------------------------------
%*** Input temperature is to generate Plack spectrum ----------------------
%*** Output is the Plack Spectrum -----------------------------------------
%*** calculates the relative spectral density distribution
%*** of the Planck radiator
%*** temperature defines correlated color temperature
%*** the startw and endw variables denote first and last wavelengths
%--Temperature= x Rows, 1 Collumn
%---Copyright is FGLT - TU Darmstadt - 2018 -------------------------------
%---Vinh changes all on 22.11.2018
%==========================================================================
global Force_10_grade;
if Force_10_grade==0
    standard=evalin('base','standard_31');        
else
    standard=evalin('base','standard_64');        
end
%--------------------------------------------------------------------------
c1 = 3.741832e-16;c2 = 0.0143878;
%--------------------------------------------------------------------------
if(((startw - floor(startw))>0) || ((endw - floor(endw))>0))
    disp('startw and endw must be integer')
    return;
else
    %----------------------------------------------------------------------
    wave_vec = [startw:1:endw]';
    %----------------------------------------------------------------------     
    if size(temperature,1) <= size(wave_vec,1)         
        Ref2=zeros(size(wave_vec,1),size(temperature,1));
        for i=1:1:size(temperature,1)            
           Ref2(:,i)= (c1./((wave_vec.* 10^-9).^5)) .* (1./(exp(c2./(wave_vec.*10^-9.*temperature(i,1)))-1));                                    
        end
        Ref=Ref2;
    else
        Ref3=zeros(size(temperature,1),size(wave_vec,1));
        for i=1:1:size(wave_vec,1)            
            Ref3(:,i)= (c1./((wave_vec(i,1).* (10^-9)).^5)) .* (1./(exp(c2./(wave_vec(i,1).*(10^-9).*temperature(:,1)))-1));        
        end
        Ref=Ref3';
    end
    %----------------------------------------------------------------------        
end
%--------------------------------------------------------------------------
Ref_PL=(Ref./sum(Ref.*standard(:,2))).*100;
Ref_PL=double(Ref_PL);Ref_PL(isnan(Ref_PL))=0;
%--------------------------------------------------------------------------
end
%========================================================================
