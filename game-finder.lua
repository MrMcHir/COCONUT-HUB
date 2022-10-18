local StarterGui = game:GetService("StarterGui")
spawn(function()
	function loadgame()
	StarterGui:SetCore("SendNotification", {
		Title = "Game Found!";
		Text = 	"Game: " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name .. "!",
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
    StarterGui:SetCore("SendNotification", {
	Title = "Game Not Found!",
	Text = 	"Game: Not Supported",
    })
end
hahahah:Init()
