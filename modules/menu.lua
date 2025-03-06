RegisterNUICallback('GetJobPlayers', function(data, cb)
    local response = lib.callback.await('GetJobPlayers', false, 'police')

    cb(response)
end)

RegisterNUICallback('SetGrade', function(data, cb)
    local wait = lib.callback.await('Server:SetPlayerJob', false,data)
    local response = lib.callback.await('GetJobPlayers', false, 'police')
    cb(response)
end)


RegisterNUICallback('Fire', function(data, cb)
    data.job = 'unemployed'
    data.grade = 0
    local wait = lib.callback.await('Server:SetPlayerJob', false,data)
    local response = lib.callback.await('GetJobPlayers', false, 'police')
    cb(response)
end)


RegisterNUICallback('deposit:balance', function(data, cb) 
    local amount = lib.callback.await('JobAccounts:Server:Add', false, {job = data.job,amount = data.amount})
    cb(amount)
end)

RegisterNUICallback('withdraw:balance', function(data, cb) 
    local amount = lib.callback.await('JobAccounts:Server:Remove', false, {job = data.job,amount = data.amount})
    cb(amount)
end)



RegisterNUICallback('exitmdt', function(data, cb)
    SetNuiFocus(false, false)
    cb({})
end)
