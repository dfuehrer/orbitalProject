%phase.m
function [time, dv, dt] = interPhaseTime(r1, r2, rin, k, di)
    mu = 398600.442;
    % first homann transfer to phasing orbit
    [dv(1:2), dt(1)] = hohmann(r1, rin);
    % phase for k periods
    dt(2) = k .* 2*pi*sqrt(rin.^3 ./ mu);
    %[dv(3:4), dt(3)] = hohmann(rin, r2);
    a = (r2 + rin) / 2;     % a for transfer between phasing orbit and final
    % find lower and outer radii for transfers since inc change at outer radius
    rless = min([rin, r2]);
    rmore = max([rin, r2]);
    ind = 3 + (rin == rmore);
    % find transfer to ro from smaller radius
    [dv(ind), dt(3)] = halfEllipse(rless, a);

    % find deltav to or from larger radius
    vc = sqrt(mu ./ rmore);
    ve = sqrt(mu .* (2 ./ rmore - 1 ./ a));
    dv(ind - 1 + (ind == 3)*2) = sqrt(ve.^2 + vc.^2 - 2 * ve .* vc .* cos(di));

    % output the total time
    time = sum(dt);
end
