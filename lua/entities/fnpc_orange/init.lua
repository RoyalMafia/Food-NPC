AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )  
 
include('shared.lua')
function ENT:Initialize()

	if ( SERVER ) then
		self:SetModel( FoodNPCconfig.orange.model )
		self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
		self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
		self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
		local phys = self:GetPhysicsObject()
		if ( IsValid( phys ) ) then
			phys:Wake()
		end
	end
end

function ENT:OnTakeDamage( dmginfo )
		local effectData = EffectData();	
	effectData:SetStart(self:GetPos());
	effectData:SetOrigin(self:GetPos());
	effectData:SetScale(8);	
	util.Effect("GlassImpact", effectData, true, true);
	self:Remove()
end

function ENT:Use( activator, caller )
	if ( activator:IsPlayer() ) then
		if activator:GetPos():Distance(self:GetPos()) >= 100 then activator:PrintMessage( HUD_PRINTTALK, "You're too far from the food to eat it!" ) return end
		local health = activator:Health()
		if health < 100 then
			activator:SetHealth( health + FoodNPCconfig.orange.hp )	
			self:EmitSound( "physics/flesh/flesh_squishy_impact_hard3.wav", 60, 100, 1, CHAN_AUTO )
				local effectData = EffectData();	
			effectData:SetStart(self:GetPos());
			effectData:SetOrigin(self:GetPos());
			effectData:SetScale(8);	
			util.Effect("GlassImpact", effectData, true, true);
			self:Remove()
		else
			if (wait == false) then activator:PrintMessage( HUD_PRINTTALK, "You're too full to eat more!" ) wait = true timer.Simple(0.5,function() wait = false end) end
		end
	end
end