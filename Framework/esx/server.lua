if Config.framework == 'esx' then
    local ESX = exports["es_extended"]:getSharedObject()

    lib.callback.register('GetJobPlayersCount', function(source, job)
        local xPlayers = ESX.GetExtendedPlayers('job', job)
        return #xPlayers
    end)

    lib.callback.register('GetJobPlayers', function(source, job)
        local xPlayers = MySQL.query.await(
        'SELECT `identifier`, `job`, `job_grade`, `firstname`, `lastname`, `dateofbirth`, `sex` FROM `users` WHERE `job` = ?',
            { job })

        local onlineplayers = ESX.GetExtendedPlayers('job', 'police')


        local esxgrades = ESX.GetJobs()[job].grades
        local gradesoption = {}

        for k, v in pairs(esxgrades) do
            gradesoption[#gradesoption + 1] = {
                label = v.label,
                id = k
            }
        end

        local options = {}

        local extractonline = {}

        for i = 1, #onlineplayers do
            local player = xPlayers[i]

            options[#options + 1] = {
                id = player.identifier,
                name = player.firstname .. ' ' .. player.lastname,
                gender = player.gender == 'm' and 'MALE' or 'FEMALE',
                job = player.job,
                rank = ESX.GetJobs()[player.job].grades[tostring(player.job_grade)].label,
                salary = 200,
                status = true,
            }
        end

        for i = 1, #xPlayers do
            local exist = true
            local player = xPlayers[i]
            for k = 1, #onlineplayers do


                if player.identifier == onlineplayers[k].identifier then
                    exist = false
                    break;
                end
            end

            if exist then
                options[#options + 1] = {
                    id = player.identifier,
                    name = player.firstname .. ' ' .. player.lastname,
                    gender = player.sex == 'm' and 'MALE' or 'FEMALE',
                    job = player.job,
                    rank = ESX.GetJobs()[player.job].grades[tostring(player.job_grade)].label,
                    salary = 200,
                    status = false,
                }
            end
        end




        return { players = options, grades = gradesoption }
    end)

    lib.callback.register('Server:SetPlayerJob', function(source, data)
        local number = string.find(data.id, ':')
        local identifier = data.id:sub(number + 1)

        local xPlayer = ESX.GetPlayerFromIdentifier(identifier)

        if xPlayer then
            xPlayer.setJob(data.job, data.grade)
        end
        local affectedRows = MySQL.update.await('UPDATE users SET job = ?, job_grade = ? WHERE identifier = ?',
            { data.job, data.grade, data.id })
        return true
    end)

    lib.callback.register('Server:FirePlayer', function(source, data)
        local number = string.find(data.id, ':')
        local identifier = data.id:sub(number + 1)

        local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
        
        if xPlayer then
            xPlayer.setJob('unemployed', 0)
        end
        local affectedRows = MySQL.update.await('UPDATE users SET job = ?, job_grade = ? WHERE identifier = ?',
        { 'unemployed', 0, data.id })

        return true
    end)

    lib.callback.register('Server:HirePlayer', function(source, data)
        local xPlayer = ESX.GetPlayerFromId(data.id)
        if xPlayer then
            xPlayer.setJob(data.job, 0)
        end
        return true
    end)


    lib.callback.register('GetNearbyPlayersInfos', function(source, data)
        local options = {}

        for i = 1, #data do
            local xPlayer = ESX.GetPlayerFromId(data[i])

            options[#options + 1] = {
                id = data[i],
                name = xPlayer.getName()
            }
        end

        return options
    end)


    GetPlayerCash = function(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        local cash = xPlayer.getMoney()
        return cash
    end

    AddPlayerCash = function(source, amount)
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.addMoney(amount)
    end

    RemovePlayerCash = function(source, amount)
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.removeMoney(amount)
    end


    RegisterNetEvent('esx:playerLoaded', function(player)
        print(player.source)
        print(player.identifier)
        print(player.job.name)
        Checkin(player.source, player.identifier, player.job.name)
    end)

    RegisterNetEvent('esx:playerDropped', function(playerId)
        PlayerLeave(playerId)
    end)

    RegisterNetEvent('esx:setJob', function(player, job)
        Checkin(player.source, player.identifier, job.name)
    end)

    AddEventHandler('playerDropped', function()
        PlayerLeave(source)
    end)
end
