Citizen.CreateThread(function()
frameworkObject = GetFrameworkObject()

end)

RegisterNUICallback('close', function()
SetNuiFocus(false,false)
end)

RegisterKeyMapping('scoreboardopen', 'Scoreboard Menu', 'keyboard', Config.OpenKey)


RegisterCommand('scoreboardopen',function()
if Config.Framework == 'esx' and Config.Service == 'steam' then
   frameworkObject.TriggerServerCallback('codem-scoreboard:openmenu', function(data,playeridentifier)
   local steamid
   local clientplayerTable = {}
   local jobtable = {}
   local ems , mechanic, police = 0,0,0
   for k, v in pairs(json.decode(data)) do
      Citizen.Wait(100)
      if v.playerhex  then
         steamid = steamprofile(v.playerhex)
      else
         steamid = 'null'
      end
      if v.playerjob == 'ems' then 
         ems = ems + 1 
      elseif v.playerjob == 'police' then 
         police = police + 1 
      elseif v.playerjob == 'mechanic' then
         mechanic = mechanic + 1 
      end
      table.insert(clientplayerTable, {
         playersteamid = steamid,
         playerid = v.id,
         playername = v.name,
         playerping = v.playerping,
         playerhex = v.playersteamhex,
         playerjob = v.playerjob,
         playerimage = ''
         
      })
     
   end
   table.insert(jobtable,{
      ems = ems,
      police = police,
      mechanic = mechanic
   })
   if clientplayerTable then
      SetNuiFocus(true, true)
      SendNUIMessage({
         type = "OPEN_MENU",
         playertable = clientplayerTable,
         playeridentifier = playeridentifier,
         playerurl = steamprofile(playeridentifier),
         maxplayer = Config.MaxPlayer,
         service = Config.Service,
         servername = Config.ServerName
      })
      SendNUIMessage({
         type = "UPDATE_JOBS",
         jobtable = jobtable
      })
 
   end
   end)
elseif Config.Framework == 'esx' and (Config.Service == 'discord' or  Config.Service == 'none') then
   frameworkObject.TriggerServerCallback('codem-scoreboard:openmenu', function(data,playeridentifier)
      local clientplayerTable = {}
      local jobtable = {}
      local ems , mechanic, police = 0,0,0
      for k, v in pairs(json.decode(data)) do
         if v.playerjob == 'ems' then 
            ems = ems + 1 
         elseif v.playerjob == 'police' then 
            police = police + 1 
         elseif v.playerjob == 'mechanic' then
            mechanic = mechanic + 1 
         end

         table.insert(clientplayerTable, {
            playersteamid = v.playerhex,
            playerid = v.id,
            playername = v.name,
            playerping = v.playerping,
            playerhex = v.playersteamhex,
            playerjob = v.playerjob
         })
        
      end
      table.insert(jobtable,{
         ems = ems,
         police = police,
         mechanic = mechanic
      })
      if clientplayerTable then
         SetNuiFocus(true, true)
         SendNUIMessage({
            type = "OPEN_MENU",
            playertable = clientplayerTable,
            playeridentifier = playeridentifier,
            maxplayer = Config.MaxPlayer,
            service = Config.Service,
            servername = Config.ServerName
         })
         SendNUIMessage({
            type = "UPDATE_JOBS",
            jobtable = jobtable
         })
      end
      end)

   elseif (Config.Framework == 'newqb' or Config.Framework == 'oldqb')  and Config.Service == 'steam' then
   print('steam work')
   frameworkObject.Functions.TriggerCallback('codem-scoreboard:openmenu', function(data,playeridentifier)
   local steamid
   local clientplayerTable = {}
   local jobtable = {}
   local ems , mechanic, police = 0,0,0
   for k, v in pairs(json.decode(data)) do
      Citizen.Wait(100)
      print(v.playerhex)
      if v.playerhex  then
         steamid = steamprofile(v.playerhex)
         print(steamid)
      else
         steamid = 'null'
      end
      if v.playerjob == 'ems' then 
         ems = ems + 1 
      elseif v.playerjob == 'police' then 
         police = police + 1 
      elseif v.playerjob == 'mechanic' then
         mechanic = mechanic + 1 
      end
      table.insert(clientplayerTable, {
         playersteamid = steamid,
         playerid = v.id,
         playername = v.name,
         playerping = v.playerping,
         playerhex = v.playersteamhex,
         playerjob = v.playerjob,
         playerimage = ''
         
      })
     
   end
   table.insert(jobtable,{
      ems = ems,
      police = police,
      mechanic = mechanic
   })
   if clientplayerTable then
      SetNuiFocus(true, true)
      SendNUIMessage({
         type = "OPEN_MENU",
         playertable = clientplayerTable,
         playeridentifier = playeridentifier,
         playerurl = steamprofile(playeridentifier),
         maxplayer = Config.MaxPlayer,
         service = Config.Service,
         servername = Config.ServerName
      })
      SendNUIMessage({
         type = "UPDATE_JOBS",
         jobtable = jobtable
      })
 
   end
   end)
elseif (Config.Framework == 'newqb' or  Config.Framework == 'oldqb') and (Config.Service == 'discord' or  Config.Service == 'none') then
   print('discord wor.')
   frameworkObject.Functions.TriggerCallback('codem-scoreboard:openmenu', function(data,playeridentifier)
      local clientplayerTable = {}
      local jobtable = {}
      local ems , mechanic, police = 0,0,0
      for k, v in pairs(json.decode(data)) do
         if v.playerjob == 'ems' then 
            ems = ems + 1 
         elseif v.playerjob == 'police' then 
            police = police + 1 
         elseif v.playerjob == 'mechanic' then
            mechanic = mechanic + 1 
         end

         table.insert(clientplayerTable, {
            playersteamid = v.playerhex,
            playerid = v.id,
            playername = v.name,
            playerping = v.playerping,
            playerhex = v.playersteamhex,
            playerjob = v.playerjob
         })
        
      end
      table.insert(jobtable,{
         ems = ems,
         police = police,
         mechanic = mechanic
      })
      if clientplayerTable then
         SetNuiFocus(true, true)
         SendNUIMessage({
            type = "OPEN_MENU",
            playertable = clientplayerTable,
            playeridentifier = playeridentifier,
            maxplayer = Config.MaxPlayer,
            service = Config.Service,
            servername = Config.ServerName
         })
         SendNUIMessage({
            type = "UPDATE_JOBS",
            jobtable = jobtable
         })
      end
      end)
   end
end)


function steamprofile(hex)
   local steamkey = Config.SteamApiKey
  
   return "https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=" .. steamkey .. "&steamids=" .. hex
end