function love.load()
	time = love.timer.getTime()
	--love.graphics.toggleFullscreen( )
	love.filesystem.load("erreur.lua" )()
	world = {}
	world.speed = 1
	txt = 0
	f = love.graphics.newFont( 15 )
	ff = love.graphics.newFont( 40 )
	love.filesystem.load("Integration des scripte.lua" )()
	search_script( "scripte" )
	sort_func()
	execute_fonction( fonction.load )
	restart()
	create_menu(menu_data.menu_play)
	crono = 0
	cycle = 0
	rapporter_erreur( "(------------(  chargement terminer en : "..love.timer.getTime().." s  )------------)")
end
function restart()
	execute_fonction(fonction.start)
end
function love.mousepressed( mx, my, bu )
	execute_fonction(fonction.MP,mx, my, bu)
end
function love.mousereleased( mx, my, bu )
	execute_fonction(fonction.MR,mx, my, bu)
end
function love.keypressed( k )
	execute_fonction(fonction.KP,k)
end
function love.keyreleased( k )
	execute_fonction(fonction.KR,k)
end
function love.update(dot)
	if crono == 0 then
		crono = crono+.05
	else
		crono = crono+dot
	end
	execute_fonction(fonction.update,dot)
	cycle = cycle+1
end
function love.draw()
	execute_fonction(fonction.draw)
	love.graphics.setColor(255,255,255)
	love.graphics.print( "fps="..(math.floor(100*love.timer.getFPS())/100).."" , 10 , 10 )
	love.graphics.print( "txt="..txt.."" , 10 , 50 )
end
