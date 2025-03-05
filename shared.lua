Config = {}

GetFramework = function()
    if GetResourceState('es_extended') ~= 'missing' then
        return 'esx'
    elseif GetResourceState('qb-core') ~= 'missing' then
        return 'qb'
    else
        return 'qbx'
    end
end

Config.framework = GetFramework() -- qb / esx /qbox




Config.locations = {
    {
        id = 'mr',
        label = 'Mission Row',
        description = 'Police department located nearthe legion square',
        job = 'police',
        coords = vec3(138.5408, -998.8748, 28.8485)
    }  ,
    {
        id = 'mr',
        label = 'Mission Row',
        description = 'Police department located nearthe legion square',
        job = 'ambulance',
        coords = vec3(138.5408, -998.8748, 28.8485)
    }
}





Config.Lang = {
    bossmenu = 'Open Boss Menu'
}