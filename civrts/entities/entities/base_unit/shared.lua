

if (SERVER) then
	ENT.Base = "base_nextbot"
else
	ENT.Type = "anim"
	ENT.Base = "base_anim"
end

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "StructName");
  self:NetworkVar("Int", 1, "StructHealth");
  self:NetworkVar("Int", 2, "StructFaction")
  self:NetworkVar("Int", 3, "StructID")
	self:NetworkVar("Vector", 4, "TargetPOS")
	self:NetworkVar("Bool", 5, "Tasked")
	self:NetworkVar("Bool", 6, "Worker")

end

function ENT:GetSize()
	if (!self.size) then
		self.modelMins, self.modelMaxs = self:OBBMins(), self:OBBMaxs()
    	self.size = self.modelMaxs.x
	end

    return self.size
end


function ENT:GetGroundTrace()
	return util.TraceLine({
		start = self:GetPos() + vector_up * 64,
		endpos = self:GetPos() + vector_up*-512,
		filter = self
	})
end

function ENT:GetGroundPos()
	return self:GetGroundTrace().HitPos
end

function ENT:GetGroundNormal()
	return self:GetGroundTrace().HitNormal
end


local mCircle = Material("sassilization/circle")
function ENT:Draw()
	self:DrawModel()

	self:DrawCircle(self:GetSize())
end

function ENT:DrawCircle(size, color)
	render.SetMaterial(mCircle)
	local color = Color(255,0,0,0)
	if self:GetTasked() then
		color = Color(0, 255, 0)
	end
	render.DrawQuadEasy(self:GetGroundPos() + Vector(0, 0, 1) * 0.1, self:GetGroundNormal(), size, size, color)
end
