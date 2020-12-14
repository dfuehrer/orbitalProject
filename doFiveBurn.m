
buran = struct('a', 6378.137 + 364, 'e', 0, 'i', 51.6, 'OMEGA', 95.262775, 'omega', 0);
SS = struct('a', 6563.3698, 'e', .004806, 'i', 45, 'OMEGA', 95.262775, 'omega', 50.375078);



time = 76523.97;
[dv, dt] = fiveBurn(buran, SS, time)
