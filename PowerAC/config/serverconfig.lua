ConfigCS = {}
ConfigCS.Locale = 'es'
-- Licencia de Power-AC
ConfigCS.License           = "2121212-12121-21212312"
ConfigCS.NameServer        = "Power-AC"  ---- PONER TU NOMBRE DEL SERVIDOR QUE SE VA A USAR 
-- Link de logs
ConfigCS.GlobalBan         = ""  ---- LOGSSSSS
ConfigCS.LOGS              = ""
ConfigCS.ranchomenu        = "" 
ConfigCS.otc               = ""
ConfigCS.noclip            = ""
 
--Permisos de administrador
ConfigCS.Bypass            = {"Power-ACadmin","Power-ACmod"}
ConfigCS.OpenMenuAllowed   = {"Power-ACadmin"}
ConfigCS.SpectateAllowed   = {"Power-ACadmin","Power-ACmod"}
ConfigCS.ClearAreaAllowed  = {"Power-ACadmin"}

-- Trigger Prohibidos
ConfigCS.lynx = {
    "vrp_slotmachine:server:2",
    "esx_fueldelivery:pay",
    "esx_carthief:pay",
    "esx_ranger:pay",
    "AdminMenu:giveBank",
    "AdminMenu:giveCash",
    "esx_slotmachine:sv:2",
    "NB:recruterplayer",
    "OG_cuffs:cuffCheckNearest",
    "cuffServer",
    "cuffGranted",
    "gambling:spend",
    "AdminMenu:giveDirtyMoney",
    "mission:completed",
    "99kr-burglary:addMoney",
    "hentailover:xdlol",
    "antilynx8:anticheat",
    "antilynxr6:detection",
    "antilynx8r4a:anticheat",
    "antilynxr4:detect", 
    "ynx8:anticheat",
    "lynx8:anticheat",
    "adminmenu:allowall",
   -- "h:xd",
    "esx_skin:responseSaveSkin",
    "adminmenu:setsalary",
    "adminmenu:cashoutall",
    "HCheat:TempDisableDetection",
    "esx-qalle-hunting:reward",
    "esx-qalle-hunting:sell",
    "BsCuff:Cuff696999",
    --"veh_SR:CheckMoneyForVeh",
    "mellotrainer:adminTempBan",
    "mellotrainer:adminKick",
    "d0pamine_xyz:getFuckedNigger",
    --"InteractSound_SV:PlayOnAll",
    --"InteractSound_SV:PlayWithinDistance",
    
}
-- Palabras phohibidas
ConfigCS.lol = {
    'Desudo',
    'Brutan',
    'EulenCheats',
    "Lynx 8",
    "www.lynxmenu.com",
    "HamHaxia",
    "Ham Mafia",
    "www.renalua.com",
    "Fallen#0811",
    "Rena 8",
    "HamHaxia",
    "Ham Mafia",
    "Xanax#0134",
    ">:D Player Crash",
    "34ByTe Community",
    "lynxmenu.com",
    "Anti-Lynx",
    "Baran#8992",
    "iLostName#7138",
    "85.190.90.118",
    "hammafia.com",
    "AlphaV ~ 5391",
    "vjuton.pl",
    "EulenCheat",
    "Eulen",
    "lynxmenu",
    "Lynx",
    "lynxmenu.com - Cheats & Anti-Cheats!",
    "Soviet Bear",
}

ConfigCS.ExplosionsList = {
	[0] = { name = "Grenade", log = true, ban = false },
	[1] = { name = "GrenadeLauncher", log = true, ban = true },
	[2] = { name = "C4", log = true, ban = false },
    [3] = { name = "Molotov", log = true, ban = false },
    [4] = { name = "Rocket", log = true, ban = true },
    [5] = { name = "TankShell", log = true, ban = true},
    [6] = { name = "Hi_Octane", log = true, ban = false },
    [7] = { name = "Car", log = true, ban = false },
    [8] = { name = "Plance", log = true, ban = false },
    [9] = { name = "PetrolPump", log = true, ban = false },
    [10] = { name = "Bike", log = true, ban = false },
    [11] = { name = "Dir_Steam", log = true, ban = false },
    [12] = { name = "Dir_Flame", log = true, ban = false },
    [13] = { name = "Dir_Water_Hydrant", log = true, ban = false },
    [14] = { name = "Dir_Gas_Canister", log = true, ban = false },
    [15] = { name = "Boat", log = true, ban = false },
    [16] = { name = "Ship_Destroy", log = true, ban = false },
    [17] = { name = "Truck", log = true, ban = false },
    [18] = { name = "Bullet", log = true, ban = false },
    [19] = { name = "SmokeGrenadeLauncher", log = true, ban = false },
    [20] = { name = "SmokeGrenade", log = true, ban = false },
    [21] = { name = "BZGAS", log = true, ban = false },
    [22] = { name = "Flare", log = true, ban = false },
    [23] = { name = "Gas_Canister", log = true, ban = false },
    [24] = { name = "Extinguisher", log = true, ban = false },
    [25] = { name = "Programmablear", log = true, ban = false },
    [26] = { name = "Train", log = true, ban = false },
    [27] = { name = "Barrel", log = true, ban = false },
    [28] = { name = "PROPANE", log = true, ban = false },
    [29] = { name = "Blimp", log = true, ban = false },
    [30] = { name = "Dir_Flame_Explode", log = true, ban = false },
    [31] = { name = "Tanker", log = true, ban = false },
    [32] = { name = "PlaneRocket", log = true, ban = true },
    [33] = { name = "VehicleBullet", log = true, ban = false },
    [34] = { name = "Gas_Tank", log = true, ban = false },
    [35] = { name = "FireWork", log = true, ban = false },
    [36] = { name = "SnowBall", log = true, ban = false },
    [37] = { name = "ProxMine", log = true, ban = false },
    [38] = { name = "Valkyrie_Cannon", log = true, ban = true }
}