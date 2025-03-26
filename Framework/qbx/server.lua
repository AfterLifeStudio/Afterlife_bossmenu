if Config.framework == 'qbx' then
    lib.callback.register('GetJobPlayersCount', function(source, job)
        local Players = exports.qbx_core:GetDutyCountJob(job)
        return Players
    end)

    lib.callback.register('GetJobPlayers', function(source, job)
        local Players = exports.qbx_core:GetGroupMembers(job, 'job')


        local qbxgrades = exports.qbx_core:GetJob(job)
        local gradesoption = {}

        for k, v in pairs(qbxgrades.grades) do
            gradesoption[#gradesoption + 1] = {
                label = v.name,
                id = k
            }
        end

        local options = {}

        for i = 1, #Players do
            local citizenid = Players[i].citizenid
            local player = exports.qbx_core:GetPlayerByCitizenId(citizenid) or exports.qbx_core:GetOfflinePlayer(citizenid)

            options[#options + 1] = {
                id = citizenid,
                name = player.PlayerData.charinfo.firstname .. ' ' .. player.PlayerData.charinfo.lastname,
                gender = player.PlayerData.charinfo.gender == 0 and 'MALE' or 'FEMALE',
                job = job,
                rank = player.PlayerData.job.grade.name,
                salary = 200,
                status = player.Offline and false or true,
            }
        end



        return { players = options, grades = gradesoption }
    end)

    lib.callback.register('Server:SetPlayerJob', function(source, data)
        local playergrade = exports.qbx_core:GetPlayer(source).PlayerData.job.grade.level
        print(playergrade)
        if playergrade >= data.grade then
            exports.qbx_core:AddPlayerToJob(data.id, data.job, data.grade)
            exports.qbx_core:SetPlayerPrimaryJob(data.id, data.job)
        end
        return true
    end)
    lib.callback.register('Server:FirePlayer', function(source, data)
        exports.qbx_core:RemovePlayerFromJob(data.id, data.job)
        return true
    end)



    lib.callback.register('Server:HirePlayer', function(source, data)
        local citizenid = exports.qbx_core:GetPlayer(data.id).PlayerData.citizenid
        exports.qbx_core:AddPlayerToJob(citizenid, data.job, 0)
        exports.qbx_core:SetPlayerPrimaryJob(citizenid, data.job)
        return true
    end)


    lib.callback.register('GetNearbyPlayersInfos', function(source, data)
        local options = {}

        for i = 1, #data do
            local Player = exports.qbx_core:GetPlayer(data[i])

            options[#options + 1] = {
                id = data[i],
                name = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname,
            }
        end

        return options
    end)


    GetPlayerCash = function(source)
        local Player = exports.qbx_core:GetPlayer(source)
        local cash = Player.PlayerData.money.cash
        return cash
    end

    AddPlayerCash = function(source, amount)
        local citizenid = exports.qbx_core:GetPlayer(source).PlayerData.citizenid
        exports.qbx_core:AddMoney(citizenid, 'cash', amount, 'Job Account withdraw')
    end

    RemovePlayerCash = function(source, amount)
        local citizenid = exports.qbx_core:GetPlayer(source).PlayerData.citizenid
        exports.qbx_core:RemoveMoney(citizenid, 'cash', amount, 'Job Account Deposit')
    end


    RegisterNetEvent('QBCore:Server:OnPlayerLoaded', function()
        local player = exports.qbx_core:GetPlayer(source)
        if player == nil then return end
        if player.PlayerData.job.onduty then
            Checkin(player.PlayerData.source, player.PlayerData.citizenid, player.PlayerData.job.name)
        end
    end)


    AddEventHandler('QBCore:Server:OnJobUpdate', function(source, job)
        local player = exports.qbx_core:GetPlayer(source)
        -- if player == nil then return end
        -- if player.PlayerData.job.onduty then
        print('aa')
            Checkin(player.PlayerData.source, player.PlayerData.citizenid, job.name)
        -- end
    end)

    -- AddEventHandler('QBCore:Server:SetDuty', function(source, duty)
    --     local player = exports.qbx_core:GetPlayer(source)
    --     if player == nil then return end
    --     if duty then
    --         Checkin(player.PlayerData.source, player.PlayerData.citizenid, player.PlayerData.job.name)
    --     else
    --         CheckOut(player.PlayerData.source, player.PlayerData.citizenid, player.PlayerData.job.name)
    --     end
    -- end)


    AddEventHandler('QBCore:Server:OnPlayerUnload', function(source)
        PlayerLeave(source)
    end)


    AddEventHandler('playerDropped', function()
        PlayerLeave(source)
    end)
end
