function I.load(I)
	sourmode = 1
	nivlist = {}
	pointerb = 0
	men = love.graphics.newFramebuffer( )
	bouton_normal = {}
	num = 1
	while love.filesystem.exists( "Menu/Selection_de_niveau/normal/"..num..".gif" ) == true do
		table.insert(bouton_normal,love.graphics.newImage("Menu/Selection_de_niveau/normal/"..num..".gif"))
		bouton_normal[table.maxn(bouton_normal)]:setFilter( "nearest","nearest" )
		num = num+1
	end
	bouton_pointer = {}
	num = 1
	while love.filesystem.exists( "Menu/Selection_de_niveau/pointer/"..num..".gif" ) == true do
		table.insert(bouton_pointer,love.graphics.newImage("Menu/Selection_de_niveau/pointer/"..num..".gif"))
		bouton_pointer[table.maxn(bouton_pointer)]:setFilter( "nearest","nearest" )
		num = num+1
	end

	bouton_cliquer = {}
	num = 1
	while love.filesystem.exists( "Menu/Selection_de_niveau/cliquer/"..num..".gif" ) == true do
		table.insert(bouton_cliquer,love.graphics.newImage("Menu/Selection_de_niveau/cliquer/"..num..".gif"))
		bouton_cliquer[table.maxn(bouton_cliquer)]:setFilter( "nearest","nearest" )
		num = num+1
	end
	local list = love.filesystem.enumerate("carte")

	while table.maxn(nivlist) < 12 do
		for new,h in ipairs(list) do
			table.insert( nivlist , {nome = h , eta = 0 , frame = 1} )
		end
	end

	for new,h in ipairs(nivlist) do
		if love.filesystem.exists("carte/"..h.nome.."/caract.lua") == true then
			M = h
			love.filesystem.load("carte/"..h.nome.."/caract.lua")()
			h.caract(h)
		end
	end
	tempocam = 0
	cam_y = 0
	cam_y2 = 0
	cadre = love.graphics.newImage("Menu/Selection_de_niveau/menu.gif")
	cadre:setFilter( "nearest","nearest" )
	cadre2 = love.graphics.newImage("Menu/Selection_de_niveau/menu2.gif")
	cadre2:setFilter( "nearest","nearest" )
	x = 50--love.graphics.getWidth()-300
	y = love.graphics.getHeight()/2-325
	crono = 0


end
function I.deload(I)


end
function I.MP(I,mx,my,bu)
	if bu == "l" then
		if pointerb ~= 0 then
			pointerb.eta = 2
		end
	elseif bu == "wu" then
		cam_y2 = cam_y2+65
	elseif bu == "wd" then
		cam_y2 = cam_y2-65
	end
end
function I.MR(I,mx,my,bu)
	if pointerb ~= 0
	and bu == "l" then
		--if pointerb.click ~= nil then
		--	love.audio.stop(pointerb.click)
		--	love.audio.play(pointerb.click)
		--end
		pointerb.eta = 1
		niv = pointerb.nome
		set_menu(menu_preparation)
		menu.load(menu)

	end
end
function I.KP(I,k)

	if k == "up" then
		cam_y2 = cam_y2+65
		tempocam = crono+.3
	elseif k == "down" then
		cam_y2 = cam_y2-65
		tempocam = crono+.3
	end

end
function I.KR(I,k)

end
function I.update(I,dot)
	crono = crono+dot


	if tempocam < crono then
		if love.keyboard.isDown("up") then
			cam_y2 = cam_y2+65
			tempocam = crono+.1
		end
		if love.keyboard.isDown("down") then
			cam_y2 = cam_y2-65
			tempocam = crono+.1
		end
	end

	cam_y = cam_y+.1*(cam_y2-cam_y)
	pointerb = 0
	for i,h in ipairs(nivlist) do


		if love.mouse.getX() > x
		and love.mouse.getX() < x+bouton_normal[1]:getWidth()
		and love.mouse.getY() > (y+(i*65-cam_y-(table.maxn(nivlist)*65)*math.floor((i*65-cam_y)/(table.maxn(nivlist)*65))-65))
		and love.mouse.getY() > y
		and love.mouse.getY() < y+650

		and love.mouse.getY() < (y+(i*65-cam_y-(table.maxn(nivlist)*65)*math.floor((i*65-cam_y)/(table.maxn(nivlist)*65))-65))+bouton_normal[1]:getHeight() then
			pointerb = h
			if love.mouse.isDown("l") == false then
				if h.eta ~= 1 then
					h.eta = 1
					h.frame = 1
					--if h.pointe ~= nil then
					--	love.audio.stop(h.pointe)
					--	love.audio.play(h.pointe)
					--end
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
			if h.frame >= table.maxn(bouton_normal)+1 then
				h.frame = 1
			end
		elseif h.eta == 1 then
			h.frame = h.frame+.1
			if h.frame >= table.maxn(bouton_pointer)+1 then
				h.frame = 1
			end
		elseif h.eta == 2 then
			h.frame = h.frame+.1
			if h.frame >= table.maxn(bouton_cliquer)+1 then
				h.frame = 1
			end
		end
	end


--+math.min(math.abs(love.mouse.getY()-40-(i-1)*65+cam_x),50)

end
function I.draw(I)
	love.graphics.draw( cadre , x,y)
	

	love.graphics.setFont( letre )
	love.graphics.setRenderTarget(men)
	for i,h in ipairs(nivlist) do
		if h.eta == 0 then
			love.graphics.draw( bouton_normal[math.floor(h.frame)] , x+15,y+(i*65-cam_y-(table.maxn(nivlist)*65)*math.floor((i*65-cam_y)/(table.maxn(nivlist)*65))-65))
		elseif h.eta == 1 then
			love.graphics.draw( bouton_pointer[math.floor(h.frame)] , x+15,y+(i*65-cam_y-(table.maxn(nivlist)*65)*math.floor((i*65-cam_y)/(table.maxn(nivlist)*65))-65))
		elseif h.eta == 2 then
			love.graphics.draw( bouton_cliquer[math.floor(h.frame)] , x+15,y+(i*65-cam_y-(table.maxn(nivlist)*65)*math.floor((i*65-cam_y)/(table.maxn(nivlist)*65))-65))
		end

		love.graphics.print( h.nom , x+25,y+10+(i*65-cam_y-(table.maxn(nivlist)*65)*math.floor((i*65-cam_y)/(table.maxn(nivlist)*65))-65))
	end
	love.graphics.setBlendMode( "subtractive" )
	love.graphics.draw( cadre2 , x-122,y-312)
	love.graphics.setBlendMode( "alpha" )
	love.graphics.setRenderTarget()
	love.graphics.draw( men ,0,0)



	if pointerb ~= 0 then

		love.graphics.print( pointerb.nom , 500 , 200 )
		love.graphics.print( pointerb.description , 500 , 300 )
	end

end

