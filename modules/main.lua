local alreadyinzone = false
local currentlocation = {}

local PlayerPedId = PlayerPedId
local GetEntityCoords = GetEntityCoords
local DrawMarker = DrawMarker
local IsControlJustReleased = IsControlJustReleased


local LocationInteract = function(location)
    currentlocation = location
    Nuimessage('mdt', { job = location.job, theme = Config.themes[location.theme] })
    SetNuiFocus(true, true)
end


RegisterNUICallback('GetDashboardData', function(data, cb)
    local players = lib.getNearbyPlayers(GetEntityCoords(PlayerPedId()), 5, false)
    local playersid = {}
    local location = currentlocation

    for i = 1, #players do
        playersid[#playersid + 1] = GetPlayerServerId(NetworkGetPlayerIndexFromPed(players[i].ped))
    end

    local nearbyplayers = lib.callback.await('GetNearbyPlayersInfos', false, playersid)

    local otherjobs = {
        {
            job = location.job,
            label = location.joblabel
        }
    }

    if location.otherjobs then
        for i = 1, #location.otherjobs do
            otherjobs[#otherjobs + 1] = {
                job = location.otherjobs[i].job,
                label = location.otherjobs[i].label
            }
        end
    end

    local data = {
        id = location.id,
        job = data,
        playerfirstname = FirstName(),
        playername = FirstName() .. ' ' .. LastName(),
        playerrank = GradeLabel(),
        locationlabel = location.label,
        locationdescription = location.description,
        jobcount = lib.callback.await('GetJobPlayersCount', false, data),
        accountmoney = lib.callback.await('GetAccountBalance', false, data),
        nearbyplayers = nearbyplayers,
        otherjobs = otherjobs
    }

    cb(data)
end)



CreateThread(function()
    while true do
        local sleep = 1000
        
        local pedcoords = GetEntityCoords(PlayerPedId())
        local inzone = false
        local locations = Config.locations
        local playerjob = GetPlayerJob()
        local isallowed = IsPlayerBoss()

        if isallowed then
        for i = 1, #locations do
            local data = locations[i]

            if data.job == playerjob then
                local distance = #(vec3(data.coords.x, data.coords.y, data.coords.z) - pedcoords)

                if distance < 20 then
                    sleep = 0
                    DrawMarker(1, data.coords.x, data.coords.y, data.coords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0,
                        1.0, 200, 20, 20, 50, false, true, 2, false, nil, nil, false)
                    if IsControlJustReleased(0, 38) and distance < 1 then
                        LocationInteract(data)
                        inzone = true
                    end
                end

                if inzone and not alreadyinzone then
                    alreadyinzone = true
                end

                if not inzone and alreadyinzone then
                    alreadyinzone = false
                end
            end

        end
    end

        Wait(sleep)
    end
end)
