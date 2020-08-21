ESX                           = nil
local startrob = false 
local asamaiki = true       -- Secure Card Alma
local asamauc = true
local asamadort = true

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
  end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if startMarker() then
            if IsControlJustPressed(1, 38) then
                if GetCurrentResourceName() == 'siryavuz-atm-robbery' then
                if not startrob then
                    
                        start()
                else 
                    zatenstart()
                end
            else
                    ESX.ShowNotification('Güzel Kardeşim Neden Scriptin ismini değiştiriyorsun ayıp değil mi?')
                    ESX.ShowNotification('Güzel Kardeşim Neden Scriptin ismini değiştiriyorsun ayıp değil mi?')
                    ESX.ShowNotification('Güzel Kardeşim Neden Scriptin ismini değiştiriyorsun ayıp değil mi?')
                    ESX.ShowNotification('Güzel Kardeşim Neden Scriptin ismini değiştiriyorsun ayıp değil mi?')
                    ESX.ShowNotification('Güzel Kardeşim Neden Scriptin ismini değiştiriyorsun ayıp değil mi?')
            end
            end
        end
    end
 end)

 -- ASAMA İKİ --
 Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if not asamaiki then
        if cardMarker() then
            if IsControlJustPressed(1, 38) then
             asamaikistart()
            end
        end
    end
    end
 end)

 -- ASAMA UC --
 Citizen.CreateThread(function()
    
    while true do
        Citizen.Wait(0)
        if not asamauc then
        if phoneMarker() then
            if IsControlJustPressed(1, 38) then
               asamaucstart()
            end
        end
    end
    end
 end)

 -- ASAMA DORT --
 Citizen.CreateThread(function()
    
    while true do
        Citizen.Wait(0)
        if not asamadort then
        if usbMarker() then
            if IsControlJustPressed(1, 38) then
                TriggerServerEvent('usb:ver')
                TriggerServerEvent('esyalar:bitti')
                UsbGive()
            end
        end
    end
    end
 end)

 function UsbGive()
    --if not IsPedInAnyVehicle(PlayerPedId(), false) then
      FreezeEntityPosition(deliveryPed, false)
      local ped = GetPlayerPed(-1)
      TaskTurnPedToFaceEntity(deliveryPed, PlayerPedId(), 0.2)
      PlayAmbientSpeech1(deliveryPed, Config.Speech.speech, Config.Speech.param, 1)
      pedAnim(ped, "mp_common", "givetake1_a")
      pedAnim(deliveryPed, "mp_common", "givetake1_a")
      Citizen.Wait(1500)
      ClearPedTasksImmediately(deliveryPed)
      ClearPedTasksImmediately(ped)
      asamadort = true
  end
  

 function CreateUsbPed(x,y,z,h)

    local hashKey = `s_m_y_xmech_02`
  
    local pedType = 5
  
    RequestModel(hashKey)
    while not HasModelLoaded(hashKey) do
        RequestModel(hashKey)
        Citizen.Wait(100)
    end
  
  
    deliveryPed = CreatePed(pedType, hashKey, x,y,z - 0.98,h, 0, 0)
  
  
    ClearPedTasks(deliveryPed)
    ClearPedSecondaryTask(deliveryPed)
    TaskSetBlockingOfNonTemporaryEvents(deliveryPed, true)
    SetPedFleeAttributes(deliveryPed, 0, 0)
    SetPedCombatAttributes(deliveryPed, 17, 1)
  
    SetPedSeeingRange(deliveryPed, 0.0)
    SetPedHearingRange(deliveryPed, 0.0)
    SetPedAlertness(deliveryPed, 0)
    SetPedKeepTask(deliveryPed, true)
    SetPedDiesWhenInjured(deliveryPed, false)
    SetEntityInvincible(deliveryPed, true)
    FreezeEntityPosition(deliveryPed, true)
  
  end

-- Harita üzerinde yazı yazmak için gerekli function
function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 500
    DrawRect(_x,_y+0.0125, 0.0002+ factor, 0.025, 0, 0, 0, 50)
end 

function usbver()
	loadAnimDict( "mp_safehouselost@" )
    TaskPlayAnim( PlayerPedId(), "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
end

-- Animasyon oynatmak için gerekli function
function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
     Citizen.Wait(5)
    end
   end

function startAnim(lib, anim)
	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, 5000, 0, 0, false, false, false)
	end)
