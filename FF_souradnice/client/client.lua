------------NAČTENÍ ESX ------------

ESX = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

------------ [KONEC] NAČTENÍ ESX ------------

------------ ZAOKROUHLENÍ ČÍSEL ------------

function desetina(num, numDecimalPlaces) --zaokrouhlední souřadnic
    local mult = 5^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

------------ [KONEC] ZAOKROUHLENÍ ČÍSEL ------------

RegisterNetEvent('FF_souradky') --Nový event
AddEventHandler('FF_souradky', function()
    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true)) --zjistím kde stojí postava
    local export = "{x = "..desetina(x,2)..",  y = "..desetina(y,2)..",  z = "..desetina(z,2).."}," --zapíšu pod x = něco, y = něco, z = něco
    ESX.UI.Menu.Open( --basic menu s dialogem pro vypsání názvu souřadnice pro lepší přehled
        'dialog', GetCurrentResourceName(), 'codemenu',
        {
          title = "Název souřadnice"
        },
        function(data, menu)
            local name = data.value
            TriggerServerEvent('FF_souradky:discord', name.." : "..export) --server event k zaslání na discord
            menu.close()
        end,
      function(data, menu)
        menu.close()
      end)
    
end)

RegisterNetEvent('FF_souradky1') --nový event
AddEventHandler('FF_souradky1', function()
    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true)) --zjistím kde stojí postava
    local export = desetina(x,2)..", "..desetina(y,2)..", "..desetina(z,2) --zapíšu pod x = něco y = něco z = něco
    ESX.UI.Menu.Open( --basic menu s dialogem pro vypsání názvu souřadnice pro lepší přehled
        'dialog', GetCurrentResourceName(), 'codemenu',
        {
          title = "Nombre"
        },
        function(data, menu)
            local name = data.value
            TriggerServerEvent('FF_souradky:discord', name.." : "..export) --server event k zaslání na discord
            menu.close()
        end,
      function(data, menu)
        menu.close()
      end)
end)