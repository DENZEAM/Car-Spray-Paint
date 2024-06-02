fx_version 'cerulean'
game 'gta5'

name "oCarSprayPaint"
description "CarSprayPaint"
author "1"
version "1"

shared_scripts {
    'shared/*.lua',
    'locales/init.lua',
    'locales/en.lua',
    'locales/fr.lua',
    'locales/es.lua',
    'locales/pt.lua',
    'locales/ru.lua',
    'locales/de.lua'
	
}

shared_script '@es_extended/imports.lua'

client_scripts {
	'RageUI/RMenu.lua',
    'RageUI/menu/RageUI.lua',
    'RageUI/menu/Menu.lua',
    'RageUI/menu/MenuController.lua',
    'RageUI/components/*.lua',
    'RageUI/menu/elements/*.lua',
    'RageUI/menu/items/*.lua',
    'RageUI/menu/panels/*.lua',
    'RageUI/menu/windows/*.lua',
	'client/*.lua'
}

server_scripts {
    "webhook.lua",
	'server/*.lua',
}
