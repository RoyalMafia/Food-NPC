AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

util.AddNetworkString( "fnpc_buy" )
util.AddNetworkString( "fnpc_menu" )

itemnum = 0

function ENT:Initialize() 
	self:SetModel( "models/Humans/Group01/male_09.mdl" )
	self:SetHullType( HULL_HUMAN )
	self:SetHullSizeNormal( )
	self:SetNPCState( NPC_STATE_SCRIPT )
	self:SetSolid( SOLID_BBOX )
	self:CapabilitiesAdd( CAP_ANIMATEDFACE )
	self:SetUseType( SIMPLE_USE )
	self:DropToFloor()
	local ent1 = ents.Create( 'fnpc_text' )
		ent1:SetPos(self:GetPos() + Vector(0,0,80))
		ent1:SetParent(self)
		ent1:Spawn()
 
	self:SetMaxYawSpeed( 90 )

end

function ENT:OnRemove()
end

function ENT:SpawnFunction( ply, tr )
    if ( !tr.Hit ) then return end
    local ent = ents.Create( 'fnpc_seller' )
    ent:SetPos( tr.HitPos + tr.HitNormal * 16 ) 
    ent:Spawn()
    ent:Activate()
 
    return ent
end

function ENT:AcceptInput( Name, Activator, Caller )
	if Name == "Use" and Caller:IsPlayer() then
		net.Start('fnpc_menu')
			net.WriteEntity( self )
		net.Send( Caller )
		self:EmitSound( "vo/npc/male01/hi02.wav", 70, 100, 1, CHAN_AUTO )
	end
end

local pos = FoodNPCconfig.foodspawnlocation

local wait = false
function fnpc_buyitem(pl, itemid)
	if(wait == false) then
		pl:addMoney(-FoodNPCconfig.ItemList[itemid].FoodPrice)
		pl:PrintMessage( HUD_PRINTTALK, "You have bought a "..FoodNPCconfig.ItemList[itemid].FoodType.." for £"..FoodNPCconfig.ItemList[itemid].FoodPrice.."!" )
		local fooditem = ents.Create(FoodNPCconfig.ItemList[itemid].FoodEntity)
		fooditem:SetModel(FoodNPCconfig.ItemList[itemid].FoodModel)
		fooditem:SetPos(FoodNPCconfig.foodspawnlocation) 
		fooditem:Spawn() 
		wait = true 
		timer.Simple(1, function() wait = false end)
	end
end
net.Receive("fnpc_buy", function(len, pl)
	itemnum = net.ReadInt(5)
	pl:PrintMessage( HUD_PRINTTALK, itemnum )
	local ply = pl
	fnpc_buyitem(ply, itemnum)
end)

--[ Optimisation by RoyalMafia <3 ]--