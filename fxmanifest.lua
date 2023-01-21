fx_version 'cerulean'
game 'gta5'

description 'ESX Sna Fuel'

author 'Sna'

version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    '@es_extended/imports.lua',
	'@es_extended/locale.lua',
	'locales/*.lua',
    'config.lua'
}


server_scripts {
    '@oxmysql/lib/MySQL.lua',
	'server/main.lua'
}

client_scripts {
	'client/main.lua'
}

dependencies {
	'es_extended',
}

lua54 'yes'
