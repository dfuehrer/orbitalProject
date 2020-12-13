%calcGEOTransfer.m
function [dv, dt, rin] = calcGEOTransfer(thetaGEO0, theta1, r1, di)
    rGEO = 42159.4856;
    disp(r1)
    omegaEarth = 7.292115856e-5;
    %dThetaGEO = mod(theta1 - thetaGEO0, 360) * pi / 180;
    dThetaGEO = (theta1 - thetaGEO0) * pi / 180;
    disp(dThetaGEO)
    transTime = dThetaGEO / omegaEarth;
    disp(transTime);
    maxNumPhases = 6;
    rins = zeros(1, maxNumPhases);
    for k = 0:maxNumPhases
        asdf = @(rins) interPhaseTime(r1, rGEO, rins, k, di) - transTime;
        dt1 = asdf(r1);
        dt2 = asdf(rGEO);
        %if dt1 * dt2 > 0
        %    continue
        %end
        %rins(k+1) = fzero(asdf, [r1, rGEO]);
        rins(k+1) = fzero(asdf, rGEO*1.5);
        if rins(k+1) < 6378.137
            rins(k+1) = 0;
        end
    end
    %rins(maxNumPhases+2) = fzero(@(rins) interPhaseTime(r1, rGEO, rins, 0, di) - transTime, rGEO*1.5);
    %disp(interPhaseTime(r1, rGEO, rins(end), 0, di))


    dvTot = ones(1, maxNumPhases+2) * inf;
    dvs = zeros(maxNumPhases+2, 4);
    dts = zeros(maxNumPhases+2, 3);
    for k = 0:maxNumPhases
        if rins(k+1) == 0
            continue
        end
        [time, dvs(k+1, :), dts(k+1, :)] = interPhaseTime(r1, rGEO, rins(k+1), k, di);
        disp(k);
        disp(dvs(k+1, :));
        dvTot(k+1) = sum(dvs(k+1, :));
        disp(dvTot(k+1));
    end
    %[time, dvs(maxNumPhases+2, :), dts(maxNumPhases+2, :)] = interPhaseTime(r1, rGEO, rins(maxNumPhases+2), 0, di);
    %disp('bielliptic')
    %dvTot(maxNumPhases+2) = sum(dvs(maxNumPhases+2, :));
    %disp(dvs(maxNumPhases+2, :))
    %disp(dvTot(maxNumPhases+2))

    best = find(min(dvTot) == dvTot)
    %if best == maxNumPhases+2
    %    kbest = 0
    %else
    %    kbest = best - 1
    %end
    kbest = best - 1
    dv = dvs(best, :);
    dt = dts(best, :);
    rin = rins(best);
    disp(rins);
    [time, dv, dt] = interPhaseTime(r1, rGEO, rins(best), kbest, di);
end
