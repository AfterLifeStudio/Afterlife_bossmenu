if Config.framework == 'qbx' then


  lib.callback.register('GetJobPlayersCount', function(source,job)
      local Players = exports.qbx_core:GetDutyCountJob(job)
      return Players
  end)

  lib.callback.register('GetJobPlayers', function(source,job)

      local Players = exports.qbx_core:GetGroupMembers(job, 'job')


      local qbxgrades = exports.qbx_core:GetJob(job)
      local gradesoption = {}

      for k,v in pairs(qbxgrades.grades) do
          gradesoption[#gradesoption + 1] = {
              label = v.label,
              id = k
          }
      end

      local options = {}

      for i = 1, #Players do
          local citizenid = Players[i].citizenid
          local player = exports.qbx_core:GetPlayerByCitizenId(citizenid) or exports.qbx_core:GetOfflinePlayer(citizenid)

          options[#options + 1] = {
              id = citizenid,
              name = player.PlayerData.charinfo.firstname..' '..player.PlayerData.charinfo.lastname;
              gender = player.PlayerData.charinfo == 1 and 'MALE' or 'FEMALE',
              job = job,
              rank = player.PlayerData.job.grade.name,
              salary = 200,
              status = player.Offline and false or true,
          }
      end



      return {players = options,grades = gradesoption}
  end)

  lib.callback.register('Server:SetPlayerJob', function(source,data)
      exports.qbx_core:AddPlayerToJob(data.id, data.job, data.grade)
      return true
  end)



  lib.callback.register('Server:HirePlayer', function(source,data)
    exports.qbx_core:AddPlayerToJob(data.id, data.job, 0)
      return true
  end)


  lib.callback.register('GetNearbyPlayersInfos', function(source,data)
      local options = {}

      for i = 1,#data do
          local Player = exports.qbx_core:GetPlayer(data[i])

          options[#options + 1] = {
              id = data[i],
              name = Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname;
          }
      end

      return options
  end)


  GetPlayerCash = function (source)
      local Player = exports.qbx_core:GetPlayer(source)
      local cash = Player.PlayerData.money.cash
      return cash
  end

  AddPlayerCash = function (source,amount)
    local citizenid = exports.qbx_core:GetPlayer(source).PlayerData.citizenid
    exports.qbx_core:AddMoney(citizenid, 'cash', amount, 'Job Account withdraw')
  end

  RemovePlayerCash = function (source,amount)
    local citizenid = exports.qbx_core:GetPlayer(source).PlayerData.citizenid
    exports.qbx_core:RemoveMoney(citizenid, 'cash', amount, 'Job Account Deposit')
  end
  
    
end
