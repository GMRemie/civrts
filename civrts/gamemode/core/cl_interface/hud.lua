print("HUD ran")

local hide = {
	CHudHealth = true,
	CHudBattery = true,
}

hook.Add( "HUDShouldDraw", "HideHUD", function( name )
	if ( hide[ name ] ) then return false end
end )

hook.Add( "HUDPaint", "RTS_DevHUD", function()
	draw.RoundedBox( 0, 0, 0, 128, 128, Color( 0, 0, 0, 255 ) ) -- Draw a box
	draw.SimpleText("DEVELOPMENT", 'DebugFixedSmall', 0, 0,Color(9,255,9,255))
	draw.SimpleText("Money:"..LocalPlayer():GetMoney(), 'DebugFixedSmall', 0, 10,Color(255,255,255,255))
	draw.SimpleText("Oil:"..LocalPlayer():GetOil(), 'DebugFixedSmall', 0, 20,Color(255,255,255,255))
	draw.SimpleText("Metal:"..LocalPlayer():GetMetal(), 'DebugFixedSmall', 0, 30,Color(255,255,255,255))
	draw.SimpleText("Pop:"..LocalPlayer():GetPopulation(), 'DebugFixedSmall', 0, 40,Color(255,255,255,255))
	draw.SimpleText("UNIT:"..LocalPlayer():GetSUnit(), 'DebugFixedSmall', 0, 50,Color(255,255,255,255))
	draw.SimpleText("BUILDING:"..tostring(LocalPlayer():GetBuildingMode()), 'DebugFixedSmall', 0, 60,Color(255,255,255,255))
	draw.SimpleText("SPAWN UNIT:"..tostring(LocalPlayer():GetSpawningUnits()), 'DebugFixedSmall', 0, 70,Color(255,255,255,255))
	draw.SimpleText("SUNIT#"..tostring(LocalPlayer():GetSUnitID()), 'DebugFixedSmall', 0, 80,Color(255,255,255,255))
	draw.SimpleText("CAPITAL:"..tostring(LocalPlayer():GetCapital()), 'DebugFixedSmall', 0, 90,Color(255,255,255,255))


end )

function draw_hud()
	print("Bang")
	local bg = vgui.Create("DFrame")
	bg:SetSize(ScrW(),ScrH()*0.1)
	bg:SetPos(0,ScrH() - bg:GetTall())
	bg:SetDraggable(false)
	bg:ShowCloseButton(true)
	bg:SetTitle("RTS ACTIONS")


	local List	= vgui.Create( "DIconLayout", bg )
	List:SetSize( bg:GetWide(),bg:GetTall() )
	List:SetPos( 0, 0 )
	List:SetSpaceY( 5 )
	List:SetSpaceX( 5 )
	for k,v in pairs(RTS.Database.Structures) do
		print("asd")
		local RTS_Action = List:Add( "DButton" )
		RTS_Action:SetText("STRUCT")
		RTS_Action:SetSize( 50, 50 )
		RTS_Action.DoClick = function()
			print(v.Name)
			net.Start("RTS_UnitSelection")
				net.WriteString(v.ID)
				net.WriteBool(false)
			net.SendToServer()
		end

		RTS_Action.DoRightClick = function()
			bg:Close()
		end
	end

	for k,v in pairs(RTS.Database.Units) do
		print("UNITS")
		local RTS_Actions = List:Add( "DButton" )
		RTS_Actions:SetText("UNIT")
		RTS_Actions:SetSize( 50, 50 )
		RTS_Actions.DoClick = function()
			print(v.Name)
			net.Start("RTS_UnitSelection")
				net.WriteString(v.ID)
				net.WriteBool(true)
			net.SendToServer()
		end

		RTS_Actions.DoRightClick = function()
			bg:Close()
		end
	end

end

concommand.Add("hud", draw_hud)
