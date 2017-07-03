print("Client Ran")

include( "shared.lua" )

for _,v in pairs(file.Find(GM.FolderName .. "/gamemode/core/structures/*.lua", "LUA")) do include("core/structures/" .. v) end
for _,v in pairs(file.Find(GM.FolderName .. "/gamemode/core/cl_interface/*.lua", "LUA")) do include("core/cl_interface/" .. v) end
for _,v in pairs(file.Find(GM.FolderName .. "/gamemode/core/units/*.lua", "LUA")) do include("core/units/" .. v) end
