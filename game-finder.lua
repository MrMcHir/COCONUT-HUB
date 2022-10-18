local hahaha = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
spawn(function()
	function loadgame()
	hahaha:MakeNotification({
		Name = "Game Found!";
		Content = "Game: " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name .. "!",
		Time = 5
	})
	wait(2)
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
elseif game.PlaceId == 537413528 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MrMcHir/COCONUT-HUB/main/Games/babft.lua"))()
elseif game.PlaceId == 8726743209 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MrMcHir/COCONUT-HUB/main/Games/RefineryCaves.lua"))()
elseif game.PlaceId == 9872472334 then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MrMcHir/COCONUT-HUB/main/Games/Evade.lua"))()
else
	hahaha:MakeNotification({
		Name = "Game Not Found!",
		Content = "Game: Not Supported",
		Time = 5
	})
end
hahaha:Init()
