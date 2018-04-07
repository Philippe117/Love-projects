function love.load()
	--love.window.setFullscreen( false )
	rien = love.graphics.newImage("rien.gif")
	scripte = {}
	local list = love.filesystem.getDirectoryItems("scripte")
	for i,h in ipairs(list) do
		table.insert( scripte , {nom = h} )
		love.filesystem.load("scripte/"..h.."" )()
	end
	model_load()
	map_load()

	menu_load()

	inter_power_X = 375
	inter_power_Y = love.graphics.getHeight()-320

	icon_X = 285
	icon_Y = love.graphics.getHeight()-240

	inter_liste_X = 640
	inter_liste_Y = love.graphics.getHeight()-60

	minimap_X = 10
	minimap_Y = love.graphics.getHeight()-270
	minimap_sise = 260


	point = love.graphics.newImage("point.png")

	f = love.graphics.newFont( 15 )
	ff = love.graphics.newFont( 40 )


	fps = 60

	set_menu(menu_play)



	dot = 1/60
	txt = 0
end



function love.mousepressed( mx, my, bu )


	menu_MP(mx,my,bu)
end
function love.mousereleased( mx, my, bu )


	menu_MR(mx,my,bu)
end
function love.keypressed( k )


	menu_KP(k)
end
function love.keyreleased( k )


	menu_KR(k)
end






function love.update(dt)


	fps = fps+.01*((1/dot)-fps)


	menu_update(dot)




end
function love.draw()

	menu_draw()
	love.graphics.setColor(255,255,255)
	love.graphics.print( "txt"..txt.."" , 10 , 50 )
	love.graphics.print( "("..love.mouse.getX()..","..love.graphics.getHeight()-love.mouse.getY()..")" , 10 , 200 )
	love.graphics.print( longeur_ligne , 10 , 100 )
	love.graphics.print( longeur_ligne_total , 10 , 150 )
end
