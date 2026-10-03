local ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback('billing:getInvoices', function(source, cb, playerId, status)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    
    if xPlayer then
        MySQL.Async.fetchAll('SELECT * FROM billing_invoices WHERE receiver_id = @receiver_id AND status = @status', {
            ['@receiver_id'] = playerId,
            ['@status'] = status
        }, function(result)
            cb(result)
        end)
    else
        cb({})
    end
end)

RegisterServerEvent('billing:sendInvoice')
AddEventHandler('billing:sendInvoice', function(senderId, receiverId, amount, description)
    local xSender = ESX.GetPlayerFromId(senderId)
    local xReceiver = ESX.GetPlayerFromId(receiverId)
    
    if xSender and xReceiver then
        MySQL.Async.execute('INSERT INTO billing_invoices (sender_id, receiver_id, amount, description, status) VALUES (@sender_id, @receiver_id, @amount, @description, @status)', {
            ['@sender_id'] = senderId,
            ['@receiver_id'] = receiverId,
            ['@amount'] = amount,
            ['@description'] = description,
            ['@status'] = 'open'
        }, function(rowsChanged)
            if rowsChanged > 0 then
                TriggerClientEvent('esx:showNotification', receiverId, 'You have received a new invoice.')
            end
        end)
    end
end)

RegisterServerEvent('billing:payInvoice')
AddEventHandler('billing:payInvoice', function(invoiceId)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer then
        MySQL.Async.fetchScalar('SELECT amount FROM billing_invoices WHERE id = @id AND receiver_id = @receiver_id AND status = @status', {
            ['@id'] = invoiceId,
            ['@receiver_id'] = source,
            ['@status'] = 'open'
        }, function(amount)
            if amount then
                if xPlayer.getMoney() >= amount then
                    xPlayer.removeMoney(amount)
                    MySQL.Async.execute('UPDATE billing_invoices SET status = @status, updated_at = CURRENT_TIMESTAMP WHERE id = @id', {
                        ['@status'] = 'paid',
                        ['@id'] = invoiceId
                    }, function(rowsChanged)
                        if rowsChanged > 0 then
                            TriggerClientEvent('esx:showNotification', source, 'Invoice paid successfully.')
                        end
                    end)
                else
                    TriggerClientEvent('esx:showNotification', source, 'You do not have enough money to pay this invoice.')
                end
            else
                TriggerClientEvent('esx:showNotification', source, 'Invoice not found or already paid.')
            end
        end)
    end
end)