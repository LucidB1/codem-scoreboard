fx_version 'cerulean'
game 'gta5'
author 'Aiakos#8317'
description 'Codem-ScoreBoard'
version ' https://discord.gg/zj3QsUfxWs '
ui_page {
	'html/index.html',
}
files {
	'html/*.css',
	'html/*.js',
	'html/*.html',
	'html/fonts/*.otf',
	'html/images/*.png',
	'html/images/*.svg',
	

}

shared_script{
	'config.lua',
}

dependencies { 
	'/server:5104',
	'/gameBuild:1868',
	'/onesync',
}

escrow_ignore {
	'config.lua',
	'GetFrameworkObject.lua',
	
}

client_scripts {
	'GetFrameworkObject.lua',
	'client/*.lua',
}
server_scripts {
	'server/*.lua',
	'GetFrameworkObject.lua',
}

lua54 'yes'