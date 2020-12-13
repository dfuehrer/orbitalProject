%phase.m
function [time, dv, dt] = interPhaseTime(r1, r2, rin, k, di)
    mu = 398600.442;
    if k ~= 0
        % first homann transfer to phasing orbit
        [dv(1:2), dt(1)] = hohmann(r1, rin);
        % phase for k periods
        dt(2) = k .* 2*pi*sqrt(rin.^3 ./ mu);
        %[dv(3:4), dt(3)] = hohmann(rin, r2);
        a = (r2 + rin) / 2;     % a for transfer between phasing orbit and final
        %% find lower and outer radii for transfers since inc change at outer radius
        %rless = min([rin, r2]);
        %rmore = max([rin, r2]);
        %ind = 3 + (rin == rmore);
        %% find transfer to ro from smaller radius
        %[dv(ind), dt(3)] = halfEllipse(rless, a);

        %% find deltav to or from larger radius
        %vc = sqrt(mu ./ rmore);
        %ve = sqrt(mu .* (2 ./ rmore - 1 ./ a));
        %dv(ind - 1 + (ind == 3)*2) = sqrt(ve.^2 + vc.^2 - 2 * ve .* vc .* cos(di));

        % find transfer to ro from smaller radius
        %[dv(ind), dt(3)] = halfEllipse(rin, a);
        [dv(3), dt(3)] = halfEllipse(rin, a);

        % find deltav to or from larger radius
        vc = sqrt(mu ./ r2);
        ve = sqrt(mu .* (2 ./ r2 - 1 ./ a));
        %dv(ind - 1 + (ind == 3)*2) = sqrt(ve.^2 + vc.^2 - 2 * ve .* vc .* cos(di));
        dv(4) = sqrt(ve.^2 + vc.^2 - 2 * ve .* vc .* cosd(di));

        % output the total time
        time = sum(dt);
    else
        a1 = (r1 + rin) / 2;     % a for transfer between phasing orbit and final
        a2 = (r2 + rin) / 2;     % a for transfer between phasing orbit and final
        [dv(1), dt(1)] = halfEllipse(r1, a1);
        dv(2) = 0;
        dt(2) = 0;
        %a = (r2 + rin) / 2;     % a for transfer between phasing orbit and final
        %% find lower and outer radii for transfers since inc change at outer radius
        %rless = min([rin, r2]);
        %rmore = max([rin, r2]);
        %ind = 3 + (rin == rmore);
        % find transfer to ro from smaller radius
        %[dv(ind), dt(3)] = halfEllipse(rless, a);
        [dv(4), dt(3)] = halfEllipse(r2, a2);

        % find deltav to or from larger radius
        vin1 = sqrt(mu .* (2 ./ rin - 1 ./ a1));
        vin2 = sqrt(mu .* (2 ./ rin - 1 ./ a2));
        dv(3) = sqrt(vin1.^2 + vin2.^2 - 2 * vin1 .* vin2 .* cosd(di));
        %dv(ind - 1 + (ind == 3)*2) = sqrt(vin1.^2 + vin2.^2 - 2 * vin1 .* vin2 .* cosd(di));

        % output the total time
        time = sum(dt);
    end
end
