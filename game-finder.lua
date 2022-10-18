local hahahah = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()
spawn(function()
	function loadgame()
        hahahah:MakeNotification({
            Name = "Game Found!",
            Content = "Game: " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name .. "!",
            Icon = "rbxassetid://11044015191",
            Time = 5
        })
	wait(2)
    end
end)
if game.PlaceId == 648362523 then
    loadgame()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MrMcHir/COCONUT-HUB/main/Games/Breaking%20Point.lua"))()
elseif game.PlaceId == 192800 then
    loadgame()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MrMcHir/COCONUT-HUB/main/Games/Work%20At%20A%20Pizza%20Place.lua"))()
elseif game.PlaceId == 1537690962 then
    loadgame()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MrMcHir/COCONUT-HUB/main/Games/Bss.lua"))()
elseif game.PlaceId == 621129760 then
    loadgame()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MrMcHir/COCONUT-HUB/main/Games/Kat.lua"))()
elseif game.PlaceId == 537413528 then
    loadgame()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MrMcHir/COCONUT-HUB/main/Games/babft.lua"))()
elseif game.PlaceId == 8726743209 then
    loadgame()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MrMcHir/COCONUT-HUB/main/Games/RefineryCaves.lua"))()
elseif game.PlaceId == 9872472334 then
    loadgame()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/MrMcHir/COCONUT-HUB/main/Games/Evade.lua"))()
else
    hahahah:MakeNotification({
        Name = "Game Not Found!",
        Content = "Game: Not Supported",
        Icon = "rbxassetid://11044015191",
        Time = 5
    })
end
