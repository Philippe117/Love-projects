function I.load(I)
	modlist = {}
	local list = love.filesystem.getDirectoryItems("Model")
	for i,h in ipairs(list) do
		table.insert( modlist , {nom = h} )
	end
end
function I.demare(I)
	for new,g in ipairs(modlist) do
		table.insert( bouton , {nom = "sel",normal = {},pointer = {},cliquer = {},eta = 0,frame = 1} )
		h = bouton[table.maxn(bouton)]

		num = 1
		while love.filesystem.exists( "Menu/"..menu_load.nom.."/bouton/"..h.nom.."/normal/"..num..".png" ) == true do
			table.insert(h.normal,love.graphics.newImage("Menu/"..menu_load.nom.."/bouton/"..h.nom.."/normal/"..num..".png"))
			h.normal[table.maxn(h.normal)]:setFilter( "nearest","nearest" )
			num = num+1
		end
		num = 1
		while love.filesystem.exists( "Menu/"..menu_load.nom.."/bouton/"..h.nom.."/pointer/"..num..".png" ) == true do
			table.insert(h.pointer,love.graphics.newImage("Menu/"..menu_load.nom.."/bouton/"..h.nom.."/pointer/"..num..".png"))
			h.pointer[table.maxn(h.pointer)]:setFilter( "nearest","nearest" )
			num = num+1
		end
		num = 1
		while love.filesystem.exists( "Menu/"..menu_load.nom.."/bouton/"..h.nom.."/cliquer/"..num..".png" ) == true do
			table.insert(h.cliquer,love.graphics.newImage("Menu/"..menu_load.nom.."/bouton/"..h.nom.."/cliquer/"..num..".png"))
			h.cliquer[table.maxn(h.cliquer)]:setFilter( "nearest","nearest" )
			num = num+1
		end
		if love.filesystem.exists( "Menu/"..menu_load.nom.."/bouton/"..h.nom.."/clic.ogg" ) == true then
			h.click = love.audio.newSource( "Menu/"..menu_load.nom.."/bouton/"..h.nom.."/clic.ogg" )
		end
		if love.filesystem.exists( "Menu/"..menu_load.nom.."/bouton/"..h.nom.."/pointe.ogg" ) == true then
			h.pointe = love.audio.newSource( "Menu/"..menu_load.nom.."/bouton/"..h.nom.."/pointe.ogg" )
		end
		B = h
		love.filesystem.load("Menu/"..menu_load.nom.."/bouton/"..h.nom.."/scripte.lua")()
		B.X = 200+math.floor(new/10)*200
		B.Y = 100+new*50-math.floor(new/10)*500
		B.text = g.nom
	end
end
function I.deload(I)
end
function I.MP(I,mx,my,bu)

end
function I.MR(I,mx,my,bu)

end
function I.KP(I,k)
	if k == "escape" then
		love.event.push('quit')
	elseif k == "delete" then
		remove_bone(select)
	end
end
function I.KR(I,k)
end
function I.update(I,dot)

end
function I.draw(I)
	--love.graphics.print( modname , 100 , 100 )

end
