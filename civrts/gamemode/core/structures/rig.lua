
local STRUCTURE		= {};
STRUCTURE.ID			= "base_rig";
STRUCTURE.Name		= "Rig";
STRUCTURE.Description	= "Base Rig Structure";

STRUCTURE.Model		= "models/versailles/versailles.mdl";

STRUCTURE.Capital = false
STRUCTURE.Health = 1000
STRUCTURE.RequiresWorkers = true
STRUCTURE.Submerged = false
STRUCTURE.BuildingRequirements = nil
STRUCTURE.Limit = 2
STRUCTURE.PreBuilt = false

STRUCTURE.Price		= 0//835000;

Register.STRUCTURE(STRUCTURE)
