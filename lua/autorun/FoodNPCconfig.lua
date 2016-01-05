//**--Food NPC Configuration file--**//
FoodNPCconfig = {}
FoodNPCconfig.ItemList = {}

-- Insert into list --
function InsertItems() 

	ToInsert            = {}
	ToInsert.FoodType   = "Watermelon"
	ToInsert.FoodEntity = "fnpc_watermelon"
	ToInsert.FoodHP     = 35
	ToInsert.FoodPrice  = 1000
	ToInsert.FoodModel  = "models/props_junk/watermelon01.mdl"
	table.insert(FoodNPCconfig.ItemList, ToInsert)

	ToInsert            = {}
	ToInsert.FoodType   = "Orange"
	ToInsert.FoodEntity = "fnpc_orange"
	ToInsert.FoodHP     = 5
	ToInsert.FoodPrice  = 200
	ToInsert.FoodModel  = "models/props/cs_italy/orange.mdl"
	table.insert(FoodNPCconfig.ItemList, ToInsert)

	ToInsert            = {}
	ToInsert.FoodType   = "Banana"
	ToInsert.FoodEntity = "fnpc_banana"
	ToInsert.FoodHP     = 6
	ToInsert.FoodPrice  = 400
	ToInsert.FoodModel  = "models/props/cs_italy/bananna.mdl"
	table.insert(FoodNPCconfig.ItemList, ToInsert)

	ToInsert            = {}
	ToInsert.FoodType   = "Banana Bunch"
	ToInsert.FoodEntity = "fnpc_bananabunch"
	ToInsert.FoodHP     = 30
	ToInsert.FoodPrice  = 900
	ToInsert.FoodModel  = "models/props/cs_italy/bananna_bunch.mdl"
	table.insert(FoodNPCconfig.ItemList, ToInsert)

	ToInsert            = {}
	ToInsert.FoodType   = "Bottle"
	ToInsert.FoodEntity = "durgz_water"
	ToInsert.FoodHP     = 0
	ToInsert.FoodPrice  = 100
	ToInsert.FoodModel  = "models/drug_mod/the_bottle_of_water.mdl"
	table.insert(FoodNPCconfig.ItemList, ToInsert)

end

InsertItems()


//**--Food Spawn Location--**//
FoodNPCconfig.foodspawnlocation 	= Vector(-796, 1183, -94)

//**--Food Buy Delay--**//
FoodNPCconfig.buydelay 				= 1

//**--This addon belongs only to Werwolf Gaming and [W-G]Hydrogen (me)--**//
--[ Optimisation by RoyalMafia <3 ]--

