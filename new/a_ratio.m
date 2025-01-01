function [speed_of_sound]=a_ratio(gamma,M1)
T_ratio= temperature_ratio(gamma,M1);
speed_of_sound=sqrt(T_ratio);
end