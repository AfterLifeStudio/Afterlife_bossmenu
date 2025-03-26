Config = {}

GetFramework = function()
    if GetResourceState('es_extended') ~= 'missing' then
        return 'esx'
    elseif GetResourceState('qbx_core') ~= 'missing' then
        return 'qbx'
    elseif GetResourceState('qb-core') ~= 'missing' then
        return 'qb'
    end
end

Config.framework = GetFramework() -- qb / esx /qbox




Config.locations = {
    {
        id = 'mrpd',
        label = 'Mission Row',
        description = 'Police department located nearthe legion square',
        job = 'police',
        joblabel = 'LSPD',
        theme = 'blue',
        otherjobs = {
            {
                job = 'ambulance',
                label = 'EMS'
            }
        },
        coords = vec3(447.8925, -973.2505, 30.6896)
    },
    {
        id = 'pillbox',
        label = 'PillBox Hospital',
        description = 'Hospital located nearthe legion square',
        job = 'ambulance',
        joblabel = 'EMT',
        theme = 'red',
        otherjobs = {
            {
                job = 'police',
                label = 'LSPD'
            }
        },
        coords = vec3(243.5401, -1370.1699, 39.5343)
    }
}
Config.themes = {
    ['blue'] = {
        background = '#08121f',
        maincolor = '#316BC2',
        lightmaincolor = '#aaccff',
        blackhighlight = 'rgba(0, 0, 0, 0.192)',
        white = 'rgba(255, 255, 255, 0.8)',
        gradient = 'linear-gradient(145deg, rgba(23, 51, 92) 0%, rgba(49, 107, 194) 100%)',
        gradient2 = 'linear-gradient(145deg, rgba(23, 51, 92,.4) 0%, rgba(49, 107, 194,.4) 100%)',
    },
    ['red'] = {
        background = '#0e0e0e',
        maincolor = '#c43636',
        lightmaincolor = '#f59292',
        blackhighlight = 'rgba(0, 0, 0, 0.192)',
        white = 'rgba(255, 255, 255, 0.8)',
        gradient = 'linear-gradient(145deg, rgba(71, 24, 24, 1) 0%, rgba(161, 32, 32, 1) 100%)',
        gradient2 = 'linear-gradient(145deg, rgba(71, 24, 24, 0.4) 0%, rgba(161, 32, 32, 0.4) 100%)',
    }
}

Config.Lang = {
    bossmenu = '[E] Boss Menu'
}