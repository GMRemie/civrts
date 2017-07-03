ENT.Type = "anim"
ENT.Base = "base_anim"

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "StructName");
  self:NetworkVar("Int", 1, "StructHealth");
  self:NetworkVar("Int", 2, "StructFaction")
  self:NetworkVar("Int", 3, "StructLimit")
	self:NetworkVar("Bool", 4, "Capital")
	self:NetworkVar("Bool", 5, "ReqWorkers")
	self:NetworkVar("Int", 6, "Built")

end
