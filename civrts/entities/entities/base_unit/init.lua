
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel( "models/mrgiggles/sassilization/swordsman.mdl" )
		self:SetTargetPOS(self:GetPos())
    self.modelMins, self.modelMaxs = self:OBBMins(), self:OBBMaxs()
    self.size = self.modelMaxs.x*5
		self.reached_destination = nil
		self.combat_target = nil
		self.reloading = false
		self.OurHealth = 25; -- Amount of damage that the entity can handle - set to 0 to make it indestructible
    self:SetCollisionBounds(self.modelMins, self.modelMaxs)
		self:SetCollisionGroup(0)

		local phys = self:GetPhysicsObject()
		if ( IsValid( phys ) ) then phys:Wake() end

end

function ENT:Destroyed()
	local vPoint = self:GetPos()
	local effectdata = EffectData()
	effectdata:SetScale(0.01)
	effectdata:SetOrigin( vPoint )
	util.Effect("Explosion", effectdata)
end


function ENT:OnInjured( dmg )
	print("DAMAGE TAKEN")
	print(tostring(dmg))
 self:TakePhysicsDamage(dmg); -- React physically when getting shot/blown

 if(self.OurHealth <= 0) then return; end -- If the health-variable is already zero or below it - do nothing

 self.OurHealth = self.OurHealth - dmg:GetDamage(); -- Reduce the amount of damage took from our health-variable

 if(self.OurHealth <= 0) then -- If our health-variable is zero or below it
	 print("Dead")
	 self:Destroyed()
	 self:Remove(); -- Remove our entity
 end
end

function ENT:FireShell(ent)

	local target = ent
	--print(target)

	if target != nil then
		self:PointAtEntity( target )



	bullet = {}
	bullet.Num=1
	bullet.Src= Vector(self:GetPos().x,self:GetPos().y,self:GetPos().z)
	bullet.Dir= Vector(self:GetAngles():Forward().x, self:GetAngles():Forward().y, self:GetAngles():Forward().z)
	bullet.Spread=Vector(0.15,0.05,0)
	bullet.Tracer=1
	bullet.Force=2
	bullet.Damage=1
--Vector(vPoint.x, vPoint.y, vPoint.z + 20)
	local vPoint = self:GetPos()
	local effectdata = EffectData()
	effectdata:SetScale(1)
	effectdata:SetOrigin( Vector(self:GetAngles():Forward().x, self:GetAngles():Forward().y, self:GetAngles():Forward().z + 50) )
	util.Effect("Explosion", effectdata)

	self:FireBullets(bullet)
	self.reloading = false
end


end


function ENT:Hit(value)


end




function ENT:RunBehaviour()
	if self:GetWorker() != true then
	-- This function is called when the entity is first spawned. It acts as a giant loop that will run as long as the NPC exists
		while (true) do
				-- Lets use the above mentioned functions to see if we have/can find a enemy
					-- Since we can't find an enemy, lets wander
					-- Its the same code used in Garry's test bot
					self:StartActivity( ACT_RUN )			-- Walk anmimation
					self.loco:SetDesiredSpeed( 50 )		-- Walk speed
					if self:GetTasked() != false then
						if self.reached_destination != nil then
						else
							self:MoveToPos(  self:GetTargetPOS(), {lookahead = 500, repath = 0.5, draw = false, tolerance = 2, maxage = 5} )
							self.reached_destination = true
						end
					end
					self:StartActivity( ACT_IDLE )
				-- At this point in the code the bot has stopped chasing the player or finished walking to a random spot
				-- Using this next function we are going to wait 2 seconds until we go ahead and repeat it
				coroutine.yield()

			end
		end
end
