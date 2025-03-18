

Nuimessage = function (type,data)
    SendNUIMessage({
        action = type,
        data = data
    })
end

Nuicontrol = function (state)
    SetNuiFocus(state, state)
end

Notify = function (msg,type)
    lib.notify({
        description = msg,
        type = type,
    })
end