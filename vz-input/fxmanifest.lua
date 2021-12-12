fx_version 'bodacious'
game 'gta5'

author 'Vayzup input'
description 'A input module'
version '1.0.0'

client_script {
    'client.lua',
}
ui_page "html/index.html"

files {
	"html/index.html",
	"html/index.js",
	"html/index.css",
	"html/reset.css"
}
exports {'AddInput'}