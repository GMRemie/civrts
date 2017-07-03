
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	self:SetModel( "models/parthenon/parthenon.mdl" )
	self:SetUseType( SIMPLE_USE )
	self.modelMins, self.modelMaxs = self:OBBMins(), self:OBBMaxs()
	self:PhysicsInitBox(self.modelMins, self.modelMaxs)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetStructName("Pantheon")

end


function ENT:Use( activator, caller )
	print(self:GetStructName())

end
