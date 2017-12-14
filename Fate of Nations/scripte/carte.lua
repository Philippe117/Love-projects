function map_load()
	map = {}
	local list = love.filesystem.getDirectoryItems("Data/carte")
	for i,h in ipairs(list) do
		table.insert( map , {nom = h} )

	end
	for i,h in ipairs(map) do
		_G["map_"..h.nom..""] = h
	end
end
function map_start(carte,scenario)
	M = carte
	love.filesystem.load("Data/carte/"..carte.nom.."/scripte.lua")()
	carte.load(carte)
	local list = love.filesystem.getDirectoryItems("Data/carte/"..carte.nom.."/Texture")                --texture
	for i,h in ipairs(list) do
		_G["texture_"..h..""] = {}
		num = 1
		while love.filesystem.exists( "Data/carte/"..carte.nom.."/Texture/"..h.."/"..num..".png" ) == true do
			_G["texture_"..h..""][num] = {image = love.graphics.newImage("Data/carte/"..carte.nom.."/Texture/"..h.."/"..num..".png")}
			num = num+1
		end
		num = 1
		while love.filesystem.exists( "Data/carte/"..carte.nom.."/Texture/"..h.."/"..num..".gif" ) == true do
			_G["texture_"..h..""][num] = {image = love.graphics.newImage("Data/carte/"..carte.nom.."/Texture/"..h.."/"..num..".gif")}
			_G["texture_"..h..""][num].image:setFilter( "nearest","nearest" )

			num = num+1



		end
	end
	love.filesystem.load("Data/carte/"..carte.nom.."/code de couleur.lua")()
	carte.carter = love.image.newImageData("Data/carte/"..carte.nom.."/map.png")
	carte.minimap = love.image.newImageData("Data/carte/"..carte.nom.."/map.png")
	carte.image = love.graphics.newImage(carte.carter)
	carte.image:setFilter( "nearest","nearest" )

	carte.fond = love.graphics.newImage("Data/carte/"..carte.nom.."/fond.png")
	carte.fond:setFilter( "nearest","nearest" )


	M.Width = carte.image:getWidth()*30
	M.Height = carte.image:getHeight()*30


	S = {}
	love.filesystem.load("Data/carte/"..carte.nom.."/scenario/"..scenario.."/scripte.lua")()


	local wx = 0
	while wx < carte.carter:getWidth() do
		local wy = 0
		while wy < carte.carter:getHeight() do
			if coliv(wx*30,wy*30) ~= 255 then
				set_color_v(wx*30,wy*30,coliv(wx*30,wy*30)+math.random(0,9))




			end


				r , v , b , a = M.carter:getPixel( wx, wy )
				M.minimap:setPixel( wx, wy  , .5*v, v, 0, 255 )





			wy = wy+1
		end
		wx = wx+1
	end

	carte.mini = love.graphics.newImage(carte.minimap)
	carte.mini:setFilter( "nearest","nearest" )

	carte.minimap_ratio = minimap_sise/math.max(M.image:getHeight(),M.image:getWidth())




	if love.filesystem.exists( "Data/carte/"..carte.nom.."/scenario/"..scenario.."/musique.mp3" ) then
		musique = love.audio.newSource( "Data/carte/"..carte.nom.."/scenario/"..scenario.."/musique.mp3", stream )
		musique:isLooping( true )
		musique:setVolume( .1 )
		musique:play()


	end



	S.start(S)




end
function coli(ex,ey)
	ex = ex/30
	ey = ey/30
	return (M.carter:getPixel( math.min(math.max(0,math.floor(ex)),M.carter:getWidth()-1), math.min(math.max(0,math.floor(ey)),M.carter:getHeight()-1) ))
end
function colibl(ex,ey)
	ex = ex/30
	ey = ey/30
	ro, gr, bl, al = M.carter:getPixel( math.min(math.max(0,math.floor(ex)),M.carter:getWidth()-1), math.min(math.max(0,math.floor(ey)),M.carter:getHeight()-1) )
	return (bl)
end
function colir(ex,ey)
	ex = ex/30
	ey = ey/30
	ro, gr, bl, al = M.carter:getPixel( math.min(math.max(0,math.floor(ex)),M.carter:getWidth()-1), math.min(math.max(0,math.floor(ey)),M.carter:getHeight()-1) )
	return (ro)
