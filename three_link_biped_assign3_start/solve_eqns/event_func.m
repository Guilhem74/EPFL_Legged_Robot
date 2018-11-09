%% 
% This function defines the event function.
% In the three link biped, the event occurs when the swing foot hits the
% ground.
%%
function [value,isterminal,direction] = event_func(t, y)

[~, z_swf, ~, dz_swf] = kin_swf(y(1:3), y(4:6));

% you may want to use kin_swf to set the 'value'
value = z_swf;
isterminal = 0;
direction = dz_swf/(abs(dz_swf));

end
