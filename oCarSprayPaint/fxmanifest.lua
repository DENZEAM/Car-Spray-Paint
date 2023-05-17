fx_version 'cerulean'
game 'gta5'

name "dBombeDePeinture"
description "Bombe de peinture script"
author "1"
version "1"

shared_scripts {
	'shared/*.lua'
}

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
	'server/*.lua',
    "webhook.lua"
}
