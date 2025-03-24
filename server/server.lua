
---@class OnlineEmployees
OnlineEmployees = {}

CreateThread(function()
        for i = 1, #Config.locations do
            local ammount = MySQL.prepare.await('SELECT account FROM jobs_account WHERE job = ?', { Config.locations[i].job })
            if not (ammount) then
            MySQL.insert.await('INSERT INTO `jobs_account` (job, account) VALUES (?, ?)', { Config.locations[i].job, 0 })
            end
        end
end)


lib.callback.register('JobAccounts:Server:Add', function(source, data)
    local havecash = GetPlayerCash(source)
    local prevammount = MySQL.prepare.await('SELECT account FROM jobs_account WHERE job = ?', { data.job })
    local amount = prevammount

    if  (havecash >= tonumber(data.amount)) then
        amount = tonumber(data.amount) + prevammount
        local response = MySQL.update.await('UPDATE jobs_account SET account = ? WHERE job = ?', { amount, data.job })
        RemovePlayerCash(source,tonumber(data.amount))
    end

    return amount
end)


lib.callback.register('JobAccounts:Server:Remove', function(source, data)
    local prevammount = MySQL.prepare.await('SELECT account FROM jobs_account WHERE job = ?', { data.job })
    local amount = prevammount
    if prevammount >= tonumber(data.amount) then
        amount = prevammount - tonumber(data.amount)
        local response = MySQL.update.await('UPDATE jobs_account SET account = ? WHERE job = ?', { amount, data.job })
        AddPlayerCash(source,tonumber(data.amount))
    end

    return amount
end)

lib.callback.register('GetAccountBalance', function(source, data)
    local ammount = MySQL.prepare.await('SELECT account FROM jobs_account WHERE job = ?', { data })
    return ammount
end)

lib.callback.register('GetPlayerActivity', function(source, data)

    local activity = MySQL.prepare.await('SELECT lastcheckin, lastcheckOut, playtime FROM jobs_activity WHERE job = ? AND id = ?', { data.job, data.id })
    local data = {}

    if activity then
        data = {
            playtime = activity.playtime..' hours',
            checkin = activity.lastcheckin,
            checkout = activity.lastcheckOut
        }
    else
        data = {
            playtime = 'No Data',
            checkin = 'No Data',
            checkout = 'No Data',
        }
    end

 

    return data
end)


Checkin = function (source,id,job)
    OnlineEmployees[id] = {
        source = source,
        job = job,
    }

    local response = MySQL.update.await('UPDATE `jobs_activity` SET lastcheckin = ? WHERE id = ? AND job = ?', {os.date('%Y-%m-%d %H:%M:%S'), id, job })

    if response > 0 then
        return
    end
    MySQL.insert.await('INSERT INTO `jobs_activity` (id, job, playtime, lastcheckin) VALUES (?, ?, ?, ?)',{id, job, 0, os.date('%Y-%m-%d %H:%M:%S')})
end

CheckOut = function (source, id, job)
    for k,v in pairs(OnlineEmployees) do
        if k == id then
            OnlineEmployees[k] = nil
        end
    end
    MySQL.update.await('UPDATE `jobs_activity` SET lastcheckOut = ? WHERE id = ? AND job = ?', {os.date('%Y-%m-%d %H:%M:%S'), id, job })
end

PlayerLeave = function (source)
    for k,v in pairs(OnlineEmployees) do
        if v.source == source then
            MySQL.update.await('UPDATE `jobs_activity` SET lastcheckOut = ? WHERE id = ? AND job = ?', {os.date('%Y-%m-%d %H:%M:%S'), k, v.job })
            OnlineEmployees[k] = nil
            break;
        end
    end
end

CreateThread( function ()
    while true do
        for k,v in pairs(OnlineEmployees) do
            MySQL.update.await('UPDATE `jobs_activity` SET playtime = (playtime + 1) WHERE id = ? AND job = ?', {k, v.job})    
        end
        Wait(1000 * 5)
    end
end)