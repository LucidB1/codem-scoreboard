


frameworkObject = nil





Citizen.CreateThread(function()
    frameworkObject = GetFrameworkObject()

    if Config.Framework == 'esx' and Config.Service == 'steam' then 
        frameworkObject.RegisterServerCallback('codem-scoreboard:openmenu',function(source,cb)
            local src = source
            local playeridentifier = frameworkObject.GetPlayerFromId(src)
            local playertable = {}
            for _, playerId in ipairs(GetPlayers()) do
                local xPlayer = frameworkObject.GetPlayerFromId(playerId)
                if xPlayer then
                table.insert(playertable, 
                {
                    name = GetPlayerName(playerId),
                    id = playerId,
                    playerhex = tonumber(xPlayer.identifier:gsub("steam:",""), 16),
                    playerping = GetPlayerPing(playerId),
                    playersteamhex = xPlayer.identifier,
                    playerjob = xPlayer.job.grade_label 
    
                })
                end
            end
            cb(json.encode(playertable),playeridentifier.identifier)
        end)


    elseif Config.Framework == 'esx' and (Config.Service == 'discord' or Config.Service == 'none') then 
        frameworkObject.RegisterServerCallback('codem-scoreboard:openmenu',function(source,cb)
            local src = source
            local playeridentifier = frameworkObject.GetPlayerFromId(src)
            local playertable = {}
            for _, playerId in ipairs(GetPlayers()) do
                local xPlayer = frameworkObject.GetPlayerFromId(playerId)
                if xPlayer then
                table.insert(playertable, 
                {
                    name = GetPlayerName(playerId),
                    id = playerId,
                    playerhex = GetDiscordAvatar(playerId),
                    playerping = GetPlayerPing(playerId),
                    playersteamhex = xPlayer.identifier,
                    playerjob = xPlayer.job.grade_label 
    
                })
                end
            end
            cb(json.encode(playertable),playeridentifier.identifier)
        end)

    else
            
        if (Config.Framework == 'newqb' or  Config.Framework == 'oldqb') and Config.Service == 'steam' then 
            frameworkObject.Functions.CreateCallback('codem-scoreboard:openmenu',function(source,cb)
                local src = source
            
                local playeridentifier = frameworkObject.Functions.GetPlayer(tonumber(src))
           
                local playertable = {}
                for _, playerId in ipairs(GetPlayers()) do
               
                    local xPlayer = frameworkObject.Functions.GetPlayer(tonumber(playerId))
                    if xPlayer then 
                        
                    local steam = ExtractIdentifiers(tonumber(playerId))
                    
                    table.insert(playertable, 
                    {
                     
                        name = GetPlayerName(playerId),
                        id = playerId,
                        playerhex = tonumber(steam.steam:gsub("steam:",""), 16),
                        playerping = GetPlayerPing(playerId),
                        playersteamhex = xPlayer.PlayerData.citizenid,
                        playerjob = xPlayer.PlayerData.job.name
        
                    })
                end
                 
                end
          
                cb(json.encode(playertable),playeridentifier.PlayerData.citizenid)
            end)
        elseif (Config.Framework == 'newqb' or  Config.Framework == 'oldqb') and (Config.Service == 'discord' or Config.Service == 'none') then 
         
              frameworkObject.Functions.CreateCallback('codem-scoreboard:openmenu',function(source,cb)
                local src = source
            
                local playeridentifier = frameworkObject.Functions.GetPlayer(tonumber(src))
           
                local playertable = {}
                for _, playerId in ipairs(GetPlayers()) do
               
                    local xPlayer = frameworkObject.Functions.GetPlayer(tonumber(playerId))
                    if xPlayer then 
                        
                    local steam = ExtractIdentifiers(tonumber(playerId))
                   
                    table.insert(playertable, 
                    {
                     
                        name = GetPlayerName(playerId),
                        id = playerId,
                        playerhex = GetDiscordAvatar(playerId),
                        playerping = GetPlayerPing(playerId),
                        playersteamhex = xPlayer.PlayerData.citizenid,
                        playerjob = xPlayer.PlayerData.job.name
        
                    })
                end
                 
                end
                
                cb(json.encode(playertable),playeridentifier.PlayerData.citizenid)
            end)
        end

    end

    
end)






function ExtractIdentifiers(playerId)
  
    local identifiers = {
        steam = "",
    }

    --Loop over all identifiers
    for i = 0, GetNumPlayerIdentifiers(tonumber(playerId)) - 1 do
        local id = GetPlayerIdentifier(tonumber(playerId), i)

        --Convert it to a nice table.
        if string.find(id, "steam") then
            identifiers.steam = id
        end
    end

    return identifiers
end










local Caches = {
    Avatars = {}
}
local FormattedToken = "Bot "..Config.BotToken
function DiscordRequest(method, endpoint, jsondata)
    local data = nil
    PerformHttpRequest("https://discordapp.com/api/"..endpoint, function(errorCode, resultData, resultHeaders)
        data = {data=resultData, code=errorCode, headers=resultHeaders}
    end, method, #jsondata > 0 and json.encode(jsondata) or "", {["Content-Type"] = "application/json", ["Authorization"] = FormattedToken})

    while data == nil do
        Citizen.Wait(0)
    end
    
    return data
end

function GetDiscordAvatar(user) 
    local discordId = nil
    local imgURL = nil;
    for _, id in ipairs(GetPlayerIdentifiers(user)) do
        if string.match(id, "discord:") then
            discordId = string.gsub(id, "discord:", "")
            break
        end
    end
    if discordId then 
        if Caches.Avatars[discordId] == nil then 
            local endpoint = ("users/%s"):format(discordId)
            local member = DiscordRequest("GET", endpoint, {})
       
            if member.code == 200 then
                local data = json.decode(member.data)
                if data ~= nil and data.avatar ~= nil then 
                  
                    if (data.avatar:sub(1, 1) and data.avatar:sub(2, 2) == "_") then 
                     
                        imgURL = "https://cdn.discordapp.com/avatars/" .. discordId .. "/" .. data.avatar .. ".gif";
                    else 
                        imgURL = "https://cdn.discordapp.com/avatars/" .. discordId .. "/" .. data.avatar .. ".png"
                    end
                end
            else 
                print("Plesa contact codem store : https://discord.gg/zj3QsUfxWs ")
            end
            Caches.Avatars[discordId] = imgURL;
        else 
            imgURL = Caches.Avatars[discordId];
        end 
    else 
        print("[Codem STORE] ERROR: Discord ID was not found...")
    end
    return imgURL;
end

