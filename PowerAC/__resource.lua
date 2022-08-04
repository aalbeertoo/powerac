fx_version 'adamant'

game 'gta5'

description 'Power-AC'

version '1.0'

client_scripts {
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config/clientconfig.lua',
	'anti-cliente.lua'
}
server_scripts {
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config/clientconfig.lua',
	'config/serverconfig.lua',
	'anti-server.lua'
}
server_script 'main.lua'
