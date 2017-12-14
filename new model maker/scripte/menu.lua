nom = "menu"
S.load = {prio = 2}
function S.load.F()
	menulist = {}
	local list = love.filesystem.getDirectoryItems("Menu")
	for i,h in ipairs(list) do
		table.insert( menulist , {nom = h} )
	end
	local list = {}
	for i,h in ipairs(menulist) do
		_G["menu_"..h.nom..""] = h
		if love.filesystem.exists("Menu/"..h.nom.."/scripte.lua") == true then
			I = h
			love.filesystem.load("Menu/"..h.nom.."/scripte.lua")()
		end
	end
	for i,h in ipairs(menulist) do
		if h.load ~= nil then
			h.load(H)
		end
	end
end
function set_menu(newy)
	bouton = {}
	pointer = 0
	if love.filesystem.exists( "Menu/"..newy.nom.."/fon.png") == true then
		fond = love.graphics.newImage("Menu/"..newy.nom.."/fon.png")
		fond:setFilter( "nearest","nearest" )
	end
	load_bouton("Menu/"..newy.nom.."/bouton")
	menu = newy
	menu.demare()
end

function load_bouton(lieux)


	local list = love.filesystem.getDirectoryItems(""..lieux.."")
	for new,h in ipairs(list) do
		table.insert( bouton , {nom = h,condi = true,normal = {},pointer = {},cliquer = {},eta = 0,frame = 1 } )
	end
	for new,h in ipairs(bouton) do
		num = 1
		while love.filesystem.exists( ""..lieux.."/"..h.nom.."/normal/"..num..".png" ) == true do
			table.insert(h.normal,love.graphics.newImage(""..lieux.."/"..h.nom.."/normal/"..num..".png"))
			h.normal[table.maxn(h.normal)]:setFilter( "nearest","nearest" )
			num = num+1
		end
		num = 1
		while love.filesystem.exists( ""..lieux.."/"..h.nom.."/pointer/"..num..".png" ) == true do
			table.insert(h.pointer,love.graphics.newImage(""..lieux.."/"..h.nom.."/pointer/"..num..".png"))
			h.pointer[table.maxn(h.pointer)]:setFilter( "nearest","nearest" )
			num = num+1
		end
		num = 1
		while love.filesystem.exists( ""..lieux.."/"..h.nom.."/cliquer/"..num..".png" ) == true do
			table.insert(h.cliquer,love.graphics.newImage(""..lieux.."/"..h.nom.."/cliquer/"..num..".png"))
			h.cliquer[table.maxn(h.cliquer)]:setFilter( "nearest","nearest" )
			num = num+1
		end
		if love.filesystem.exists( ""..lieux.."/"..h.nom.."/clic.ogg" ) == true then
			h.click = love.audio.newSource( ""..lieux.."/"..h.nom.."/clic.ogg" )
		end
		if love.filesystem.exists( ""..lieux.."/"..h.nom.."/pointe.ogg" ) == true then
			h.pointe = love.audio.newSource( ""..lieux.."/"..h.nom.."/pointe.ogg" )
		end
		if love.filesystem.exists(""..lieux.."/"..h.nom.."/scripte.lua") == true then
			B = h
			love.filesystem.load(""..lieux.."/"..h.nom.."/scripte.lua")()
			h.init(h)
		end
		if love.filesystem.exists( ""..lieux.."/"..h.nom.."/popup" ) == true
		and h.popup ~= nil then
			h.popup.app = {}
			num = 1
			while love.filesystem.exists( ""..lieux.."/"..h.nom.."/popup/"..num..".png" ) == true do
				table.insert(h.popup.app,love.graphics.newImage(""..lieux.."/"..h.nom.."/popup/"..num..".png"))
				h.popup.app[table.maxn(h.popup.app)]:setFilter( "nearest","nearest" )
				num = num+1
			end
		end
	end








end
S.MP = {prio = 0}
function S.MP.F(mx,my,bu)
	if pointer ~= 0
	and pointer.autre ~= nil then
		pointer.autre(pointer,bu)
	end
	menu.MP(menu,mx,my,bu)
end
S.MR = {prio = 0}
function S.MR.F(mx,my,bu)
	if bu == "l" then
		if pointer ~= 0 then
			if pointer.click ~= nil then
				love.audio.stop(pointer.click)
				love.audio.play(pointer.click)
			end
			pointer.eta = 1
			pointer.clic_gauche(pointer)
		end
	elseif bu == "r" then
		if pointer ~= 0 then
			if pointer.click ~= nil then
				love.audio.stop(pointer.click)
				love.audio.play(pointer.click)
			end
			pointer.eta = 1
			pointer.clic_droit(pointer)
		end
	end




	menu.MR(menu,mx,my,bu)
end
S.KP = {prio = 0}
function S.KP.F(k)
txt = 3468
	menu.KP(menu,k)
end
S.KR = {prio = 0}
function S.KR.F(k)
	menu.KR(menu,k)
