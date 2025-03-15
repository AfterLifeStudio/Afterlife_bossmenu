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
        coords = vec3(138.5408, -998.8748, 28.8485)
    },
    {
        id = 'pillbox',
        label = 'Pillbox Hospital',
        description = 'Hospital located near the legion square',
        theme = 'red',
        job = 'ambulance',
        coords = vec3(145.3994, -1000.9869, 29.2590),
        otherjobs = false
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
    bossmenu = 'Open Boss Menu'
}