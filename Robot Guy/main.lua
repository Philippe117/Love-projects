function love.load()
	menulist = {}
	love.window.setFullscreen(true)
	
	local list = love.filesystem.getDirectoryItems("Menu")
	for i,h in ipairs(list) do
		table.insert( menulist , {nom = h} )
	end
	for i,h in ipairs(menulist) do
		_G["menu_"..h.nom..""] = h
		if love.filesystem.exists("Menu/"..h.nom.."/scripte.lua") == true then
			I = h
			love.filesystem.load("Menu/"..h.nom.."/scripte.lua")()
		end
	end
	option = {}
	option.effect = 0



	txt = "non"
	--love.graphics.toggleFullscreen( )
	love.mouse.setVisible( false )
	grille = love.graphics.newImage("grille.png")
	souris = love.graphics.newImage("souris.png")
	souris:setFilter( "nearest","nearest" )
	bouton = {}
	pointer = 0
	sourmode = 0
	letre = love.graphics.newFont( "PIXleft.ttf", 25 )
	chifre = love.graphics.newFont( "pixelsix14.ttf", 36 )
	letre_X = love.graphics.newFont( "PIXleft.ttf", 38 )
	chifre_X = love.graphics.newFont( "pixelsix14.ttf", 50 )
	letre_XX = love.graphics.newFont( "PIXleft.ttf", 60 )
	chifre_XX = love.graphics.newFont( "pixelsix14.ttf", 80 )
	love.graphics.setFont( chifre )
	niv = "niveau 1"
	vie = 5
	santer = 3
	point = 0
	vivant = 1
	gauche = "a"
	droite = "d"
	haut = "w"
	bas = "s"
	saute = "r"
	arme = 1
	set_menu(menu_principal)
	menu.load(menu)
end
function set_menu(newy)
	bouton = {}
	pointer = 0
	if love.filesystem.exists( "Menu/"..newy.nom.."/fon.gif") == true then
		fond = love.graphics.newImage("Menu/"..newy.nom.."/fon.gif")
		fond:setFilter( "nearest","nearest" )
	end
	local list = love.filesystem.getDirectoryItems("Menu/"..newy.nom.."/bouton")
	for new,h in ipairs(list) do
		table.insert( bouton , {nom = h,normal = {},pointer = {},cliquer = {},eta = 0,frame = 1} )
	end
	for new,h in ipairs(bouton) do
		num = 1
		while love.filesystem.exists( "Menu/"..newy.nom.."/bouton/"..h.nom.."/normal/"..num..".gif" ) == true do
			table.insert(h.normal,love.graphics.newImage("Menu/"..newy.nom.."/bouton/"..h.nom.."/normal/"..num..".gif"))
			h.normal[table.maxn(h.normal)]:setFilter( "nearest","nearest" )
			num = num+1
		end
		num = 1
		while love.filesystem.exists( "Menu/"..newy.nom.."/bouton/"..h.nom.."/pointer/"..num..".gif" ) == true do
			table.insert(h.pointer,love.graphics.newImage("Menu/"..newy.nom.."/bouton/"..h.nom.."/pointer/"..num..".gif"))
			h.pointer[table.maxn(h.pointer)]:setFilter( "nearest","nearest" )
			num = num+1
		end
		num = 1
		while love.filesystem.exists( "Menu/"..newy.nom.."/bouton/"..h.nom.."/cliquer/"..num..".gif" ) == true do
			table.insert(h.cliquer,love.graphics.newImage("Menu/"..newy.nom.."/bouton/"..h.nom.."/cliquer/"..num..".gif"))
			h.cliquer[table.maxn(h.cliquer)]:setFilter( "nearest","nearest" )
			num = num+1
		end
		if love.filesystem.exists( "Menu/"..newy.nom.."/bouton/"..h.nom.."/clic.ogg" ) == true then
			h.click = love.audio.newSource( "Menu/"..newy.nom.."/bouton/"..h.nom.."/clic.ogg" )
		end
		if love.filesystem.exists( "Menu/"..newy.nom.."/bouton/"..h.nom.."/pointe.ogg" ) == true then
			h.pointe = love.audio.newSource( "Menu/"..newy.nom.."/bouton/"..h.nom.."/pointe.ogg" )
		end
		if love.filesystem.exists("Menu/"..newy.nom.."/bouton/"..h.nom.."/scripte.lua") == true then
			B = h
			love.filesystem.load("Menu/"..newy.nom.."/bouton/"..h.nom.."/scripte.lua")()
			h.init(h)
		end
	end
	menu = newy
end
function love.mousepressed( mx, my, bu )
	if pointer ~= 0
	and bu == "l" then
		pointer.eta = 2
	end
	menu.MP(menu,mx,my,bu)
end
function love.mousereleased( mx, my, bu )
	if pointer ~= 0
	and bu == "l" then
		if pointer.click ~= nil then
			love.audio.stop(pointer.click)
			love.audio.play(pointer.click)
		end
		pointer.eta = 1
		pointer.clic(pointer)
	end
	menu.MR(menu,mx,my,bu)
end
function love.keypressed( k )
	menu.KP(menu,k)
end
function love.keyreleased( k )
	menu.KR(menu,k)
end
function love.update(dot)
	pointer = 0
	for i,h in ipairs(bouton) do
		if love.mouse.getX() > h.X
		and love.mouse.getX() < h.X+h.normal[1]:getWidth()
		and love.mouse.getY() > h.Y
		and love.mouse.getY() < h.Y+h.normal[1]:getHeight() then
			pointer = h
			if love.mouse.isDown("l") == false then
				if h.eta ~= 1 then
					h.eta = 1
					h.frame = 1
					if h.pointe ~= nil then
						love.audio.stop(h.pointe)
						love.audio.play(h.pointe)
					end
				end
			else
				h.eta = 2
				h.frame = 1
			end
		else
			h.eta = 0
			h.frame = 1
		end
		if h.eta == 0 then
			h.frame = h.frame+.1
			if h.frame >= table.maxn(h.normal)+1 then
				h.frame = 1
			end
		elseif h.eta == 1 then
			h.frame = h.frame+.1
			if h.frame >= table.maxn(h.pointer)+1 then
				h.frame = 1
			end
		elseif h.eta == 2 then
			h.frame = h.frame+.1
			if h.frame >= table.maxn(h.cliquer)+1 then
				h.frame = 1
			end
		end
	end
	menu.update(menu,dot)
end
function love.draw()
	if fond ~= nil then
		love.graphics.draw( fond , 0,0,0,love.graphics.getWidth()/fond:getWidth(),love.graphics.getHeight()/fond:getHeight())
	end
	menu.draw(menu)
	for i,h in ipairs(bouton) do
		if h.eta == 0 then
			love.graphics.draw( h.normal[math.floor(h.frame)] ,h.X,h.Y)
		elseif h.eta == 1 then
			love.graphics.draw( h.pointer[math.floor(h.frame)] ,h.X,h.Y)
		elseif h.eta == 2 then
			love.graphics.draw( h.cliquer[math.floor(h.frame)] ,h.X,h.Y)
		end
	end
	if sourmode == 1 then
		love.graphics.draw( souris ,love.mouse.getX(),love.mouse.getY(),0,2)
	end
	--love.graphics.setFont( letre )
	--love.graphics.print( menu.nom , 520 , 30 )
end
