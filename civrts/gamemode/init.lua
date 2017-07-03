print("Server side >ran")

include( "shared.lua" )
AddCSLuaFile("shared.lua")
AddCSLuaFile( "cl_init.lua" )


// NET MESSAGES
util.AddNetworkString("RTS_UnitSelection")

for _,v in pairs(file.Find(GM.FolderName .. "/gamemode/core/structures/*.lua", "LUA")) do include("core/structures/" .. v) end
for _,v in pairs(file.Find(GM.FolderName .. "/gamemode/core/sv_units/*.lua", "LUA")) do include("core/sv_units/" .. v) end
for _,v in pairs(file.Find(GM.FolderName .. "/gamemode/core/cl_interface/*.lua", "LUA")) do AddCSLuaFile("core/cl_interface/" .. v) end
for _,v in pairs(file.Find(GM.FolderName .. "/gamemode/core/structures/*.lua", "LUA")) do AddCSLuaFile("core/structures/" .. v) end
for _,v in pairs(file.Find(GM.FolderName .. "/gamemode/core/units/*.lua", "LUA")) do include("core/units/" .. v) end
for _,v in pairs(file.Find(GM.FolderName .. "/gamemode/core/units/*.lua", "LUA")) do AddCSLuaFile("core/units/" .. v) end




function test( ply )
print("Running test...")
ply:Give('rts_swep')

end
concommand.Add("test",test)

function cb(ply)

print(ply:GetMoney())

end
function ct(ply)
local newmoney = ply:GetMoney() + 10
ply:SetMoney(newmoney)
end

concommand.Add("cb", cb)
concommand.Add("ct",ct)
