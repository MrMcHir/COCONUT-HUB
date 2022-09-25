local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

function RUN_FUNCTION(name, extension, configOpt)
    local settings = configOpt;
    local PATH_URL = settings.URL or nil;
    local GAME_NAME = "";

    local success = pcall(function()
        game:HttpGet(PATH_URL)
    end);

    local DecodedTable;
    if (success) then
        if extension == "lua" then
            DecodedTable = loadstring(game:HttpGet(PATH_URL))()
        elseif extension == "json" then
            DecodedTable = game:GetService("HttpService"):JSONDecode(game:HttpGet(PATH_URL))
        end

        settings.Executable = ""
        for i, v in pairs(DecodedTable) do
            if (game.PlaceId == tonumber(i) and v.name and v.Working) then
                local connection = pcall(function()
                    settings.Executable = game:HttpGet(v.Script)
                end);

                GAME_NAME = v.name
            end
        end
    end

    lib:MakeNotification({
        Name = "Game Found!",
        Content = "Game: " .. GAME_NAME .. "!",
        Icon = "rbxassetid://11044015191",
        Time = 5
    })
    wait(.5)

    loadstring(settings.Executable)()
end

return RUN_FUNCTION;