end
S.update = {prio = 0}
function S.update.F(dot)
--	if popup ~= nil
--	and love.mouse.getX() > popup.popup.X
--	and love.mouse.getX() < popup.popup.X+popup.popup.app[1]:getWidth()
--	and love.mouse.getY() > popup.popup.Y
--	and love.mouse.getY() < popup.popup.Y+popup.popup.app[1]:getHeight() then
--		popup.update_popup(popup)
--
--	else
		popup = nil
		pointer = 0
		for i,h in ipairs(bouton) do

			if h.condition ~= nil then
				h.condi = h.condition(h)
			end
			if h.update ~= nil then
				h.update(h,dot)
			end


			if h.condi == true then
				if love.mouse.getX() > h.X
				and love.mouse.getX() < h.X+h.normal[1]:getWidth()
				and love.mouse.getY() > h.Y
				and love.mouse.getY() < h.Y+h.normal[1]:getHeight() then
					if pointer ~= 0 then
						pointer.eta = 0
					end
					pointer = h
					if love.mouse.isDown("l") == false
					and love.mouse.isDown("r") == false then
						if h.eta ~= 1 then
							h.eta = 1
						--	h.frame = 1
							if h.pointe ~= nil then
								love.audio.stop(h.pointe)
								love.audio.play(h.pointe)
							end
						end
					else
						h.eta = 2
					--	h.frame = 1
					end
					if h.popup ~= nil then
						if popup == nil then
							popup = h
						end
						if popup.update_popup ~= nil then
							popup.update_popup(popup)
						end
					end
				else
					h.eta = 0
					--h.frame = 1
				end
				--if h.eta == 0 then
				--	h.frame = h.frame+.1
				--	if h.frame >= table.maxn(h.normal)+1 then
				--		h.frame = 1
				--	end
				--elseif h.eta == 1 then
				--	h.frame = h.frame+.1
				--	if h.frame >= table.maxn(h.pointer)+1 then
				--		h.frame = 1
				--	end
				--elseif h.eta == 2 then
				--	h.frame = h.frame+.1
				--	if h.frame >= table.maxn(h.cliquer)+1 then
				--		h.frame = 1
				--	end
				--end
			end
		end
--	end
	menu.update(menu,dot)
end
S.draw = {prio = 0}
function S.draw.F()
	love.graphics.setColor(255,255,255)
	if fond ~= nil then
		love.graphics.draw( fond , 0,0,0,love.graphics.getWidth()/fond:getWidth(),love.graphics.getHeight()/fond:getHeight())
	end
	love.graphics.setColor(255,255,255)
	menu.draw(menu)
	love.graphics.setColor(255,255,255)
	love.graphics.setFont( ff )
	for i,h in ipairs(bouton) do
		if h.condi == true then
			if h.eta == 0 then
				love.graphics.setColor(255,255,255)
				love.graphics.draw( h.normal[math.floor(h.frame)] ,h.X,h.Y)
				love.graphics.setColor(255,255,255)
				love.graphics.print( h.text , h.X+2, h.Y , 0 , math.min((h.normal[math.floor(h.frame)]:getWidth()-2)/love.graphics.getFont( ):getWidth( h.text ),(h.normal[math.floor(h.frame)]:getHeight()-2)/love.graphics.getFont( ):getHeight( )))
			elseif h.eta == 1 then
				love.graphics.setColor(255,255,255)
				love.graphics.draw( h.pointer[math.floor(h.frame)] ,h.X,h.Y)
				love.graphics.setColor(255,255,255)
				love.graphics.print( h.text , h.X+2, h.Y , 0 , math.min((h.pointer[math.floor(h.frame)]:getWidth()-2)/love.graphics.getFont( ):getWidth( h.text ),(h.pointer[math.floor(h.frame)]:getHeight()-2)/love.graphics.getFont( ):getHeight( )))
			elseif h.eta == 2 then
				love.graphics.setColor(255,255,255)
				love.graphics.draw( h.cliquer[math.floor(h.frame)] ,h.X,h.Y)
				love.graphics.setColor(255,255,255)
				love.graphics.print( h.text , h.X+2, h.Y , 0 , math.min((h.cliquer[math.floor(h.frame)]:getWidth()-2)/love.graphics.getFont( ):getWidth( h.text ),(h.cliquer[math.floor(h.frame)]:getHeight()-2)/love.graphics.getFont( ):getHeight( )))
			end
		end
	end
	if popup ~= nil
	and popup.popup.text ~= "" then
		love.graphics.setColor(255,255,255)
		love.graphics.setFont( f )
		love.graphics.draw( popup.popup.app[1] ,popup.popup.X,popup.popup.Y)
		love.graphics.setColor(0,0,0)
		love.graphics.printf( popup.popup.text , popup.popup.X+4, popup.popup.Y+2 , popup.popup.app[1]:getWidth()-8 , "left" )
	end
end
