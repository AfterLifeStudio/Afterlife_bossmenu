if Config.framework == 'qb' then
    local QBCore = exports['qb-core']:GetCoreObject()

    FirstName = function ()
        local player = QBCore.Functions.GetPlayerData()
        return player.charinfo.firstname
    end

    LastName = function ()
        local player = QBCore.Functions.GetPlayerData()
        return player.charinfo.lastname
    end

    GradeLabel = function ()
        local player = QBCore.Functions.GetPlayerData()
        return player.job.grade.name
    end

    GetPlayerJob = function()
        local player = QBCore.Functions.GetPlayerData()
        local job = false
        pcall(function ()
            job = player.job.name    
        end)
        return job
    end

    IsPlayerBoss = function()
        local player = QBCore.Functions.GetPlayerData()
        local isboss = false
        pcall(function()
            isboss = player.job.isboss
        end)
        return isboss
    end

end
