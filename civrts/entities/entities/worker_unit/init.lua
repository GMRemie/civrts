
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel( "models/mrgiggles/sassilization/swordsman.mdl" )
	PrintTable(self:GetSequenceList())
	self:SetTargetPOS(self:GetPos())
  self.modelMins, self.modelMaxs = self:OBBMins(), self:OBBMaxs()
  self.size = self.modelMaxs.x*5
	print("OWNER:"..tostring(self:GetOwner()))
	local user = self:GetOwner()
	self.needstobuild = nil
	self:FindBuilding()

  self:SetCollisionBounds(self.modelMins, self.modelMaxs)
	self:SetCollisionGroup(15)
	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then phys:Wake() end
end

function ENT:FindBuilding()
	print("Finding building..")
	print(self:GetTaskedBuilding())
end

function ENT:ReturnHome()
	local user = self:GetOwner()
	self.home = nil
	for k,v in pairs(user.structuretable) do
		if v.Capital == true then
			self.home = k
		end
	end
	return self.home
end

function ENT:WithinDistance(vector)
	if self:GetPos():Distance(vector) < 100 then
		print("Less than 100")
		self:Remove()
	else
		print("More than 100")
	end


end


function ENT:RunBehaviour()
	self.loco:SetDesiredSpeed(150)
	self.loco:SetJumpHeight(50)
	self.loco:SetStepHeight(15)

	while ( true ) do
		self.buildingEnt = nil
		local user = self:GetOwner()
			if (self:GetTaskedBuilding():GetBuilt() < 100) then
				self:MoveToPos(self:GetTaskedBuilding():GetPos(), {lookahead = 5, repath = 0.5, tolerance = 20})
				self.buildingEnt = self:GetTaskedBuilding()
				self.buildingEnt:SetBuilt(100)
			end
			if (self:ReturnHome() != nil) then
				local castle_pos = Vector(self.home:GetPos().x + math.random(30,50), self.home:GetPos().y + math.random(30,50), self.home:GetPos().z)
				self:MoveToPos(castle_pos, {lookahead = 5, repath = 0.5, tolerance = 20})
				self:WithinDistance(self.home:GetPos())
			end

		self:StartActivity(self:LookupSequence("idle"))
		coroutine.yield()
	end
end