end

function pedAnim(ped, dictionary, anim)
    Citizen.CreateThread(function()
      RequestAnimDict(dictionary)
      while not HasAnimDictLoaded(dictionary) do
        Citizen.Wait(0)
      end
        TaskPlayAnim(ped, dictionary, anim ,8.0, -8.0, -1, 50, 0, false, false, false)
    end)
  end

   function startMarker()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)

	for _, search in pairs(Config.Start) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

    if distance <= Config.MarkerDisctances then
        DrawText3Ds(-1053.0, -232.61, 43.80, "[E] Bilgisayarı Hackle")
      DrawMarker(Config.Type, -1053.0, -232.61, 43.10, 0.0, 0.0, 5.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)

			return true
    end

  end
end

function cardMarker()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)

	for _, search in pairs(Config.Card) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

    if distance <= Config.MarkerDisctances then
        DrawText3Ds(779.28, -1263.54, 26.39, "[E] Sahte Kartı Al")
        DrawMarker(Config.Type, 779.28, -1263.54, 26.39, 0.0, 0.0, 5.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)

			return true
    end

  end
end

function phoneMarker()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)

	for _, search in pairs(Config.Phone) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

    if distance <= Config.MarkerDisctances then
        DrawText3Ds(50.08, -1453.74, 29.31, "[E] Hack Telefonunu Al ")
        DrawMarker(Config.Type, 50.08, -1453.74, 28.35, 0.0, 0.0, 5.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)

			return true
    end

  end
end

function usbMarker()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)

	for _, search in pairs(Config.Usb) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

    if distance <= Config.MarkerDisctances then
        DrawText3Ds(457.88, -1498.06, 29.19, "[E] Hack Telefonu için USB Al ")
			return true
    end

  end
end

function start()
    --animasyon
    startAnim("mini@repair", "fixing_a_ped")
    exports['progressBars']:startUI(Config.InfoTime, "Bilgileri alıyorsun")
    Citizen.Wait(Config.InfoTime)
    startrob = true
    asamaiki = false
    --Telefon Konum alma (Duruma Göre Telefona Mesaj Gönderilebilir)
    TriggerEvent('canta:al')
    TriggerServerEvent('bilgi:alindi')
    TriggerServerEvent('konum:gelecek')
    Citizen.Wait(Config.LocationTime)
    SetNewWaypoint(779.28, -1263.54, 26.39)
    PlaySoundFrontend(-1, "WAYPOINT_SET", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0)
    TriggerServerEvent('konum:geldi')
end



function zatenstart()
TriggerEvent('lanet')
TriggerServerEvent('zaten:bilgiler:sende')
end

