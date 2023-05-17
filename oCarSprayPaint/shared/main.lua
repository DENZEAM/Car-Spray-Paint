ConfigDBP = {}


ConfigDBP.ColorName = {"Rouge","Noir","Vert"} --- Nom des couleur afficher dans le menu merci de suivre le paterne 

-- [ATTENTION] Tout doit être synchroniser / dans l'ordre (comme le paterne) [ATTENTION]
ConfigDBP.ColorId = { --- l'id de la couleur voir https://wiki.rage.mp/index.php?title=Vehicle_Colors 
    ["Rouge"] = 30, 
    ["Noir"] = 40,
    ["Vert"] = 50
}
--- Pour les véhicules vanilla le nom doit être en full maj ex : SULTAN, pour les véhicules modée le nom doit être exactement pareille que dans le .ytdd ex : LSPDstanier
ConfigDBP.BlackListVehicle = {
    ["SULTAN"] = true,
    ["LSPDstanier"] = true,
}

ConfigDBP.Time = 10 -- le temps de la barre de chargement avant la coloration (en seconde)