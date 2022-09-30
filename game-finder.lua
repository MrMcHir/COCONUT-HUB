local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
spawn(function()
	function loadgame()
        lib:MakeNotification({
            Name = "Game Found!",
            Content = "Game: " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name .. "!",
            Icon = "rbxassetid://11044015191",
            Time = 5
        })
    end
end)
if game.PlaceId == 648362523 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MrMcHir/COCONUT-HUB/main/Games/Breaking%20Point.lua"))()
elseif game.PlaceId == 192800 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MrMcHir/COCONUT-HUB/main/Games/Work%20At%20A%20Pizza%20Place.lua"))()
elseif game.PlaceId == 1537690962 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MrMcHir/COCONUT-HUB/main/Games/Bss.lua"))()
elseif game.PlaceId == 621129760 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MrMcHir/COCONUT-HUB/main/Games/Kat.lua"))()
else
    lib:MakeNotification({
        Name = "Game Not Found!",
        Content = "Game: Not Supported",
        Icon = "rbxassetid://11044015191",
        Time = 5
    })
end
