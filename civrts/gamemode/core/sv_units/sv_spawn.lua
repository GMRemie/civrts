print("sv_spawn ran")

function RTS.SetEntData(ent, unit_table, bool, user)

  if bool != false then
    ent:SetStructName(unit_table.Name)
    ent:SetCapital(unit_table.Capital)
    ent:SetStructLimit(unit_table.Limit)
    ent:SetReqWorkers(unit_table.RequiresWorkers)
    ent:SetModel(unit_table.Model)
    if unit_table.PreBuilt != false then
      ent:SetBuilt(100)
    else
      ent:SetBuilt(0)
    end
  else
    ent:SetModel(unit_table.Model)
    ent:SetModelScale( ent:GetModelScale() * unit_table.Scale, 0.1 )
    ent:SetWorker(unit_table.IsWorker)

  end
end

function RTS.UpdateStringTable(user, ent, unit_table)
  user:AddStructure(ent, unit_table)
end

function RTS.SpawnStruct(user, vector)
  local unit_table = RTS.Database.Structures[user:GetSUnit()]
  user:SetBuildingMode(false)

  if table.Count(user.structuretable) < 1 then // no capitals
    if unit_table.Capital != false then
      -- create a capital
      local ent = ents.Create("base_structure") -- This creates our zombie entity
      ent:SetPos(Vector(vector.x,vector.y,vector.z + 10))
      ent:SetOwner(user)
      ent:Spawn()
      RTS.SetEntData(ent, unit_table, true, user)
      RTS.UpdateStringTable(user, ent, unit_table)
    else
      print("No capitals!")
    end
  else
    if user:HasCapital() > 0 then
      // has capitals
      if user:HasStructure(unit_table.Name) >= unit_table.Limit then
          print("You have reached the limit of that structure!")
        else
          print("You have a structure(s)")
          local ent = ents.Create("base_structure") -- This creates our zombie entity
          ent:SetPos(Vector(vector.x,vector.y,vector.z + 10)) -- This positions the zombie at the place our trace hit.
          ent:Spawn()
          RTS.SetEntData(ent, unit_table, true, user)
          RTS.CreateWorker(user,ent)
          RTS.UpdateStringTable(user, ent, unit_table)
      end
    else
      print("You dont have any capitals!")
    end
  end
end

function RTS.SpawnUnit(user, vector)
  local unit_table = RTS.Database.Units[user:GetSUnit()]

  local ent = ents.Create(unit_table.Path) -- This creates our zombie entity
  ent:SetPos(Vector(vector.x,vector.y,vector.z + 10))
  ent:SetOwner(user)
  ent:Spawn()
  ent:SetTargetPOS(Vector(vector.x,vector.y,vector.z + 10))
  RTS.SetEntData(ent, unit_table, false)
end

function RTS.CreateWorker(user,  building)

  local capital = user:GetCapital()
  local vector = capital:GetPos()

  print("Creating a worker unit...")
  local ent = ents.Create("worker_unit") -- This creates our zombie entity
  ent:SetPos(Vector(vector.x + math.Rand(15,30),vector.y + math.Rand(15,30),vector.z + 10))
  ent:SetOwner(user)
  ent:Spawn()
  ent:SetModel("models/m109/m109.mdl")
  ent:SetWorker(true)
  ent:SetTaskedBuilding(building)

end




net.Receive( "RTS_UnitSelection", function( len, ply )
  local ply = ply
  local selected_Unit = net.ReadString()
  local unit_check = net.ReadBool()
  if unit_check != false then
    ply:SetSpawningUnits(true)
  else
    ply:SetSpawningUnits(false)
  end
    ply:SetBuildingMode(true)
    ply:SetSUnit(selected_Unit)
end )
