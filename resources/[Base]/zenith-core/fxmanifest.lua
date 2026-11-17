fx_version 'cerulean'
game 'gta5'
author 'david'
version '0.1'
map 'cfx/map.lua'

resource_type 'map' {
    gameTypes = {
        ['Roleplay'] = true
    }
}

shared_scripts {
    'cfx/mapmanager_shared.lua',
    'shared/**/*'
}

client_scripts {
    'c_main.lua',
    'cfx/spawnmanager.lua',
    'cfx/mapmanager_client.lua',
    'client/**/*'
}

server_scripts {
    's_main.lua',
    'cfx/mapmanager_server.lua',
    'server/**/*'
}

ui_page 'zenith-ui/dist/index.html'

files {
    'zenith-ui/dist/**/*',
<<<<<<< HEAD
    'stream/*.*',
=======
>>>>>>> 918d4112a3c3d19b0b3f6825593fb349dd46996c
}

use_experimental_fxv2_oal 'yes'
server_export "getCurrentGameType"
server_export "getCurrentMap"
server_export "changeGameType"
server_export "changeMap"
server_export "doesMapSupportGameType"
server_export "getMaps"
server_export "roundEnded"

resource_type 'gametype' {
    name = 'Roleplay'
}