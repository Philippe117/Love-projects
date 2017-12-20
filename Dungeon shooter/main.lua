function love.load()

	souris = love.graphics.newImage("souris.png")
	shade = love.graphics.newImage("shade.png")
	lum = love.graphics.newImage("lum.png")

	menulist = {}
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
	txt = "non"
	love.window.setFullscreen( true )
	love.mouse.setVisible( false )

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
		--{ x ,y , m , n , A , tipe , maitre , mode , }
	local list = love.filesystem.getDirectoryItems("Data/Missi")                       -- missilist
	for i,h in ipairs(list) do
		_G["missi_"..h..""] = {nom = h}
		T = _G["missi_"..h..""]
		love.filesystem.load("Data/Missi/"..h.."/scripte.lua")()
		_G["missi_"..h..""].init(_G["missi_"..h..""])
		local list = love.filesystem.getDirectoryItems("Data/Missi/"..h.."/model")
		for e,g in ipairs(list) do
			_G["missi_"..h.."_anim_"..g..""] = {}
			num = 1
			while love.filesystem.exists( "Data/Missi/"..h.."/model/"..g.."/"..num..".png" ) == true do
				_G["missi_"..h.."_anim_"..g..""][num] = {image = love.graphics.newImage("Data/Missi/"..h.."/model/"..g.."/"..num..".png")}
				if love.filesystem.exists( "Data/Missi/"..h.."/model/"..g.."/"..num..".ogg") == true then
					_G["missi_"..h.."_anim_"..g..""][num].son = love.sound.newSoundData( "Data/Missi/"..h.."/model/"..g.."/"..num..".ogg" )
					_G["missi_"..h.."_anim_"..g..""][num].temposon = 0
				end
				num = num+1
			end
			S = _G["missi_"..h.."_anim_"..g..""]
		end
	end
	T = nil
	local list = love.filesystem.getDirectoryItems("Data/Effet")                       -- effet
	for i,h in ipairs(list) do
		_G["effet_"..h..""] = {nom = h}
		E = _G["effet_"..h..""]
		love.filesystem.load("Data/Effet/"..h.."/Proprieter.lua")()
		num = 1
		_G["effet_"..h..""].sprite = {}
		while love.filesystem.exists( "Data/Effet/"..h.."/"..num..".png" ) == true do
			_G["effet_"..h..""].sprite[num] = {image = love.graphics.newImage("Data/Effet/"..h.."/"..num..".png")}
			if love.filesystem.exists( "Data/Effet/"..h.."/"..num..".ogg") == true then
				_G["effet_"..h..""].sprite[num].son = love.sound.newSoundData( "Data/Effet/"..h.."/"..num..".ogg" )
				_G["effet_"..h..""].sprite[num].temposon = 0
			end
			num = num+1
		end
		S = _G["effet_"..h..""]
	end
		--{ x , y , m , n , A , tipe , equipe , mode , }
	local list = love.filesystem.getDirectoryItems("Data/Unit")                      --unitlist
	for i,h in ipairs(list) do
		_G["unit_"..h..""] = {	nom = h}
		T = _G["unit_"..h..""]
		love.filesystem.load("Data/Unit/"..h.."/scripte.lua")()
		_G["unit_"..h..""].init(_G["unit_"..h..""])
		local list = love.filesystem.getDirectoryItems("Data/Unit/"..h.."/model")
		for e,g in ipairs(list) do
			_G["unit_"..h.."_anim_"..g..""] = {}
			num = 1
			while love.filesystem.exists( "Data/Unit/"..h.."/model/"..g.."/"..num..".png" ) == true do
				_G["unit_"..h.."_anim_"..g..""][num] = {image = love.graphics.newImage("Data/Unit/"..h.."/model/"..g.."/"..num..".png")}
				if love.filesystem.exists( "Data/Unit/"..h.."/model/"..g.."/"..num..".ogg") == true then
					_G["unit_"..h.."_anim_"..g..""][num].son = love.sound.newSoundData( "Data/Unit/"..h.."/model/"..g.."/"..num..".ogg" )
					_G["unit_"..h.."_anim_"..g..""][num].temposon = 0
				end
				num = num+1
			end
			S = _G["unit_"..h.."_anim_"..g..""]
			love.filesystem.load("Data/Unit/"..h.."/model/"..g.."/prop.lua")()
		end
	end
	T = nil
	objet = {}
		--{ x , y , m , n , A ,	 }
	local list = love.filesystem.getDirectoryItems("Data/Objet")                       --objlist
	for i,h in ipairs(list) do
		_G["objet_"..h..""] = {nom = h}
		T = _G["objet_"..h..""]
		love.filesystem.load("Data/Objet/"..h.."/scripte.lua")()
		_G["objet_"..h..""].init(_G["objet_"..h..""])
		local list = love.filesystem.getDirectoryItems("Data/Objet/"..h.."/model")
		for e,g in ipairs(list) do
			_G["objet_"..h.."_anim_"..g..""] = {}
			num = 1
			while love.filesystem.exists( "Data/Objet/"..h.."/model/"..g.."/"..num..".png" ) == true do
				_G["objet_"..h.."_anim_"..g..""][num] = {image = love.graphics.newImage("Data/Objet/"..h.."/model/"..g.."/"..num..".png")}
				if love.filesystem.exists( "Data/Objet/"..h.."/model/"..g.."/"..num..".ogg") == true then
					_G["objet_"..h.."_anim_"..g..""][num].son = love.sound.newSoundData( "Data/Objet/"..h.."/model/"..g.."/"..num..".ogg" )
					_G["objet_"..h.."_anim_"..g..""][num].temposon = 0
				end
				num = num+1
			end
			S = _G["objet_"..h.."_anim_"..g..""]
			love.filesystem.load("Data/Objet/"..h.."/model/"..g.."/prop.lua")()
		end
	end
	T = nil
	set_menu(menu_play)
	menu.load(menu)
