function love.load()
	txt = 0
	love.filesystem.load("Integration des scripte.lua" )()
	for i,h in ipairs(fonction.load) do
		h.F()
	end
	love.graphics.setBackgroundColor( 50, 70, 80 )
	croi = load_image("croi.png")
	grille = load_image("grille.png")
	grille:setFilter( "nearest","nearest" )
	f = love.graphics.newFont( 15 )
	ff = love.graphics.newFont( 35 )
	love.graphics.setFont( f )
	fps = 60
	crono = 0

	L = {}


	world = {}
	world.speed = 1
	model_data = load_model("ressource/new model")
	model = create_model(model_data,{ X = 0 , Y = 0 , A = 0 },1)
	moux = 0
	mouy = 0
	menulist = {}
	select = 0
	canselect = 0
	tool = "mouse"
	tool_mode = ""
	set_menu(menu_main)
	menu.load(menu)
	crono = 0
	love.mousepressed( 0, 0, "l" )
	lieux = "mod"
	saving = love.filesystem.newFile(""..lieux.."/scripte.lua")
	sort_func()
end
function love.mousepressed( mx, my, bu )
	if not clavier.actif then
		for i,h in ipairs(fonction.MP) do
			h.F(mx,my,bu)
		end
	end
end
function love.mousereleased( mx, my, bu )
	if not clavier.actif then
		for i,h in ipairs(fonction.MR) do
			h.F(mx,my,bu)
		end
	end
end
function love.keypressed( k )
	if clavier.actif then
		clav_KP(k)
	else
		for i,h in ipairs(fonction.KP) do
			h.F(k)
		end
	end
end
function love.keyreleased( k )
	if not clavier.actif then
		for i,h in ipairs(fonction.KR) do
			h.F(k)
		end
	end
end
function love.update(dot)
	if clavier.actif then
		clavier.crono = clavier.crono+dot
	else
		sort_func()
		crono = crono+dot
		fps = fps+(love.timer.getFPS( )-fps)/50
		for i,h in ipairs(fonction.update) do
			h.F(dot)
		end
	end
end
function love.draw()
	love.graphics.setColor(255,255,255)
	for i,h in ipairs(fonction.draw) do
		h.F()
	end
	--for i,h in ipairs(fonction.load) do
	--	love.graphics.print(h.prio,200,100+30*i)
	--end
	love.graphics.setColor(255,255,255)
	love.graphics.setFont( f )
	love.graphics.print( "fps="..(math.floor(fps*10)/10).." Hz" , 0 , 0 )
	love.graphics.print( "txt="..txt.."" , 0 , 50 )
	love.graphics.print( "save="..love.filesystem.getSaveDirectory( ).."" , 50 , 100 )
--	love.graphics.print( model.temp , 200 , 300 )
	clav_draw()

end
