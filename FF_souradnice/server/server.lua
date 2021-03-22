ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-----------------------------------------------------------------------
local Webhook = Config.Discord
local SystemName = Config.Bot

------------ FUNKCE ------------

function ToDiscord(Name, Message, Image) --Discord hook
	if Message == nil or Message == '' then
		return false
	end

	if Image then
		PerformHttpRequest(Webhook, function(Error, Content, Head) end, 'POST', json.encode({username = Name, content = Message, avatar_url = Image}), { ['Content-Type'] = 'application/json' })
	else
		PerformHttpRequest(Webhook, function(Error, Content, Head) end, 'POST', json.encode({username = Name, content = Message}), { ['Content-Type'] = 'application/json' })
	end
end

function stringsplit(input, seperator)
	if seperator == nil then
		seperator = '%s'
	end

	local t={} ; i=1

	for str in string.gmatch(input, '([^'..seperator..']+)') do
		t[i] = str
		i = i + 1
	end

	return t
end

function havePermission(xPlayer, exclude)	-- Rank nastavitelný v db
	if exclude and type(exclude) ~= 'table' then exclude = nil;print("^3[FF_souradky] ^1ERROR ^0Takto se příkaz nepíše..^0") end	-- prevence proti špatně zapsanému příkazu

	local playerGroup = xPlayer.getGroup()
	for k,v in pairs(Config.adminRanks) do
		if v == playerGroup then
			if not exclude then
				return true
			else
				for a,b in pairs(exclude) do
					if b == v then
						return false
					end
				end
				return true
			end
		end
	end
	return false
end

------------ [KONEC] FUNKCE ------------


RegisterCommand("coo", function(source, args, rawCommand) --basic cmd
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		if havePermission(xPlayer) then
			TriggerClientEvent('FF_souradky', source)
		end
	end
end, false)

RegisterCommand("coo1", function(source, args, rawCommand) --basic cmd
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		if havePermission(xPlayer) then
			TriggerClientEvent('FF_souradky', source)
		end
	end
end, false)

RegisterServerEvent('FF_souradky:discord') --poslání na discord
AddEventHandler('FF_souradky:discord', function(msg)
    ToDiscord(SystemName, '```css\n '..msg..'\n```')
end)