end
function coliv(ex,ey)
	ex = ex/30
	ey = ey/30
	ro, gr, bl, al = M.carter:getPixel( math.min(math.max(0,math.floor(ex)),M.carter:getWidth()-1), math.min(math.max(0,math.floor(ey)),M.carter:getHeight()-1) )
	return (gr)
end
function colia(ex,ey)
	ex = ex/30
	ey = ey/30
	ro, gr, bl, al = M.carter:getPixel( math.min(math.max(0,math.floor(ex)),M.carter:getWidth()-1), math.min(math.max(0,math.floor(ey)),M.carter:getHeight()-1) )
	return (al)
end
function set_color(ex,ey,r,v,b,a)
	ex = ex/30
	ey = ey/30
	M.carter:setPixel( math.min(math.max(0,math.floor(ex)),M.carter:getWidth()-1), math.min(math.max(0,math.floor(ey)),M.carter:getHeight()-1) , r, v, b, a )
end

function set_color_r(ex,ey,r)
	ex = ex/30
	ey = ey/30
	ro , v , b , a = M.carter:getPixel( math.min(math.max(0,math.floor(ex)),M.carter:getWidth()-1), math.min(math.max(0,math.floor(ey)),M.carter:getHeight()-1) )
	M.carter:setPixel( math.min(math.max(0,math.floor(ex)),M.carter:getWidth()-1), math.min(math.max(0,math.floor(ey)),M.carter:getHeight()-1) , r, v, b, a )
end
function set_color_v(ex,ey,v)
	ex = ex/30
	ey = ey/30
	r , vo , b , a = M.carter:getPixel( math.min(math.max(0,math.floor(ex)),M.carter:getWidth()-1), math.min(math.max(0,math.floor(ey)),M.carter:getHeight()-1) )
	M.carter:setPixel( math.min(math.max(0,math.floor(ex)),M.carter:getWidth()-1), math.min(math.max(0,math.floor(ey)),M.carter:getHeight()-1) , r, v, b, a )
end
function set_color_b(ex,ey,b)
	ex = ex/30
	ey = ey/30
	r , v , bo , a = M.carter:getPixel( math.min(math.max(0,math.floor(ex)),M.carter:getWidth()-1), math.min(math.max(0,math.floor(ey)),M.carter:getHeight()-1) )
	M.carter:setPixel( math.min(math.max(0,math.floor(ex)),M.carter:getWidth()-1), math.min(math.max(0,math.floor(ey)),M.carter:getHeight()-1) , r, v, b, a )
end





function map_update(dot)


end
function map_draw()

	love.graphics.draw( 	M.fond ,
				(M.Width/2-cam_x)*zoom+love.graphics.getWidth()/2 ,
				(M.Height/2-cam_y)*zoom+love.graphics.getHeight()/2 ,
				0,zoom,zoom ,
				M.fond:getWidth()/2,
				M.fond:getHeight()/2
					)
	local wx = math.max(0,math.floor((cam_x-love.graphics.getWidth()/2/zoom-60)/30)*30)
	while wx < math.min(M.carter:getWidth()*30,math.floor((cam_x+love.graphics.getWidth()/2/zoom+60)/30)*30) do
		local wy =  math.max(0,math.floor((cam_y-love.graphics.getHeight()/2/zoom-60)/30)*30)
		while wy <   math.min(M.carter:getHeight()*30,math.floor((cam_y+love.graphics.getHeight()/2/zoom+60)/30)*30) do
			if coliv(wx,wy) ~= 255 then

				love.graphics.setColor(255,255,255,colia(wx,wy))

				love.graphics.draw( tex(coliv(wx,wy))[1].image , (wx-cam_x)*zoom+love.graphics.getWidth()/2 , (wy-cam_y)*zoom+love.graphics.getHeight()/2 ,0,zoom)
			end

			wy = wy+30
		end
		wx = wx+30
	end




--	love.graphics.draw( 	M.image ,
--				-cam_x*zoom+love.graphics.getWidth()/2 ,
--				-cam_y*zoom+love.graphics.getHeight()/2 ,
--				0,30*zoom)






end
