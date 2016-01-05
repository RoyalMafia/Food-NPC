ENT.PrintName		= "Edible Banana"
ENT.Author			= "[W-G]Hydrogen"
ENT.Category		= "Food Mod"
ENT.Base 			= "base_gmodentity"
ENT.Type		 	= "anim"
ENT.Editable		= true
ENT.Spawnable		= true
ENT.AdminOnly		= false

function ENT:Initialize()
	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then
		phys:Wake()
	end
end