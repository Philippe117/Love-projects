local new = new_function(fonction,"load",0)
function new.F()
	son_list = {}
end
function new_son(son_nom)						--fonction utiliser pour loader un nouveau son
	if love.filesystem.exists(""..son_nom.."/caract.lua")  then
		love.filesystem.load(""..son_nom.."/caract.lua")()
	end
	--if temp_so == nil then
	--	temp_son = 2
	--end
	table.insert( son_list , {	sondat = love.sound.newSoundData(""..son_nom.."/son.ogg") ,
					pointe = 0 ,
					liste = {} ,
					loop = loop ,
					timer = temp_son,
					temp = temp_son
							} )
	local new = son_list[table.maxn(son_list)]
	new.liste = {{	son = love.audio.newSource(new.sondat),
			vol = 1
					}}
	return (new)
end
function play_son(son,vol,loop,var,ex,ey)
						--fonction utiliser pour faire jouer un son déja loader au préalable
						--var est de 0 à 100
	if loop == nil then
		loop = false
	end
	son.pointe = son.pointe+1
	if son.liste[son.pointe] == nil then
		if son.temp > Chrono then
			table.insert(son.liste , {son = love.audio.newSource(son.sondat)})
		else
			son.pointe = 1
			son.temp = Chrono+son.timer
		end
	end
	if son.pointe == 1 then
		son.temp = Chrono+son.timer
	end
	son.liste[son.pointe].son:setLooping( loop )
	if var ~= nil then
		son.liste[son.pointe].son:setPitch( 1*2^(math.random(-var,var)/100) )
	end
	if ey == nil then
		son.liste[son.pointe].son:setVolume( vol )
	else
		son.liste[son.pointe].son:setVolume(  10/math.sqrt((ex-cam_x)^2+(ey-cam_y)^2)^1.2*vol )
		--son.liste[son.pointe].son:setPosition( ex-cam_x, ey-cam_y, 500/zoom )
		son.liste[son.pointe].X = ex
		son.liste[son.pointe].Y = ey
	end
	son.liste[son.pointe].vol = vol
	son.liste[son.pointe].son:stop()
	son.liste[son.pointe].son:play()
	return(son.liste[son.pointe])
end
local new = new_function(fonction,"update",20)
function new.F(dot)		--tas pas besoin dde ten ocuper de celle là
	for i,h in ipairs(son_list) do
		for e,g in ipairs(h.liste) do
			if g.X ~= nil
			and g.Y ~= nil then
				g.son:setVolume(  math.min(1,g.son:getVolume()+.2*(.8/math.sqrt((g.X-cam_x)^2+(g.Y-cam_y)^2)^1.4*g.vol-g.son:getVolume())) )
				--g.son:setPosition( g.X-cam_x, g.Y-cam_y, 100/zoom )
			else
				g.son:setVolume( g.vol )
			end
		end
	end
end
