fx_version 'bodacious'
game 'gta5'

lua54 'yes'

description 'Market FREE V1'

Author 'IF DEVELOPMENTS'

shared_script 'config.lua'
client_script 'client/main.lua'
server_script 'server/main.lua'

ui_page{
    'html/index.html'
}
files {
    'html/index.html',
    'html/js/*.js',
    'html/style.css',
    'html/img/*.png',
    'html/fonts/*.otf',
    'html/fonts/*.woff',
}

escrow_ignore {
    'config.lua'
}