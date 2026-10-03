local ESX = exports['es_extended']:getSharedObject()

local isMenuOpen = false

-- Register keybind for opening the billing menu
RegisterKeyMapping('openBillingMenu', 'Open Billing Menu', 'keyboard', Config.Keybind)

RegisterCommand('openBillingMenu', function()
    if not isMenuOpen then
        openBillingMenu()
    end
end, false)

function openBillingMenu()
    isMenuOpen = true
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'openBillingMenu',
        logoPath = Config.LogoPath,
        darkMode = Config.DarkMode
    })
end

function closeBillingMenu()
    isMenuOpen = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = 'closeBillingMenu'
    })
end

RegisterNUICallback('closeBillingMenu', function(data, cb)
    closeBillingMenu()
    cb('ok')
end)

RegisterNUICallback('sendInvoice', function(data, cb)
    local playerId = GetPlayerServerId(PlayerId())
    local receiverId = data.receiverId
    local amount = data.amount
    local description = data.description
    
    TriggerServerEvent('billing:sendInvoice', playerId, receiverId, amount, description)
    cb('ok')
end)

RegisterNUICallback('getInvoices', function(data, cb)
    local playerId = GetPlayerServerId(PlayerId())
    local status = data.status
    
    ESX.TriggerServerCallback('billing:getInvoices', function(invoices)
        cb(invoices)
    end, playerId, status)
end)

RegisterNUICallback('payInvoice', function(data, cb)
    local invoiceId = data.invoiceId
    
    TriggerServerEvent('billing:payInvoice', invoiceId)
    cb('ok')
end)