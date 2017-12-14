function son_start()
	son_list = {}
end
function new_son(son_nom,temp)

	table.insert( son_list , {	sondat = love.sound.newSoundData(son_nom) ,
					pointe = 0 ,
					liste = {} ,
					timer = temp,
					temp = 0
							} )
	local new = son_list[table.maxn(son_list)]
	new.liste = {{son = love.audio.newSource(new.sondat)}}
	return (new)
end
function play_son(son,vol,ex,ey)
	son.pointe = son.pointe+1
	if son.liste[son.pointe] == nil then
		if son.temp > crono then
			table.insert(son.liste , {son = love.audio.newSource(son.sondat)})
		else
			son.pointe = 1
			son.temp = crono+son.timer
		end
	end

	if ex ~= nil
	and ey ~= nil then
		son.liste[son.pointe].son:setVolume(  30/math.sqrt((ex-cam_x)^2+(ey-cam_y)^2+(200/zoom)^2)*vol )
		--son.liste[son.pointe].son:setPosition( ex-cam_x, ey-cam_y, 500/zoom )
		son.liste[son.pointe].X = ex
		son.liste[son.pointe].Y = ey


	else
		son.liste[son.pointe].son:setVolume( vol )
	end
	son.liste[son.pointe].vol = vol
	son.liste[son.pointe].son:stop()
	son.liste[son.pointe].son:play()
end
function son_update(dot)
	for i,h in ipairs(son_list) do
		for e,g in ipairs(h.liste) do	
			if g.X ~= nil
			and g.Y ~= nil then
				g.son:setVolume(  30/math.sqrt((g.X-cam_x)^2+(g.Y-cam_y)^2+(200/zoom)^2)*g.vol )
				--g.son:setPosition( g.X-cam_x, g.Y-cam_y, 100/zoom )
			end
		end
	end
end
