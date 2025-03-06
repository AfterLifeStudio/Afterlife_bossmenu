if Config.framework == 'esx' then
    local ESX = exports["es_extended"]:getSharedObject()

    lib.callback.register('GetJobPlayersCount', function(source,job)
        local xPlayers = ESX.GetExtendedPlayers('job', job)
        return #xPlayers
    end)

    lib.callback.register('GetJobPlayers', function(source,job)

        local xPlayers =  MySQL.query.await('SELECT `identifier`, `job`, `job_grade`, `firstname`, `lastname`, `dateofbirth`, `sex` FROM `users` WHERE `job` = ?', {job})


        local esxgrades = ESX.GetJobs()[job].grades
        local gradesoption = {}

        for k,v in pairs(esxgrades) do
            gradesoption[#gradesoption + 1] = {
                label = v.label,
                id = k
            }
        end

        local options = {}

        for i = 1, #xPlayers do
            local player = xPlayers[i]

            local number = string.find(player.identifier, ':')
            local identifier = player.identifier:sub(number + 1)

            options[#options + 1] = {
                id = player.identifier,
                name = player.firstname..' '..player.lastname;
                gender = player.sex == 'm' and 'MALE' or 'FEMALE',
                job = player.job,
                rank = ESX.GetJobs()[player.job].grades[tostring(player.job_grade)].label,
                salary = 200,
                status = ESX.GetPlayerFromIdentifier(identifier) and true or false,
            }
        end



        return {players = options,grades = gradesoption}
    end)

    lib.callback.register('Server:SetPlayerJob', function(source,data)
        local number = string.find(data.id, ':')
        local identifier = data.id:sub(number + 1)
        local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
        
        if xPlayer then
            xPlayer.setJob(data.job, data.grade)
        else

            local affectedRows = MySQL.update.await('UPDATE users SET job = ?, job_grade = ? WHERE identifier = ?', {data.job, data.grade ,data.id})
        end
        return true
    end)


    lib.callback.register('GetNearbyPlayersInfos', function(source,data)
        local options = {}

        for i = 1,#data do
            options[#options + 1] = {
                id = data[i]
                name = 
            }
        end
    end)
    

end
