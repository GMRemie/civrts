print("Units ran")

local UNIT		= {};
UNIT.ID			= "worker_UNIT";
UNIT.Name		= "Worker";
UNIT.Description	= "Base Worker Unit";

UNIT.Model		=  "models/m109/m109.mdl"
UNIT.IsWorker = true
UNIT.Path = "worker_unit"
UNIT.Scale = 1

//models/m109/m109.mdl  //models/m1a2/m1a2.mdl
UNIT.Price		= 0//835000;

Register.UNIT(UNIT)
