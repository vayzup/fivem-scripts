fx_version 'bodacious'
game 'gta5'

author 'MultiNitro'
version '1.0.0'

dependencies {
    "PolyZone"
}

client_script {
    'shared.lua',
    'client.lua',
	'@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',

}

server_script {
    'shared.lua',
	'server.lua',
}
ui_page "html/index.html"

files {
	"html/index.html",
	"html/index.js",
	"html/index.css",
	"html/reset.css"
}