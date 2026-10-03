fx_version 'cerulean'
game 'gta5'

description 'Billing System for ESX Legacy'
version '1.0.0'

author 'EnderDevelopment'

dependency 'es_extended'

client_scripts {
    'client.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server.lua'
}

shared_scripts {
    'config.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/script.js',
    'html/style.css',
    'html/logo.png'
}