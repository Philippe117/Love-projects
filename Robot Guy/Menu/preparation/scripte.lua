function I.load(I)
	sourmode = 1
	frtxt = 1
	pointere = 0

	imag = {}

	num = 1
	while love.filesystem.exists( "carte/"..niv.."/video"..num..".gif" ) == true do
		table.insert(imag,love.graphics.newImage("carte/"..niv.."/video"..num..".gif"))
		imag[table.maxn(imag)]:setFilter( "nearest","nearest" )
	end
	cadre = love.graphics.newImage("Menu/preparation/cadre.gif")
	cadre:setFilter( "nearest","nearest" )

	if love.filesystem.exists("carte/"..niv.."/caract.lua") == true then
		M = {}
		love.filesystem.load("carte/"..niv.."/caract.lua")()
		M.situation(M)
		M.caract(M)


	end

	but = {nex = {normal = {},pointer = {},cliquer = {},eta = 0,frame = 1} , prev = {normal = {},pointer = {},cliquer = {},eta = 0,frame = 1} }

	if table.maxn(texto) > 1 then

			num = 1
			while love.filesystem.exists( "Menu/preparation/next/normal/"..num..".gif" ) == true do
				table.insert(but.nex.normal,love.graphics.newImage("Menu/preparation/next/normal/"..num..".gif"))
				but.nex.normal[table.maxn(but.nex.normal)]:setFilter( "nearest","nearest" )
				num = num+1
			end
			num = 1
			while love.filesystem.exists( "Menu/preparation/next/pointer/"..num..".gif" ) == true do
				table.insert(but.nex.pointer,love.graphics.newImage("Menu/preparation/next/pointer/"..num..".gif"))
				but.nex.pointer[table.maxn(but.nex.pointer)]:setFilter( "nearest","nearest" )
				num = num+1
			end
			num = 1
			while love.filesystem.exists( "Menu/preparation/next/cliquer/"..num..".gif" ) == true do
				table.insert(but.nex.cliquer,love.graphics.newImage("Menu/preparation/next/cliquer/"..num..".gif"))
				but.nex.cliquer[table.maxn(but.nex.cliquer)]:setFilter( "nearest","nearest" )
				num = num+1
			end
			if love.filesystem.exists( "Menu/preparation/next/clic.ogg" ) == true then
				but.nex.click = love.audio.newSource( "Menu/preparation/next/clic.ogg" )
			end
			if love.filesystem.exists( "Menu/preparation/next/pointe.ogg" ) == true then
				but.nex.pointe = love.audio.newSource( "Menu/preparation/next/pointe.ogg" )
			end
			if love.filesystem.exists("Menu/preparation/next/scripte.lua") == true then
				B = but.nex
				love.filesystem.load("Menu/preparation/next/scripte.lua")()
				but.nex.init(but.nex)
			end



			num = 1
			while love.filesystem.exists( "Menu/preparation/prev/normal/"..num..".gif" ) == true do
				table.insert(but.prev.normal,love.graphics.newImage("Menu/preparation/prev/normal/"..num..".gif"))
				but.prev.normal[table.maxn(but.prev.normal)]:setFilter( "nearest","nearest" )
				num = num+1
			end
			num = 1
			while love.filesystem.exists( "Menu/preparation/prev/pointer/"..num..".gif" ) == true do
				table.insert(but.prev.pointer,love.graphics.newImage("Menu/preparation/prev/pointer/"..num..".gif"))
				but.prev.pointer[table.maxn(but.prev.pointer)]:setFilter( "nearest","nearest" )
				num = num+1
			end
			num = 1
			while love.filesystem.exists( "Menu/preparation/prev/cliquer/"..num..".gif" ) == true do
				table.insert(but.prev.cliquer,love.graphics.newImage("Menu/preparation/prev/cliquer/"..num..".gif"))
				but.prev.cliquer[table.maxn(but.prev.cliquer)]:setFilter( "nearest","nearest" )
				num = num+1
			end
			if love.filesystem.exists( "Menu/preparation/prev/clic.ogg" ) == true then
				but.prev.click = love.audio.newSource( "Menu/preparation/prev/clic.ogg" )
			end
			if love.filesystem.exists( "Menu/preparation/prev/pointe.ogg" ) == true then
				but.prev.pointe = love.audio.newSource( "Menu/preparation/prev/pointe.ogg" )
			end
			if love.filesystem.exists("Menu/preparation/prev/scripte.lua") == true then
				B = but.prev
				love.filesystem.load("Menu/preparation/prev/scripte.lua")()
				but.prev.init(but.prev)
			end


	end




end
function I.deload(I)
end
function I.MP(I,mx,my,bu)
	if pointere ~= 0
	and bu == "l" then
		pointere.eta = 2
	end


end
function I.MR(I,mx,my,bu)
	if pointere ~= 0
	and bu == "l" then
		if pointere.click ~= nil then
			love.audio.stop(pointere.click)
			love.audio.play(pointere.click)
		end
		pointere.eta = 1
		pointere.clic(pointere)
	end


