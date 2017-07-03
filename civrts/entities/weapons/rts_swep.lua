AddCSLuaFile()

SWEP.PrintName = "RTS"
SWEP.Slot = 1
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true

SWEP.Author = "remie"
SWEP.Instructions = "//"
SWEP.Contact = ""
SWEP.Purpose = ""


SWEP.HoldType	= "normal"

SWEP.ViewModel		= "models/weapons/c_toolgun.mdl"
SWEP.WorldModel		= "models/weapons/w_toolgun.mdl"

SWEP.UseHands		= true

util.PrecacheModel( SWEP.ViewModel )
util.PrecacheModel( SWEP.WorldModel )

SWEP.Spawnable = false
SWEP.AdminSpawnable = false

SWEP.Sound = "doors/door_latch3.wav"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
end

function SWEP:Deploy()

end

unit_control = {}
units_placed = {}

function SWEP:PrimaryAttack()
	if SERVER then
	  local tr = util.TraceLine( util.GetPlayerTrace( self.Owner ) )
		local ply = self.Owner

		if ply:GetBuildingMode() != false then
			if ply:GetSpawningUnits() != false then
				RTS.SpawnUnit(self.Owner, tr.HitPos)
			else
				RTS.SpawnStruct(self.Owner, tr.HitPos)
			end
		else
			if tr.Entity:GetClass() == "base_structure" or "base_unit" then
				print(tr.Entity)
				if tr.Entity:GetClass() == "base_unit" then
					if tr.Entity:GetTasked() != true then
						tr.Entity:SetTasked(true)
						print("Tasking entity")
						table.insert(unit_control,tr.Entity)
						self.Owner:SetSUnitID(true)
					else
						tr.Entity:SetTasked(false)
						table.RemoveByValue(unit_control,tr.Entity)
					end

				end
			end

		end
	end
end

function SWEP:SecondaryAttack()
	if SERVER then
		local ply = self.Owner
		if ply:GetBuildingMode() != false then
			ply:SetBuildingMode(false)
			ply:SetSUnit("")
		end
		--if ply:GetSUnitID() != false then
				local tr = util.TraceLine( util.GetPlayerTrace( ply ) )
				for k,v in pairs(unit_control) do
					if tr.Entity:GetClass() == "base_unit" then
						v:FireShell(tr.Entity)
						print("Firing..")
					else
						v.reached_destination = nil
						v:SetTargetPOS(Vector(tr.HitPos.x, tr.HitPos.y, tr.HitPos.z))
					end
				end
		--end
	end
end

function SWEP:Reload()
	print("-----")

		for k,v in pairs(unit_control) do
			v:FireShell()
		end

		local tr = util.TraceLine( util.GetPlayerTrace( self.Owner ) )
		if tr.Entity:GetClass() == "base_structure" then
			--print("Removing..")
			--table.RemoveByValue(self.Owner.structuretable,tr.Entity)
			self.Owner:RemoveStructure(tr.Entity)
			--tr.Entity:Remove()
		elseif tr.Entity:GetClass() == "worker_unit" then
			tr.Entity:Remove()
		end
end
