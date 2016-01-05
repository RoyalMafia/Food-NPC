include("shared.lua") 

surface.CreateFont( "F1", {font = "DermaLarge",size = 18,weight = 100,blursize = 0,scanlines = 0,})

local Selected = 0 

function fnpc_menu()
	local wait = false
--Main Menu--
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( ScrW()/2 - 265, ScrH()/2 - 97.5 )
	DermaPanel:SetSize( 530, 140 )
	DermaPanel:SetTitle( "" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( true )
	DermaPanel:ShowCloseButton( false ) 
	DermaPanel:MakePopup()
	DermaPanel.Paint = function()

		draw.RoundedBox( 0, 0, 0, DermaPanel:GetWide(), 195, Color( 40, 161, 240, 200 ) )
		draw.RoundedBox( 0, 0, 0, DermaPanel:GetWide(), 30, Color( 40,40,40,255 ) )

		draw.SimpleText("Hydrogen's Food NPC", "F3", DermaPanel:GetWide()/2, 13, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	local DermaCloseButton = vgui.Create("DButton")
	DermaCloseButton:SetParent( DermaPanel )
	DermaCloseButton:SetText( "" )
	DermaCloseButton:SetPos( DermaPanel:GetWide() - 40, 5 )
	DermaCloseButton:SetSize( 35, 20 )

	DermaCloseButton.Paint = function()

		if(DermaCloseButton:IsHovered()) then
			draw.RoundedBox(0,0,0, DermaCloseButton:GetWide(), DermaCloseButton:GetTall(), Color(200, 70, 70))
			draw.SimpleText("Close", "F2", DermaCloseButton:GetWide()/2, DermaCloseButton:GetTall()/2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		else
			draw.RoundedBox(0,0,0, DermaCloseButton:GetWide(), DermaCloseButton:GetTall(), Color(240, 70, 70))
			draw.SimpleText("Close", "F2", DermaCloseButton:GetWide()/2, DermaCloseButton:GetTall()/2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

	end

	DermaCloseButton.DoClick = function ()
		DermaPanel:Close()
	end

	-- Items List --
	local ShopList	= vgui.Create( "DIconLayout", DermaPanel )
	ShopList:SetSize( 520, 110 )
	ShopList:SetPos( 5, 35 )
	ShopList:SetSpaceY( 5 )
	ShopList:SetSpaceX( 5 )

	for i = 1, #FoodNPCconfig.ItemList do
		local ShopListItem = ShopList:Add( "DModelPanel" )
		ShopListItem:SetSize( 100, 100 )
		ShopListItem:SetModel(FoodNPCconfig.ItemList[i].FoodModel)
		ShopListItem:SetLookAt( Vector( 0, 0, 0 ) )
		ShopListItem:SetCamPos( Vector( 0, -20, 0 ) )

		ShopListItem.PaintOver = function()
			if(ShopListItem:IsHovered()) then
				draw.SimpleText( "£"..FoodNPCconfig.ItemList[i].FoodPrice ,"F1", 50 , 40 , Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText( "Click to buy" ,"F1", 50 , 60 , Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				surface.SetDrawColor(255,255,255,255)
				surface.DrawOutlinedRect( 0, 0, 100, 100 )
			else
				draw.SimpleText( FoodNPCconfig.ItemList[i].FoodType ,"F1", 50 , 50 , Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		end

		ShopListItem.DoClick = function()

			local Selected = i

			if(wait == false) then
	    		net.Start("fnpc_buy")
	    			net.WriteInt(Selected, 5)
	    		net.SendToServer()
	    		timer.Simple(FoodNPCconfig.buydelay, function() wait = false end)
	    	end
    	end
	end
end
net.Receive("fnpc_menu", fnpc_menu)

--[ Optimisation by RoyalMafia <3 ]--