end
function set_menu(newy)
	bouton = {}
	pointer = 0
	if love.filesystem.exists( "Menu/"..newy.nom.."/fon.png") == true then
		fond = love.graphics.newImage("Menu/"..newy.nom.."/fon.png")
	end
	local list = love.filesystem.getDirectoryItems("Menu/"..newy.nom.."/bouton")
	for new,h in ipairs(list) do
		table.insert( bouton , {nom = h,normal = {},pointer = {},cliquer = {},eta = 0,frame = 1} )
	end
	for new,h in ipairs(bouton) do
		num = 1
		while love.filesystem.exists( "Menu/"..newy.nom.."/bouton/"..h.nom.."/normal/"..num..".png" ) == true do
			table.insert(h.normal,love.graphics.newImage("Menu/"..newy.nom.."/bouton/"..h.nom.."/normal/"..num..".png"))
			num = num+1
		end
		num = 1
		while love.filesystem.exists( "Menu/"..newy.nom.."/bouton/"..h.nom.."/pointer/"..num..".png" ) == true do
			table.insert(h.pointer,love.graphics.newImage("Menu/"..newy.nom.."/bouton/"..h.nom.."/pointer/"..num..".png"))
			num = num+1
		end
		num = 1
		while love.filesystem.exists( "Menu/"..newy.nom.."/bouton/"..h.nom.."/cliquer/"..num..".png" ) == true do
			table.insert(h.cliquer,love.graphics.newImage("Menu/"..newy.nom.."/bouton/"..h.nom.."/cliquer/"..num..".png"))
			num = num+1
		end
		if love.filesystem.exists( "Menu/"..newy.nom.."/bouton/"..h.nom.."/clic.ogg" ) == true then
			h.click = love.sound.newSoundData( "Menu/"..newy.nom.."/bouton/"..h.nom.."/clic.ogg" )
		end
		if love.filesystem.exists( "Menu/"..newy.nom.."/bouton/"..h.nom.."/pointe.ogg" ) == true then
			h.pointe = love.sound.newSoundData( "Menu/"..newy.nom.."/bouton/"..h.nom.."/pointe.ogg" )
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
end
