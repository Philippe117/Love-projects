
local new = new_function(fonction,"load",-2)
function new.F()
	menu_actif = {}
	pointer = 0
	menu_data = {}

	search_for_menu("Menu")
end
function search_for_menu(lieux)
	local list = love.filesystem.enumerate(lieux)
	for i,h in ipairs(list) do
		menu_data[h] = add_menu(lieux,h)
	end
end
function add_menu(lieux,nom)
	M = {	nom = nom ,
		lieux = lieux }
	if love.filesystem.exists( ""..lieux.."/"..nom.."/scripte" ) then
		local liste = love.filesystem.enumerate(""..lieux.."/"..nom.."/scripte")
		for u,k in ipairs(liste) do
			S = new
			love.filesystem.load(""..lieux.."/"..nom.."/scripte/"..k.."")()
			execute( new.load , new )
		end
	end



	return(M)
end
function create_menu(data)
	local new = { data = data }
	new.bouton = {}
	local list = love.filesystem.enumerate(""..data.lieux.."/"..data.nom.."/bouton")
	for i,h in ipairs(list) do
		table.insert( new.bouton , create_bouton(new,""..data.lieux.."/bouton",h) )
	end

	execute_fonction(menu_created,new)
	return (new)
end
function destroy_menu(menu)
	local id = 0
	for i,h in ipairs(menu_actif) do
		if h == menu then
			id = i
		end
	end
	table.remove( menu_actif , id )
	menu = nil
end
function create_bouton(menu,lieux,nom)
	local new =  { nom = nom , normal = {} , pointer = {} , cliquer = {} , eta = 0 , frame = 1 , color = {255,255,255} }
	num = 1
	while love.filesystem.exists( ""..lieux.."/"..h.nom.."/normal/"..num..".png" ) == true do
		table.insert(new.normal,love.graphics.newImage(""..lieux.."/"..h.nom.."/normal/"..num..".png"))
		num = num+1
	end
	num = 1
	while love.filesystem.exists( ""..lieux.."/"..h.nom.."/normal/"..num..".gif" ) == true do
		table.insert(new.normal,love.graphics.newImage(""..lieux.."/"..h.nom.."/normal/"..num..".gif"))
		new.normal[table.maxn(new.normal)]:setFilter( "nearest","nearest" )
		num = num+1
	end
	num = 1
	while love.filesystem.exists( ""..lieux.."/"..h.nom.."/pointer/"..num..".png" ) == true do
		table.insert(menu,love.graphics.newImage(""..lieux.."/"..h.nom.."/pointer/"..num..".png"))
		num = num+1
	end
	num = 1
	while love.filesystem.exists( ""..lieux.."/"..h.nom.."/pointer/"..num..".gif" ) == true do
		table.insert(new.pointer,love.graphics.newImage(""..lieux.."/"..h.nom.."/pointer/"..num..".gif"))
		new.pointer[table.maxn(new.pointer)]:setFilter( "nearest","nearest" )
		num = num+1
	end
	num = 1
	while love.filesystem.exists( ""..lieux.."/"..h.nom.."/cliquer/"..num..".png" ) == true do
		table.insert(menu,love.graphics.newImage(""..lieux.."/"..h.nom.."/cliquer/"..num..".png"))
		num = num+1
	end
	num = 1
	while love.filesystem.exists( ""..lieux.."/"..h.nom.."/cliquer/"..num..".gif" ) == true do
		table.insert(new.cliquer,love.graphics.newImage(""..lieux.."/"..h.nom.."/cliquer/"..num..".gif"))
		new.cliquer[table.maxn(new.cliquer)]:setFilter( "nearest","nearest" )
		num = num+1
	end

	if love.filesystem.exists( ""..lieux.."/"..h.nom.."/clic.ogg" ) == true then
		new.click = love.audio.newSource( ""..lieux.."/"..h.nom.."/clic.ogg" )
	end
	if love.filesystem.exists( ""..lieux.."/"..h.nom.."/pointe.ogg" ) == true then
		new.pointe = love.audio.newSource( ""..lieux.."/"..h.nom.."/pointe.ogg" )
	end
	if love.filesystem.exists( ""..lieux.."/"..h.nom.."/popup" ) then
		new.popup = {frame = 1 , color = {255,255,255} , app = {} }
		num = 1
		while love.filesystem.exists( ""..lieux.."/"..h.nom.."/popup/"..num..".png" ) == true do
			table.insert(h.popup.app,love.graphics.newImage(""..lieux.."/"..h.nom.."/popup/"..num..".png"))
			num = num+1
		end
		num = 1
		while love.filesystem.exists( ""..lieux.."/"..h.nom.."/popup/"..num..".gif" ) == true do
			table.insert(h.popup.app,love.graphics.newImage(""..lieux.."/"..h.nom.."/popup/"..num..".gif"))
			h.popup.app[table.maxn(h.popup.app)]:setFilter( "nearest","nearest" )
			num = num+1
		end
	end
	if love.filesystem.exists(""..lieux.."/"..h.nom.."/scripte.lua") == true then
		B = new
		love.filesystem.load(""..lieux.."/"..h.nom.."/scripte.lua")()
		check_script(B)
	end

	return (new)
