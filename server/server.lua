

CreateThread(function()
    local response = {}
    pcall(function()
        response = MySQL.prepare.await('SELECT * FROM jobs_account')
    end)

    if response then



        
    for i = 1,#Config.locations do

        local exist = false
        for k,v in pairs(response) do
            if v == Config.locations[i].job then
               exist = true
            end
        end

        if exist == false then
            MySQL.insert.await('INSERT INTO `jobs_account` (job, account) VALUES (?, ?)',{ Config.locations[i].job, 0 })
        end
    end

else

    for key = 1,#Config.locations do
        MySQL.insert.await('INSERT INTO `jobs_account` (job, account) VALUES (?, ?)',{ Config.locations[key].job, 0 })
    end


end


end)


lib.callback.register('JobAccounts:Server:Add', function(source,data)
    local prevammount = MySQL.prepare.await('SELECT account FROM jobs_account WHERE job = ?', {data.job})

    local amount = data.amount + prevammount
    local response = MySQL.update.await('UPDATE jobs_account SET account = ? WHERE job = ?',{ amount, data.job })

    return amount
end)


lib.callback.register('JobAccounts:Server:Remove', function(source,data)
    local prevammount = MySQL.prepare.await('SELECT account FROM jobs_account WHERE job = ?', {data.job})
    local amount = prevammount
    if prevammount >= data.amount then
    amount = data.amount - prevammount
    local response = MySQL.update.await('UPDATE jobs_account SET account = ? WHERE job = ?',{ amount, data.job })
    end

    return amount
end)

lib.callback.register('GetAccountBalance', function(source,data)
    local ammount = MySQL.prepare.await('SELECT account FROM jobs_account WHERE job = ?', {data})
    return ammount
end)