end
function I.KP(I,k)
end
function I.KR(I,k)
end
function I.update(I,dot)


	pointere = 0
	if frtxt < table.maxn(texto) then
		if love.mouse.getX() > but.nex.X
		and love.mouse.getX() < but.nex.X+but.nex.normal[1]:getWidth()
		and love.mouse.getY() > but.nex.Y
		and love.mouse.getY() < but.nex.Y+but.nex.normal[1]:getHeight() then
			pointere = but.nex
			if love.mouse.isDown("l") == false then
				if but.nex.eta ~= 1 then
					but.nex.eta = 1
					but.nex.frame = 1
					if but.nex.pointe ~= nil then
						love.audio.stop(but.nex.pointe)
						love.audio.play(but.nex.pointe)
					end
				end
			else
				but.nex.eta = 2
				but.nex.frame = 1
			end
		else
			but.nex.eta = 0
			but.nex.frame = 1
		end
		if but.nex.eta == 0 then
			but.nex.frame = but.nex.frame+.1
			if but.nex.frame >= table.maxn(but.nex.normal)+1 then
				but.nex.frame = 1
			end
		elseif but.nex.eta == 1 then
			but.nex.frame = but.nex.frame+.1
			if but.nex.frame >= table.maxn(but.nex.pointer)+1 then
				but.nex.frame = 1
			end
		elseif but.nex.eta == 2 then
			but.nex.frame = but.nex.frame+.1
			if but.nex.frame >= table.maxn(but.nex.cliquer)+1 then
				but.nex.frame = 1
			end
		end
	end
	if frtxt > 1 then
		if love.mouse.getX() > but.prev.X
		and love.mouse.getX() < but.prev.X+but.prev.normal[1]:getWidth()
		and love.mouse.getY() > but.prev.Y
		and love.mouse.getY() < but.prev.Y+but.prev.normal[1]:getHeight() then
			pointere = but.prev
			if love.mouse.isDown("l") == false then
				if but.prev.eta ~= 1 then
					but.prev.eta = 1
					but.prev.frame = 1
					if but.prev.pointe ~= nil then
						love.audio.stop(but.prev.pointe)
						love.audio.play(but.prev.pointe)
					end
				end
			else
				but.prev.eta = 2
				but.prev.frame = 1
			end
		else
			but.prev.eta = 0
			but.prev.frame = 1
		end
		if but.prev.eta == 0 then
			but.prev.frame = but.prev.frame+.1
			if but.prev.frame >= table.maxn(but.prev.normal)+1 then
				but.prev.frame = 1
			end
		elseif but.prev.eta == 1 then
			but.prev.frame = but.prev.frame+.1
			if but.prev.frame >= table.maxn(but.prev.pointer)+1 then
				but.prev.frame = 1
			end
		elseif but.prev.eta == 2 then
			but.prev.frame = but.prev.frame+.1
			if but.prev.frame >= table.maxn(but.prev.cliquer)+1 then
				but.prev.frame = 1
			end
		end
	end












end
function I.draw(I)
	love.graphics.setFont( letre_XX )
	love.graphics.print( M.nom , 40 , 100 )
	love.graphics.setFont( letre )
	love.graphics.printf( texto[frtxt] , 40 , 240 , math.max(100, love.graphics.getWidth()-900) , "left" )


	if imag[frtxt] ~= nil then
		love.graphics.draw( imag[frtxt] , love.graphics.getWidth()-800 , 100 )
	end

	love.graphics.draw( cadre , love.graphics.getWidth()-800 , 100 )

	love.graphics.draw( cadre , 0 , 100 ,0, love.graphics.getWidth()/800 ,1.2)


	if frtxt < table.maxn(texto) then
		if but.nex.eta == 0 then
			love.graphics.draw( but.nex.normal[math.floor(but.nex.frame)] ,but.nex.X,but.nex.Y)
		elseif but.nex.eta == 1 then
			love.graphics.draw( but.nex.pointer[math.floor(but.nex.frame)] ,but.nex.X,but.nex.Y)
		elseif but.nex.eta == 2 then
			love.graphics.draw( but.nex.cliquer[math.floor(but.nex.frame)] ,but.nex.X,but.nex.Y)
		end
	end
	if frtxt > 1 then
		if but.prev.eta == 0 then
			love.graphics.draw( but.prev.normal[math.floor(but.prev.frame)] ,but.prev.X,but.prev.Y)
		elseif but.prev.eta == 1 then
			love.graphics.draw( but.prev.pointer[math.floor(but.prev.frame)] ,but.prev.X,but.prev.Y)
		elseif but.prev.eta == 2 then
			love.graphics.draw( but.prev.cliquer[math.floor(but.prev.frame)] ,but.prev.X,but.prev.Y)
		end
	end





end
