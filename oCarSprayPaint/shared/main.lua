
ConfigDBP = {}

ConfigDBP.Locale = 'pt' -- Change this to 'fr', 'es', 'pt', 'it', 'ru', 'de' as needed

ConfigDBP.ColorName = {"Red", "Black", "Green"} --- Color names displayed in the menu, please follow the pattern

-- [ATTENTION] Everything must be synchronized / in order (following the pattern) [ATTENTION]
ConfigDBP.ColorId = { --- the color id, see https://wiki.rage.mp/index.php?title=Vehicle_Colors 
    ["Red"] = 30, 
    ["Black"] = 40,
    ["Green"] = 50
}
--- For vanilla vehicles, the name must be in full uppercase e.g. SULTAN, for modded vehicles, the name must be exactly the same as in the .ytdd file e.g. LSPDstanier
ConfigDBP.BlackListVehicle = {
    ["SULTAN"] = true,
    ["LSPDstanier"] = true,
}

ConfigDBP.Time = 10 -- the time of the loading bar before coloring (in seconds)
