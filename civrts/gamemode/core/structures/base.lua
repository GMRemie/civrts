print("Structures RAN")

local STRUCTURE		= {};
STRUCTURE.ID			= "base_structure";
STRUCTURE.Name		= "Base";
STRUCTURE.Description	= "Base Territorial Structure";

STRUCTURE.Model		= "models/parthenon/parthenon.mdl";

STRUCTURE.Capital = true
STRUCTURE.Health = 1000
STRUCTURE.RequiresWorkers = false
STRUCTURE.Submerged = false
STRUCTURE.BuildingRequirements = nil
STRUCTURE.Limit = 1
STRUCTURE.PreBuilt = true


STRUCTURE.Price		= 0//835000;

Register.STRUCTURE(STRUCTURE)
