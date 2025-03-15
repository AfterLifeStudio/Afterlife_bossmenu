RegisterNUICallback('GetJobPlayers', function(data, cb)
    local response = lib.callback.await('GetJobPlayers', false, data)

    cb(response)
end)

RegisterNUICallback('SetGrade', function(data, cb)
    local wait = lib.callback.await('Server:SetPlayerJob', false,data)
    local response = lib.callback.await('GetJobPlayers', false, data.job)
    cb(response)
end)


RegisterNUICallback('Fire', function(data, cb)
    local wait = lib.callback.await('Server:FirePlayer', false,data)

    local response = lib.callback.await('GetJobPlayers', false, data.job)

    cb(response)
end)

RegisterNUICallback('Hire', function(data, cb)
    local wait = lib.callback.await('Server:HirePlayer', false, data)
    cb({})
end)

RegisterNUICallback('deposit:balance', function(data, cb) 
    local amount = lib.callback.await('JobAccounts:Server:Add', false, {job = data.job,amount = data.amount})
    cb(amount)
end)

RegisterNUICallback('withdraw:balance', function(data, cb) 
    local amount = lib.callback.await('JobAccounts:Server:Remove', false, {job = data.job,amount = data.amount})
    cb(amount)
end)
RegisterNUICallback('GetPlayerActivity', function(data, cb) 
    local activity = lib.callback.await('GetPlayerActivity', false, data)
    cb(activity)
end)




RegisterNUICallback('exit', function(data, cb)
    SetNuiFocus(false, false)
    cb({})
end)
