function [colum_data,temperature_hist] = last_hist_dat_read(file_name,colum_index)

% file_name = 'crowder_f10.0_r0.5/last_hist_1.dat';
% colum_index = 1;

temperature_hist = [];
colum_data = [];

fid = fopen(file_name,'r');
temp_string = fgetl(fid);
temperature = regexp(temp_string,'[+-]?\d+\.?\d*', 'match');

for c1 = 2:length(temperature)
    temperature_value = str2num(temperature{c1})*3000-273;
    temperature_hist(end+1) = round(temperature_value);
end

while temp_string ~= -1;
    temp_string = fgetl(fid);
    if temp_string ~=-1;
        a = textscan(temp_string,'%f');   
        %disp(temp_string);
        %disp(a);
        colum_data(end+1) = a{1}(colum_index);
    else
    end
end
fclose(fid);
end