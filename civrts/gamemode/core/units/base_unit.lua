print("Units ran")

local UNIT		= {};
UNIT.ID			= "base_UNIT";
UNIT.Name		= "Base";
UNIT.Description	= "Base Territorial UNIT";

UNIT.Model		=  "models/m1a2/m1a2.mdl"
UNIT.IsWorker = false
UNIT.Path = "base_unit"
UNIT.Scale = 0.5

//models/m109/m109.mdl  //models/m1a2/m1a2.mdl
UNIT.Price		= 0//835000;

Register.UNIT(UNIT)
