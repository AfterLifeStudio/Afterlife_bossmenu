if Config.framework == 'qbx' then



    FirstName = function ()
        return QBX.PlayerData.charinfo.firstname
    end

    LastName = function ()
        return QBX.PlayerData.charinfo.lastname
    end

    GradeLabel = function ()
        return QBX.PlayerData.job.grade.name
    end

    GetPlayerJob = function()
        local player = QBX.PlayerData
        local job = false
        pcall(function ()
            job = player.job.name    
        end)
        return job
    end

    IsPlayerBoss = function()
        local player = QBX.PlayerData
        local isboss = false
        pcall(function()
            isboss = player.job.isboss
        end)
        return isboss
    end

end
