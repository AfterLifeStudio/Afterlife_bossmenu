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



RegisterNUICallback('exitmdt', function(data, cb)
    SetNuiFocus(false, false)
    cb({})
end)
