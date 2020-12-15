%fiveBurn.m
%time = 76523.97;
function [dv, dt] = fiveBurn(buranOrbEl, SSOrbEl, time)
    mu = 398600.442;
    % 1 inc at one of nodes (need to solve both)
    % 2 burn from new circular orbit to get to apoapsis of SS
    % 3 burn at apoapsis of SS and start phasing
    % 4 end phasing rendesvousing at SS

    dvs = zeros(2, 4);
    dts = zeros(2, 3);
    % buran circ speed
    vcB = sqrt(mu / buranOrbEl.a);
    di = abs(buranOrbEl.i - SSOrbEl.i);
    % find deltav for the inc change at node
    dvs(:, 1) = abs(2 * vcB * sind(di / 2));
    RMOrbEl = buranOrbEl;
    RMOrbEl.i = SSOrbEl.i;
    
    for thetaStart = [180, 360]
        i = thetaStart / 180;
        
        % get the start time of the manuever
        nRM = sqrt(mu / RMOrbEl.a .^ 3);
        time = time + (thetaStart - 180) * pi / 180 / nRM;
        disp(time)

        % get the time it takes to get from the node to the periapsis angle of the SS orbit
        dts(i, 1) = (SSOrbEl.omega + 360 - thetaStart) * pi / 180 / nRM;
        pSS = SSOrbEl.a * (1 - SSOrbEl.e .^2);  % p for SS orbit
        raSS = pSS / (1 + SSOrbEl.e);   % apogee radius
        a = (RMOrbEl.a + raSS) / 2;     % a for transfer orbit
        % find starting dv and dt for half ellipse transfer
        [dvs(i, 2), dts(i, 2)] = halfEllipse(RMOrbEl.a, a);

        % find vel at apo of transfer
        vApoTrans = sqrt(mu .* (2 ./ raSS - 1 ./ a));
        % find the time for the SS to get from where it is at after this transfer to the apoapsis
        % find M of SS at apoapsis
        MSSapoSS = nutoM(180, 0);
        % find M for SS when RM gets to apo of SS first
        [~, MSSapoRM, ~] = posaftertime(time + sum(dts(i, 1:2)));
        disp(time + sum(dts(i, 1:2)))
        nSS = sqrt(mu / SSOrbEl.a .^ 3)     % n of SS orbit
        fprintf('Ms: %f, %f\n', MSSapoSS, MSSapoRM)
        % find the time change from the space shuttle position to the apoapsis (with an extra orbit)
        dts(i, 3) = (MSSapoSS + 360 + 360 - MSSapoRM) * pi / 180 / nSS;

        % find the phasing orbit semi-major axis
        aPhase = (mu * (dts(i, 3) / 2 / pi) .^ 2) .^ (1/3);
        disp(dts(i, 3))
        fprintf('atrans = %f, aphase = %f, aSS = %f, aRM = %f, rpPhase = %f\n', a, aPhase, SSOrbEl.a, RMOrbEl.a, 2*aPhase-raSS)
        % find vel of phase orbit at apoapsis
        vApoPhase = sqrt(mu .* (2 ./ raSS - 1 ./ aPhase));
        % deltav 3 starts the phasing after the transfer
        dvs(i, 3) = abs(vApoTrans - vApoPhase);
        vApoSS = sqrt(mu .* (2 ./ raSS - 1 ./ SSOrbEl.a));
        % deltav 4 ends the phasing for the rendezvous
        dvs(i, 4) = abs(vApoPhase - vApoSS);

        disp(thetaStart)
        disp(dts(i, :))
        disp(dvs(i, :))

    end

    
    dvTot = sum(dvs, 2)
    best = find(min(dvTot) == dvTot, 1)
    dv = dvs(best, :);
    dt = dts(best, :);

end