RegisterNetEvent( 'lanet' )
AddEventHandler( 'lanet', function()
    ClearPedSecondaryTask(GetPlayerPed(-1))
    loadAnimDict( "gestures@m@standing@casual" ) 
    TaskPlayAnim( GetPlayerPed(-1), "gestures@m@standing@casual", "gesture_damn", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    Citizen.Wait(850)
    ClearPedTasks(GetPlayerPed(-1))
end)


function asamaikistart()
    TriggerServerEvent('card:ver')
    TriggerServerEvent('asama:iki:bitti')
    TriggerEvent('canta:ver')
    ClearPedTasks(PlayerPedId())
    startAnim("timetable@jimmy@doorknock@", "knockdoor_idle") 
    asamaiki = true
    asamauc = false
    TriggerServerEvent('konum:gelecek')
    Citizen.Wait(Config.LocationTime)
    SetNewWaypoint(50.08, -1453.74, 29.31)
    PlaySoundFrontend(-1, "WAYPOINT_SET", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0)
    TriggerServerEvent('konum:geldi')
end

function asamaucstart()
    startAnim("timetable@jimmy@doorknock@", "knockdoor_idle") 
    Citizen.Wait(4000)
    startAnim("mp_common", "givetake1_a")
    TriggerServerEvent('phone:ver')
    TriggerServerEvent('asama:uc:bitti')
    asamauc = true
    asamadort = false
    TriggerServerEvent('konum:gelecek')
    Citizen.Wait(Config.LocationTime)
    SetNewWaypoint(457.88, -1498.06, 28.19)
    PlaySoundFrontend(-1, "WAYPOINT_SET", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0)
    TriggerServerEvent('konum:geldi')
    local yavuz = {x= 457.88, y = -1498.06, z = 28.19, h=108.57}  
    CreateUsbPed(yavuz.x, yavuz.y, yavuz.z, yavuz.h)
         --457.88, -1498.06, 28.19
end

function asamadortstart()
    TriggerServerEvent('usb:ver')
    TriggerServerEvent('esyalar:bitti')
    UsbGive()
end

--------------------------------------------------------
        --        CANTA BOMLUMU           --
--------------------------------------------------------
         

RegisterNetEvent('canta:al')
AddEventHandler('canta:al', function()
    local player = PlayerPedId()
	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        GiveWeaponToPed(player, 0x88C78EB7, 1, false, true);
    end
end)

RegisterNetEvent('canta:ver')
AddEventHandler('canta:ver', function()
    local player = PlayerPedId()
	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        RemoveWeaponFromPed(player, 0x88C78EB7)
    end
end)

RegisterCommand('cantafix', function()
    TriggerEvent('canta:sil')
end)

--------------------------------------------------------
        --        ATM SOYMA BOMLUMU           --
--------------------------------------------------------
 
RegisterNetEvent('atm:soygun:baslat')
AddEventHandler('atm:soygun:baslat', function()
    ESX.TriggerServerCallback('yavuz:sv:polis', function(CopsConnected)
        if CopsConnected >= Config.RequiredCopsRob then
            if atmMarker() then
                hackbasla()
            else
                TriggerServerEvent('burada:olmaz')
                end
            else
                TriggerServerEvent('polis:yok')
                
        end
       
    end)
end)


function atmMarker()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)

	for _, search in pairs(Config.ATM) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)

    if distance <= Config.MarkerDisctances then
			return true
    end

  end
end


function hackbasla()
    local playerPed = GetPlayerPed(-1)
	block = Config.Block
    hacktime = Config.Time
    startAnim('mp_common', 'givetake1_a')
    exports['progressBars']:startUI(2500, "Güvenlik kartını sokuyorsun")
    TriggerServerEvent('kart:gitti')
    Citizen.Wait(2500)
    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_STAND_MOBILE", 0, true);
    exports['progressBars']:startUI(Config.InfoTime, "ATM ile bağlantı kuruluyor")
    TriggerServerEvent('telefon:gitti')
    Citizen.Wait(5000)
	TriggerEvent("mhacking:show")
	TriggerEvent("mhacking:start",block,hacktime,hackProgress)
end


function hackProgress(success, timeremaining)
    local playerPed = GetPlayerPed(-1)
    TriggerEvent('mhacking:hide')
    ihbar()
	ClearPedTasks(PlayerPedId())
    if success then
        TriggerEvent('mhacking:hide')	
        TriggerServerEvent('ilk:asama:basarili')
        Citizen.Wait(3000)
        exports["datacrack"]:Start(2)
        AddEventHandler("datacrack", function(output) 
            if output then
                TriggerServerEvent('basardik:abi')
        exports['progressBars']:startUI(Config.InfoTime, "Kart alınıyor") 
        TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_ATM", 0, true);
        Citizen.Wait(5500)
        TriggerServerEvent('card:ver')
        TriggerServerEvent('phone:ver')
        TriggerServerEvent('para:ver')
        ClearPedTasksImmediately(playerPed)    
            else
                TriggerServerEvent('basaramadik:abi')                 
        TriggerServerEvent('phone:ver')
        TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_ATM", 0, true);
        Citizen.Wait(5500)
        exports['progressBars']:startUI(Config.InfoTime, "Kart alınıyor")
        TriggerServerEvent('card:ver')
        
        ClearPedTasksImmediately(playerPed)
            end
        end)

    else
        ESX.ShowNotification('başaramadık abi')
        exports['progressBars']:startUI(Config.InfoTime, "Kart alınıyor")        
        TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_ATM", 0, true);
        Citizen.Wait(5500)
        TriggerServerEvent('card:ver')
        TriggerServerEvent('phone:ver')
        ClearPedTasksImmediately(playerPed)
	end
end

function ihbar()
    local playerPed = PlayerPedId()
	local coords	= GetEntityCoords(playerPed)
    TriggerServerEvent('esx_phone:send', 'police', ('Atm Soygunu var'), false, {
		x = coords.x,
		y = coords.y,
		z = coords.z
	})
end
