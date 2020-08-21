ESX = nil
local CopsConnected  = 0

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('zaten:bilgiler:sende')
AddEventHandler('zaten:bilgiler:sende', function()
    TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Uyarı: Zaten bilgileri aldın bizi mi koparıyorsun anlamadım ki!'})
end)

 RegisterServerEvent('bilgi:alindi')
 AddEventHandler('bilgi:alindi', function()
     TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'success', text = 'Uyarı: Bilgeleri aldin!'})
 end)

 RegisterServerEvent('asama:iki:bitti')
 AddEventHandler('asama:iki:bitti', function()
     TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'success', text = ' Güvenlik Kartını aldın!'})
 end)

 RegisterServerEvent('asama:uc:bitti')
 AddEventHandler('asama:uc:bitti', function()
     TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'success', text = ' Hack Telefonunu aldın!'})
 end)

 RegisterServerEvent('konum:gelecek')
 AddEventHandler('konum:gelecek', function()
     TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'success', text = 'Bir sonraki konum birazdan sana iletilecek!'})
 end)

 RegisterServerEvent('konum:geldi')
 AddEventHandler('konum:geldi', function()
     TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'success', text = 'Konum bilgisi geldi GPS i kontrol et!'})
 end)

 RegisterServerEvent('esyalar:bitti')
 AddEventHandler('esyalar:bitti', function()
     TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'success', text = 'Bütün gerekli eşyaları topladın artık hazırsın!'})
 end)

 RegisterServerEvent('soygun:basladi')
 AddEventHandler('soygun:basladi', function()
     TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'success', text = 'Başladın!'})
 end)
 RegisterServerEvent('burada:olmaz')
 AddEventHandler('burada:olmaz', function()
     TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Burada soygun yapamazsın!'})
 end)
 RegisterServerEvent('ilk:asama:basarili')
 AddEventHandler('ilk:asama:basarili', function()
     TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'success', text = 'İlk aşama tamamlandı!'})
 end)
 RegisterServerEvent('basardik:abi')
 AddEventHandler('basardik:abi', function()
     TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'success', text = 'Başardın Tebrikler!'})
 end)
 RegisterServerEvent('basaramadik:abi')
 AddEventHandler('basaramadik:abi', function()
     TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Başaramadık abi!'})
 end)
 RegisterServerEvent('deneme:aaa')
 AddEventHandler('deneme:aaa', function()
     TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'deneme aaa!'})
 end)
 RegisterServerEvent('deneme:bbb')
 AddEventHandler('deneme:bbb', function()
     TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'deneme bbb!'})
 end)
 RegisterServerEvent('polis:yok')
 AddEventHandler('polis:yok', function()
     TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Yeterli Polis Namevcud!'})
 end)

RegisterServerEvent('card:ver')
AddEventHandler('card:ver', function()  
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem('securitycard', 1)
   end)

   RegisterServerEvent('phone:ver')
AddEventHandler('phone:ver', function()  
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem('atm_hack_phone', 1)
   end)

   RegisterServerEvent('usb:ver')
AddEventHandler('usb:ver', function()  
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem('atm_hack_usb', 1)
   end)

   RegisterServerEvent('kart:gitti')
AddEventHandler('kart:gitti', function()  
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('securitycard', 1)
   end)
   RegisterServerEvent('telefon:gitti')
AddEventHandler('telefon:gitti', function()  
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('atm_hack_phone', 1)
   end)
   RegisterServerEvent('card:ucret')
AddEventHandler('card:ucret', function()  
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('cash', Config.CardPrice)
   end)
   RegisterServerEvent('phone:ucret')
AddEventHandler('phone:ucret', function()  
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('cash', Config.PhonePrice)
   end)
   RegisterServerEvent('usb:ucret')
AddEventHandler('usb:ucret', function()  
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('cash', Config.UsbPrice)
   end)

   RegisterServerEvent('para:ver')
AddEventHandler('para:ver', function()  
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem('cash', Config.RewardPrice)
   end)


   ESX.RegisterUsableItem('atm_hack_usb', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
   local card = xPlayer.getInventoryItem('securitycard').count
	local phoneitem = xPlayer.getInventoryItem('atm_hack_phone')
	if phoneitem.count >= 1 then
		if card >= 1 then
            TriggerClientEvent('atm:soygun:baslat', source)
        else
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Kart yok!'})

        end
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Hack Telefonu olmadan soyamazsın!'})

	end
   
end)

function CountCops()

	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			CopsConnected = CopsConnected + 1
		end
	end

	SetTimeout(120 * 1000, CountCops)
end

ESX.RegisterServerCallback('yavuz:sv:polis', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb(CopsConnected)
end)