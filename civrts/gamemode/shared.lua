print("Shared Ran")
Register = {}
RTS = {}
RTS.Database = {
  ["Structures"] = {},
  ["Units"] = {}
}
local PLAYER = FindMetaTable("Player")

function PLAYER:CreateStructuresTable()
  if !self.structuretable then
		Msg("Making an empty strucutre table")
		self.structuretable = {}
	else
		Msg("Reusing your struct table")
		self.structuretable = self.structuretable
	end
end

function PLAYER:AddStructure(ent,unit_table)
  local ent = ent
  local unit_table = unit_table
  self.structuretable[ent] = unit_table

	for k, v in pairs (self.structuretable) do
    PrintTable(self.structuretable)
	end
end

function PLAYER:RemoveStructure(ent)
  local ent = ent
  for k,v in pairs(self.structuretable) do
    if k == ent then
      self.structuretable[ent] = nil
      ent:Remove()
    end
  end
end

function PLAYER:GetCapital()
  if self:HasCapital() > 0 then
    for k,v in pairs(self.structuretable) do
        if v.Capital != false then
          return k
        end
    end
  else
    return nil;
  end
end


function PLAYER:GetStructures()
  return self.structuretable
end

function PLAYER:HasCapital()
  local capital_count = 0
  for k,v in pairs(self.structuretable) do
    if v.Capital != false then
      capital_count = capital_count + 1
    end
  end
  return capital_count
end

function PLAYER:HasStructure(structname)
local structname = structname
local struct_count = 0
  for k,v in pairs(self.structuretable) do
    if v.Name == structname then
      struct_count = struct_count + 1
    end
  end
  return struct_count
end


function Register.STRUCTURE(StructTable)
  print("Registering Structure: "..StructTable.ID)

   RTS.Database.Structures[StructTable.ID] = StructTable;
   util.PrecacheModel(StructTable.Model);
end


function Register.UNIT(UnitTable)
  print("Registering Unit: "..UnitTable.ID)

   RTS.Database.Units[UnitTable.ID] = UnitTable;
   util.PrecacheModel(UnitTable.Model);

end



function PLAYER:SetupDataTables()
    self:NetworkVar( "String", 0, "Faction" )
    self:NetworkVar( "String", 1, "SUnit" )
    self:NetworkVar( "String", 2, "Structures" )
    self:NetworkVar( "Int", 3, "Money" )
    self:NetworkVar( "Int", 4, "Metal" )
    self:NetworkVar( "Int", 5, "Oil" )
    self:NetworkVar( "Int", 6, "Population")
    self:NetworkVar( "Bool", 7, "BuildingMode")
    self:NetworkVar( "Bool", 8, "SpawningUnits")
    self:NetworkVar( "Bool", 9, "SUnitID")
    self:NetworkVar( "Bool", 10, "Capital")

end

hook.Add( "OnEntityCreated", "SetupPlayerDataTables", function( ent )
    if ent:IsPlayer() then
      print("datatable ran")
        ent:InstallDataTable()
        ent:SetupDataTables()
        ent:CreateStructuresTable()
    end
end )