end
local new = new_function(fonction,"MR",0)
function new.F()
	if pointer ~= 0 then
		if pointer.click ~= nil then
			love.audio.stop(pointer.click)
			love.audio.play(pointer.click)
		end
		pointer.eta = 1
		execute(pointer.clic,pointer)
	end

end
local new = new_function(fonction,"update",0)
function new.F()
	pointer = 0
	for e,g in ipairs(menu_actif) do
		for i,h in ipairs(g.bouton) do
			if h.condition() then
				h.condi = true
				if love.mouse.getX() > h.X
				and love.mouse.getX() < h.X+h.normal[1]:getWidth()
				and love.mouse.getY() > h.Y
				and love.mouse.getY() < h.Y+h.normal[1]:getHeight() then
					pointer = h
					if love.mouse.isDown("l") or love.mouse.isDown("r") or love.mouse.isDown("m") then
						h.eta = 2
						h.frame = 1
					else
						if h.eta ~= 1 then
							h.eta = 1
							h.frame = 1
							if h.pointe ~= nil then
								love.audio.stop(h.pointe)
								love.audio.play(h.pointe)
							end
						end
					end
				else
					h.eta = 0
					h.frame = 1
				end
			else
				h.condi = false
			end
		end
	end
end
local new = new_function(fonction,"draw",-5)
function new.F()
	love.graphics.setFont( ff )
	for e,g in ipairs(menu_actif) do
		for i,h in ipairs(g.bouton) do
			if h.condi then
				if h.eta == 0 then
					love.graphics.setColor(255,255,255)
					love.graphics.draw( h.normal[math.floor(h.frame)] ,h.X,h.Y)
					love.graphics.setColor(h.color)
					love.graphics.print( h.text , h.X+2, h.Y , 0 , math.min((h.normal[math.floor(h.frame)]:getWidth()-4)/love.graphics.getFont( ):getWidth( h.text ),(h.normal[math.floor(h.frame)]:getHeight()-12)/love.graphics.getFont( ):getHeight( )))
				elseif h.eta == 1 then
					love.graphics.setColor(255,255,255)
					love.graphics.draw( h.pointer[math.floor(h.frame)] ,h.X,h.Y)
					love.graphics.setColor(h.color)
					love.graphics.print( h.text , h.X+2, h.Y , 0 , math.min((h.pointer[math.floor(h.frame)]:getWidth()-4)/love.graphics.getFont( ):getWidth( h.text ),(h.pointer[math.floor(h.frame)]:getHeight()-12)/love.graphics.getFont( ):getHeight( )))
					if h.popup.text ~= "" then
						love.graphics.setColor(255,255,255)
						love.graphics.setFont( f )
						love.graphics.draw( h.popup.app[h.popup.frame] ,popup.popup.X,popup.popup.Y)
						love.graphics.setColor(h.popup.color)
						love.graphics.printf( h.popup.text , popup.popup.X+4, popup.popup.Y+2 , popup.popup.app[h.popup.frame]:getWidth()-8 , "left" )
					end
				elseif h.eta == 2 then
					love.graphics.setColor(255,255,255)
					love.graphics.draw( h.cliquer[math.floor(h.frame)] ,h.X,h.Y)
					love.graphics.setColor(h.color)
					love.graphics.print( h.text , h.X+2, h.Y , 0 , math.min((h.cliquer[math.floor(h.frame)]:getWidth()-4)/love.graphics.getFont( ):getWidth( h.text ),(h.cliquer[math.floor(h.frame)]:getHeight()-12)/love.graphics.getFont( ):getHeight( )))
				end
			end
		end
	end
end

