
local alreadyinzone = false

local PlayerPedId = PlayerPedId
local GetEntityCoords = GetEntityCoords
local DrawMarker = DrawMarker
local IsControlJustReleased = IsControlJustReleased


local LocationInteract = function(location)
    local data = {
        label = location.label,
        description = location.description,
        jobcount = lib.callback.await('GetJobPlayersCount', false, 'police')
    }
    Nuimessage('mdt', true)
    SetNuiFocus(true, true)
end





CreateThread(function()
    while true do
        local sleep = 1000


            local pedcoords = GetEntityCoords(PlayerPedId())
            local inzone = false
            local locations = Config.locations

            for i = 1, #locations do
                local data = locations[i]
                local distance = #(vec3(data.coords.x, data.coords.y, data.coords.z) - pedcoords)

                if distance < 20 then
                    sleep = 0
                    inzone = true

                    DrawMarker(1, data.coords.x, data.coords.y, data.coords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0,
                        1.0, 200, 20, 20, 50, false, true, 2, false, nil, nil, false)
                    if IsControlJustReleased(0, 38) and distance < 1 then
                        LocationInteract(data)
                    end
                end

                if inzone and not alreadyinzone then
                    alreadyinzone = true
                end

                if not inzone and alreadyinzone then
                    alreadyinzone = false
                end
            end


        Wait(sleep)
    end
end)
