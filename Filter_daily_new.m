function tseries_filt = Filter_daily_new(tseries,Tmin,Tmax)
% filter the data series, for a period of Tmin,Tmax (in days)
% tseries dimentions: [lon,lat,time]

%~~~~~~~Filter Parameters~~~~~~~~~~~~
f_sampling = 1;  %(days^-1) sampling frequency
N=6; % order of filter
F3dB1=1/Tmax;  % first 3dB cutoff point
F3dB2=1/Tmin;  % second 3dB cutoff point

% use a Nth order Butterworth filter. cutoff points are at 1/10 and 1/3 days^-1
fd = fdesign.bandpass('N,F3dB1,F3dB2',N,F3dB1,F3dB2,f_sampling);

% fd=fdesign.bandpass('N,F3dB1,F3dB2',N,F3dB1-0.015,F3dB2+0.015,f_nyquist);
% designmethods(fd);
Hd = design(fd,'butter');
%  fvtool(Hd);

field_num=length(size(tseries));
y=tseries;

%~~~~~~~Apply the filter~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
y=permute(y,[field_num,1:field_num-1]); % rearrange dims [3,1,2]
y=filter(Hd,y);     % filter using designed filter

%~~~~~~~Pass to output~~~~~~~~~~~~~~~
y=permute(y,[2,3,1]); % rearrange dims [2,3,1]
tseries_filt=y;          % filtered method1
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


