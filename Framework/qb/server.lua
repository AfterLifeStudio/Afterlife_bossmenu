if Config.framework == 'qb' then
    local QBCore = exports['qb-core']:GetCoreObject()



    lib.callback.register('GetJobPlayersCount', function(source, job)
        local Players = MySQL.query.await("SELECT * FROM `players` WHERE `job` LIKE '%" .. job .. "%'", {})
        return #Players
    end)

    lib.callback.register('GetJobPlayers', function(source, job)
        local Players = MySQL.query.await("SELECT * FROM `players` WHERE `job` LIKE '%" .. job .. "%'", {})


        local qbxgrades = exports.qbx_core:GetJob(job)
        local gradesoption = {}

        for k, v in pairs(qbxgrades.grades) do
            print(k,v)
            gradesoption[#gradesoption + 1] = {
                label = v.label,
                id = k
            }
        end

        local options = {}

        for i = 1, #Players do
            local citizenid = Players[i].citizenid
            local player = QBCore.Functions.GetPlayerByCitizenId(citizenid) or QBCore.Functions.GetOfflinePlayerByCitizenId(citizenid)

            options[#options + 1] = {
                id = citizenid,
                name = player.PlayerData.charinfo.firstname .. ' ' .. player.PlayerData.charinfo.lastname,
                gender = player.PlayerData.charinfo == 1 and 'MALE' or 'FEMALE',
                job = job,
                rank = player.PlayerData.job.grade.name,
                salary = 200,
                status = player.PlayerData.source and true or false,
            }
        end



        return { players = options, grades = gradesoption }
    end)

    lib.callback.register('Server:SetPlayerJob', function(source, data)
        local Employee = QBCore.Functions.GetPlayerByCitizenId(data.id) or QBCore.Functions.GetOfflinePlayerByCitizenId(data.id)
        Employee.Functions.SetJob(data.job, data.grade)
        return true
    end)



    lib.callback.register('Server:HirePlayer', function(source, data)
        local Employee = QBCore.Functions.GetPlayerByCitizenId(data.id) or QBCore.Functions.GetOfflinePlayerByCitizenId(data.id)
        Employee.Functions.SetJob(data.job, 0)
        return true
    end)


    lib.callback.register('GetNearbyPlayersInfos', function(source, data)
        local options = {}

        for i = 1, #data do
            local Player = QBCore.Functions.GetPlayer(data[i])

            options[#options + 1] = {
                id = data[i],
                name = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname,
            }
        end

        return options
    end)


    GetPlayerCash = function(source)
        local Player = QBCore.Functions.GetPlayer(source)
        local cash = Player.PlayerData.money.cash
        return cash
    end

    AddPlayerCash = function(source, amount)
        local citizenid = QBCore.Functions.GetPlayer(source).PlayerData.citizenid
        exports.qbx_core:AddMoney(citizenid, 'cash', amount, 'Job Account withdraw')
    end

    RemovePlayerCash = function(source, amount)
        local citizenid = QBCore.Functions.GetPlayer(source).PlayerData.citizenid
        exports.qbx_core:RemoveMoney(citizenid, 'cash', amount, 'Job Account Deposit')
    end
end
