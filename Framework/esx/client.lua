if Config.framework == 'esx' then
    local ESX = exports["es_extended"]:getSharedObject()

    FirstName = function ()
        return ESX.PlayerData.firstName
    end

    LastName = function ()
        return ESX.PlayerData.lastName
    end

    GradeLabel = function ()
        return ESX.PlayerData.job.grade_name
    end

    GetPlayerJob = function()
        local player = ESX.PlayerData
        local job = false
        pcall(function ()
            job = player.job.name    
        end)
        return job
    end

    IsPlayerBoss = function()
        local player = ESX.PlayerData
        local isboss = false
        pcall(function()
            if player.job.grade_name == 'boss' then
                isboss = true
            end
        end)
        return isboss
    end

end



