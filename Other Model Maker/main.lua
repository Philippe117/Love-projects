function love.load()
	time = love.timer.getTime()
	love.filesystem.load("erreur.lua" )()
	--love.graphics.toggleFullscreen( )
	world = {}
	world.speed = 1
	txt = 0
	txt2 = 0
	f = love.graphics.newFont( 15 )
	ff = love.graphics.newFont( 40 )
	love.filesystem.load("Integration des scripte.lua" )()
	search_script( "scripte" )
	sort_func()
	execute_fonction( fonction.load )

	rapporter_erreur( "(------------(  chargement terminer en : "..love.timer.getTime().." s  )------------)")
	love.graphics.setBackgroundColor( 50, 70, 80 )
	croi = load_image("croi.png")
	grille = load_image("grille.png")
	grille:setFilter( "nearest","nearest" )
	fps = 60
	chrono = 0
	rapporter_erreur( "execution des fonctions start")
	execute_fonction( fonction.start )
	load_menu("Menu","création_dos")
	rapporter_erreur( "(------------(  démarage de la partie à : "..love.timer.getTime().." s  )------------)")
end
function love.mousepressed( mx, my, bu )
	if not clavier.actif then
		if fonction.MP then
			for i,h in ipairs(fonction.MP) do
				h.F(mx,my,bu)
			end
		end
	end
end
function love.mousereleased( mx, my, bu )
	if not clavier.actif then
		if fonction.MR then
			for i,h in ipairs(fonction.MR) do
				h.F(mx,my,bu)
			end
		end
	end
end
function love.keypressed( k )
	if clavier.actif then
		clav_KP(k)
	elseif fonction.KP then
		for i,h in ipairs(fonction.KP) do
			h.F(k)
		end
	end
end
function love.keyreleased( k )
	if not clavier.actif then
		if fonction.KR then
			for i,h in ipairs(fonction.KR) do
				h.F(k)
			end
		end
	end
end
function love.update(dot)
	if clavier.actif then
		clavier.crono = clavier.crono+dot
	else
		sort_func()
		chrono = chrono+dot
		fps = fps+(love.timer.getFPS( )-fps)/50
		if fonction.update then
			for i,h in ipairs(fonction.update) do
				h.F(dot)
			end
		end
	end
end
function love.draw()
	love.graphics.setColor(255,255,255)
	if fonction.draw then
		for i,h in ipairs(fonction.draw) do
			h.F()
		end
	end
	love.graphics.setColor(255,255,255)
	love.graphics.setFont( f )
	love.graphics.print( "fps="..(math.floor(fps*10)/10).." Hz" , 0 , 0 )
	love.graphics.print( "txt="..txt.."" , 0 , 50 )
	love.graphics.print( "txt2="..txt2.."" , 0 , 80 )
	clav_draw()

end
