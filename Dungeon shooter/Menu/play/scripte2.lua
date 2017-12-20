function I.load(I)
	-- menu
	sourmode = 0
	niv = "niveau_1"
	senario = "test"
	--save
	equipelist = {{},{}}






	zoom = 1
	cam_x = 20.001
	cam_y = 20.001
	cam_z = 300
	start_x = 4
	start_y = 4
	checpoint = {}
	soundlist = {}
	missi = {}
	unit = {}
	obj = {}
	effet = {}

	elu = 1


	--load carte
	local list = love.filesystem.getDirectoryItems("Data/Carte/"..niv.."/Texture")                --texture
	for i,h in ipairs(list) do
		_G["texture_"..h..""] = {}
		num = 1
		while love.filesystem.exists( "Data/Carte/"..niv.."/Texture/"..h.."/"..num..".png" ) == true do
			_G["texture_"..h..""][num] = {image = love.graphics.newImage("Data/Carte/"..niv.."/Texture/"..h.."/"..num..".png")}
			num = num+1
		end
	end

	drawlist = {}
	local w = 1
	while w <= 30 do
		drawlist[w] = {terrain = {},mob = {}}
		w = w+1
	end
	love.filesystem.load("Data/Carte/"..niv.."/texture en bleu.lua")()
	carter = love.image.newImageData("Data/Carte/"..niv.."/map.png")
	carto = {}
	for i,h in ipairs(equipelist) do
		table.insert(carto,{})
	end
	wx = 1
	while wx < carter:getWidth()/5 do
		wy = 1
		for i,h in ipairs(carto) do
			h[wx] = {}
		end
		while wy < carter:getHeight()/5 do
			for i,h in ipairs(carto) do
				h[wx][wy] = {}
			end
			wy = wy+1
		end
		wx = wx+1
	end
	wx = 1
	while wx < carter:getWidth() do
		wy = 1
		while wy < carter:getHeight() do
			local blo = colibl(wx,wy)
			if tex(blo) ~= nil then
				table.insert(drawlist[math.floor(coliv(wx,wy)/10)+1].terrain , {	tex = tex(blo),
													x = wx,
													y = wy
															})

			end

			wy = wy+1


		end
		wx = wx+1
	end

	S = {}
	love.filesystem.load("Data/Carte/"..niv.."/senario/"..senario.."/scripte.lua")()
	S.init()
	--start
	creation(20,20,200,0,unit_Dude,1)
	hero = unit[table.maxn(unit)]
	crono = 0
	fps = 60
	S.start()
end
function I.deload(I)

	drawlist = nil
	checpoint = nil
	carto = nil
	unit = nil
	obj = nil
	effet = nil
	missi = nil
	collectgarbage ("collect")
end
function creation(sx,sy,sz,A,tiper,equi)
	table.insert( unit , {	x = sx,
				y = sy,
				z = sz,
				m = 0,
				n = 0,
				o = 0,
				A = A,
				Az = 0,
				tipe = tiper,
				equipe = equi
						})
	tiper.creation(tiper,unit[table.maxn(unit)],table.maxn(unit))
	for i , h in ipairs(unit[table.maxn(unit)].app) do
		h = {	sprite = h,
			frame = 1,
			lastframe = 0,
			x = sx,
			y = sy,
			z = sz,
			A = angle
					}
	end
end
function cree_obj(sx,sy,sz,A,tiper,equi)
	table.insert( unit , {	x = sx,
				y = sy,
				z = sz,
				m = 0,
				n = 0,
				o = 0,
				A = A,
				Az = 0,
				tipe = tiper,
				equipe = equi,
				app = {}
						})
	tiper.creation(tiper,unit[table.maxn(obj)],table.maxn(obj))
	for i , h in ipairs(obj[table.maxn(obj)].app) do
		h = {	sprite = h,
			frame = 1,
			lastframe = 0,
			x = sx,
			y = sy,
			z = sz,
			A = A
						}
	end
end
function particule(tipe,ex,ey,ez,em,en,eo,ang)
	table.insert( effet , {	tipe = tipe,
				m = tipe.facteur_vitt*em+math.random(-50*tipe.random,50*tipe.random)/50,
				n = tipe.facteur_vitt*en+math.random(-50*tipe.random,50*tipe.random)/50,
				o = tipe.facteur_vitt*en+math.random(-50*tipe.randomz,50*tipe.random)/50,
				S = tipe.S,
				T = crono+tipe.T,
				alpha = tipe.alpha,
				app = {	sprite = tipe.sprite,
					frame = 1,
					lastframe = 0,
					x = ex,
					y = ey,
					z = ez,
					A = ang
							}


									} )
end
function tire(sx,sy,sz,A,Az,equ,typ)
	table.insert(missi,{	x = sx,
				y = sy,
				z = sz,
				m = math.cos(Az)*typ.speed*math.cos(A),
				n = math.cos(Az)*typ.speed*math.sin(A),
				o = math.sin(Az)*typ.speed,
				tipe = typ,
				equipe = equ,
				mode = "stand",
				timer = crono+typ.timer,
				app = {},
				angle = A,
				anglez = Az
							} )
	tiper.creation(tiper,unit[table.maxn(missi)],table.maxn(missi))
	for i , h in ipairs(missi[table.maxn(missi)].app) do
		h = {	sprite = h,
			frame = 1,
			lastframe = 0,
			x = missi[table.maxn(missi)].x,
			y = missi[table.maxn(missi)].y,
			z = missi[table.maxn(missi)].z,
			A = missi[table.maxn(missi)].angle
								}
	end
end
function colibl(ex,ey)
	ro, gr, bl, al = carter:getPixel( math.min(math.max(0,math.floor(ex)),carter:getWidth()-1), math.min(math.max(0,math.floor(ey)),carter:getHeight()-1) )
	return (bl)
end
function colir(ex,ey)
	ro, gr, bl, al = carter:getPixel( math.min(math.max(0,math.floor(ex)),carter:getWidth()-1), math.min(math.max(0,math.floor(ey)),carter:getHeight()-1) )
	return (ro)
end
function coliv(ex,ey)
	ro, gr, bl, al = carter:getPixel( math.min(math.max(0,math.floor(ex)),carter:getWidth()-1), math.min(math.max(0,math.floor(ey)),carter:getHeight()-1) )
	return (gr)
end
function angle(A1,A2)
	A1 = A1-math.floor(A1/math.pi/2)*2*math.pi
	A2 = A2-math.floor(A2/math.pi/2)*2*math.pi
	if A2-A1 > math.pi then
		return(A2-A1-2*math.pi)
	elseif A2-A1 < -math.pi then
		return(A2-A1+2*math.pi)
	else
		return(A2-A1)
	end
end
function reset_pos(Q)
	carto[Q.equipe][math.max(1,math.min(table.maxn(carto),math.floor(Q.x/5)))][math.max(1,math.min(table.maxn(carto[1]),math.floor(Q.y/5)))] = {}
	if math.floor(Q.x/5)-Q.x < 25 then
		carto[Q.equipe][math.max(1,math.min(table.maxn(carto),math.floor(Q.x/5)+1))][math.max(1,math.min(table.maxn(carto[1]),math.floor(Q.y/5)))] = {}
		if math.floor(Q.x/5)-Q.x < 25 then
			carto[Q.equipe][math.max(1,math.min(table.maxn(carto),math.floor(Q.x/5)+1))][math.max(1,math.min(table.maxn(carto[1]),math.floor(Q.y/5)+1))] = {}
		else
			carto[Q.equipe][math.max(1,math.min(table.maxn(carto),math.floor(Q.x/5)+1))][math.max(1,math.min(table.maxn(carto[1]),math.floor(Q.y/5)-1))] = {}
		end
	else
		carto[Q.equipe][math.max(1,math.min(table.maxn(carto),math.floor(Q.x/5)-1))][math.max(1,math.min(table.maxn(carto[1]),math.floor(Q.y/5)))] = {}
		if math.floor(Q.x/5)-Q.x < 25 then
			carto[Q.equipe][math.max(1,math.min(table.maxn(carto),math.floor(Q.x/5)-1))][math.max(1,math.min(table.maxn(carto[1]),math.floor(Q.y/5)+1))] = {}
		else
			carto[Q.equipe][math.max(1,math.min(table.maxn(carto),math.floor(Q.x/5)-1))][math.max(1,math.min(table.maxn(carto[1]),math.floor(Q.y/5)-1))] = {}
		end
	end
	if math.floor(Q.x/5)-Q.x < 25 then
		carto[Q.equipe][math.max(1,math.min(table.maxn(carto),math.floor(Q.x/5)))][math.max(1,math.min(table.maxn(carto[1]),math.floor(Q.y/5)+1))] = {}
	else
		carto[Q.equipe][math.max(1,math.min(table.maxn(carto),math.floor(Q.x/5)))][math.max(1,math.min(table.maxn(carto[1]),math.floor(Q.y/5)-1))] = {}
			table.insert(carto[Q.equipe][math.max(1,math.min(table.maxn(carto),math.floor(Q.x/5)))][math.max(1,math.min(table.maxn(carto[1]),math.floor(Q.y/5)))],Q)
	if math.floor(Q.x/5)-Q.x < 2.5 then
		table.insert(carto[Q.equipe][math.max(1,math.min(table.maxn(carto),math.floor(Q.x/5)+1))][math.max(1,math.min(table.maxn(carto[1]),math.floor(Q.y/5)))],Q)
		if math.floor(Q.x/5)-Q.x < 2.5 then
			table.insert(carto[Q.equipe][math.max(1,math.min(table.maxn(carto),math.floor(Q.x/5)+1))][math.max(1,math.min(table.maxn(carto[1]),math.floor(Q.y/5)+1))],Q)
		else
			table.insert(carto[Q.equipe][math.max(1,math.min(table.maxn(carto),math.floor(Q.x/5)+1))][math.max(1,math.min(table.maxn(carto[1]),math.floor(Q.y/5)-1))],Q)
		end
	else
		table.insert(carto[Q.equipe][math.max(1,math.min(table.maxn(carto),math.floor(Q.x/5)-1))][math.max(1,math.min(table.maxn(carto[1]),math.floor(Q.y/5)))],Q)
		if math.floor(Q.x/5)-Q.x < 2.5 then
			table.insert(carto[Q.equipe][math.max(1,math.min(table.maxn(carto),math.floor(Q.x/5)-1))][math.max(1,math.min(table.maxn(carto[1]),math.floor(Q.y/5)+1))],Q)
		else
			table.insert(carto[Q.equipe][math.max(1,math.min(table.maxn(carto),math.floor(Q.x/5)-1))][math.max(1,math.min(table.maxn(carto[1]),math.floor(Q.y/5)-1))],Q)
		end
	end
	if math.floor(Q.x/5)-Q.x < 2.5 then
		table.insert(carto[Q.equipe][math.max(1,math.min(table.maxn(carto),math.floor(Q.x/5)))][math.max(1,math.min(table.maxn(carto[1]),math.floor(Q.y/5)+1))],Q)
	else
		table.insert(carto[Q.equipe][math.max(1,math.min(table.maxn(carto),math.floor(Q.x/5)))][math.max(1,math.min(table.maxn(carto[1]),math.floor(Q.y/5)-1))],Q)
	end	end
end
function declare_pos(Q)
	table.insert(carto[Q.equipe][math.max(1,math.min(table.maxn(carto),math.floor(Q.x/5)))][math.max(1,math.min(table.maxn(carto[1]),math.floor(Q.y/5)))],Q)
	if math.floor(Q.x/5)-Q.x < 2.5 then
		table.insert(carto[Q.equipe][math.max(1,math.min(table.maxn(carto),math.floor(Q.x/5)+1))][math.max(1,math.min(table.maxn(carto[1]),math.floor(Q.y/5)))],Q)
		if math.floor(Q.x/5)-Q.x < 2.5 then
			table.insert(carto[Q.equipe][math.max(1,math.min(table.maxn(carto),math.floor(Q.x/5)+1))][math.max(1,math.min(table.maxn(carto[1]),math.floor(Q.y/5)+1))],Q)
		else
			table.insert(carto[Q.equipe][math.max(1,math.min(table.maxn(carto),math.floor(Q.x/5)+1))][math.max(1,math.min(table.maxn(carto[1]),math.floor(Q.y/5)-1))],Q)
		end
	else
		table.insert(carto[Q.equipe][math.max(1,math.min(table.maxn(carto),math.floor(Q.x/5)-1))][math.max(1,math.min(table.maxn(carto[1]),math.floor(Q.y/5)))],Q)
		if math.floor(Q.x/5)-Q.x < 2.5 then
			table.insert(carto[Q.equipe][math.max(1,math.min(table.maxn(carto),math.floor(Q.x/5)-1))][math.max(1,math.min(table.maxn(carto[1]),math.floor(Q.y/5)+1))],Q)
		else
			table.insert(carto[Q.equipe][math.max(1,math.min(table.maxn(carto),math.floor(Q.x/5)-1))][math.max(1,math.min(table.maxn(carto[1]),math.floor(Q.y/5)-1))],Q)
		end
	end
	if math.floor(Q.x/5)-Q.x < 2.5 then
		table.insert(carto[Q.equipe][math.max(1,math.min(table.maxn(carto),math.floor(Q.x/5)))][math.max(1,math.min(table.maxn(carto[1]),math.floor(Q.y/5)+1))],Q)
	else
		table.insert(carto[Q.equipe][math.max(1,math.min(table.maxn(carto),math.floor(Q.x/5)))][math.max(1,math.min(table.maxn(carto[1]),math.floor(Q.y/5)-1))],Q)
	end
end
function I.MP(I,mx,my,bu)
	if hero ~= nil then
		hero.tipe.MP(hero.tipe,hero,mx,my,bu)
	else




	end
end
function I.MR(I,mx,my,bu)
	if hero ~= nil then
		hero.tipe.MP(hero.tipe,hero,mx,my,bu)
	else



	end
end
function I.KP(I,k)
	if hero ~= nil then
		hero.tipe.MP(hero.tipe,hero,k)
	else

	end
end
function I.KR(I,k)
	if hero ~= nil then
		hero.tipe.MP(hero.tipe,hero,k)
	else



	end
end
function I.update(I,dot)
	elu = elu+1
	if unit[elu] == nil then
		elu = 1
	end
	local w = 1
	while w < 15 do
		elu = elu+1
		if unit[elu] == nil then
			elu = 1
		end
		if unit[elu] == hero
		or unit[elu].mode ~= "mort" then
			elu = elu+1
			if unit[elu] == nil then
				elu = 1
			end
		else
			w = 80
		end
		w = w+1
	end
	if unit[elu] ~= nil
	and unit[elu] ~= hero then
		unit[elu].tipe.ia(unit[elu].tipe,unit[elu],elu)
	end

	if hero ~= nil then
		hero.tipe.update_hero(hero.tipe,hero)
	end
	for i,h in ipairs(drawlist) do
		h.mob = {}
	end
	for i,h in ipairs(unit) do
		for e,g in ipairs(h.app) do
			if math.abs(g.x-cam_x) < love.graphics.getWidth()/2/zoom
			and math.abs(g.y-cam_y) < love.graphics.getHeight()/2/zoom then
				table.insert(drawlist[math.min(30,math.floor(g.z/10))+1].mob,g)
			end
		end
		reset_pos(h)
		h.x = h.x+h.m*dot
		h.y = h.y+h.n*dot
		h.z = h.z+h.o*dot
		if h.mode ~= "mort" then
			declare_pos(h)
		end
	end
	for i,h in ipairs(unit) do
		for e,g in ipairs(h.app) do
			g.lastframe = math.floor(g.frame)
		end
		h.tipe.update(h.tipe,h,i,dot)
		for e,g in ipairs(h.app) do
			if math.floor(g.frame) ~= g.lastframe then
				if g.sprite[math.floor(g.frame)].son ~= nil
				and g.sprite[math.floor(g.frame)].temposon < crono then
					table.insert(soundlist,{love.audio.newSource(g.sprite[math.floor(g.frame)].son),crono+5})
					soundlist[table.maxn(soundlist)][1]:setVolume(math.min(1,300/math.sqrt((Q.x-cam_x)^2+(Q.y-cam_y)^2+(1000/zoom)^2)^1.3))
					love.audio.play(soundlist[table.maxn(soundlist)][1])
					g.sprite[math.floor(frame)].temposon = crono+.05
				end
			end
		end
	end
	for i,h in ipairs(obj) do
		for e,g in ipairs(h.app) do
			if math.abs(g.x-cam_x) < love.graphics.getWidth()/2/zoom
			and math.abs(g.y-cam_y) < love.graphics.getHeight()/2/zoom then
				ble.insert(drawlist[20].mob,g )
			end

			g.lastframe = math.floor(g.frame)
		end
		h.tipe.update(h.tipe,h,i,dot)
		for e,g in ipairs(h.app) do
			if math.floor(g.frame) ~= g.lastframe then
				if g.sprite[math.floor(g.frame)].son ~= nil
				and g.sprite[math.floor(g.frame)].temposon < crono then
					table.insert(soundlist,{love.audio.newSource(g.sprite[math.floor(g.frame)].son),crono+5})
					soundlist[table.maxn(soundlist)][1]:setVolume(math.min(1,300/math.sqrt((Q.x-cam_x)^2+(Q.y-cam_y)^2+(1000/zoom)^2)^1.3))
					love.audio.play(soundlist[table.maxn(soundlist)][1])
					g.sprite[math.floor(frame)].temposon = crono+.05
				end
			end
		end
	end
	for i,h in ipairs(missi) do
		for e,g in ipairs(h.app) do
			if math.abs(g.x-cam_x) < love.graphics.getWidth()/2/zoom
			and math.abs(g.y-cam_y) < love.graphics.getHeight()/2/zoom then
				table.insert(drawlist[math.min(30,math.floor(g.z/10))+1].mob,g)
			end
			g.lastframe = math.floor(g.frame)
		end
		h.x = h.x+h.m*dot
		h.y = h.y+h.n*dot
		h.z = h.z+h.o*dot
		if h.mode == "stand" then
			local speed = math.sqrt(h.m^2+h.n^2+h.o^2)
			if speed > 0 then
				local spee = 0
				while spee < speed do
					if coliv(h.x+h.m/speed*spee,h.y+h.n/speed*spee)+1 > h.z+h.o/speed*spee then
						while coliv(h.x+h.m/speed*spee,h.y+h.n/speed*spee)+1 > h.z+h.o/speed*spee do
							spee = spee-.5
						end
						while coliv(h.x+h.m/speed*spee,h.y+h.n/speed*spee)+1 > h.z+h.o/speed*spee do
							spee = spee+.1
						end
						while coliv(h.x+h.m/speed*spee,h.y+h.n/speed*spee)+1 > h.z+h.o/speed*spee do
							spee = spee-.02
						end
						h.x = h.x+h.m/speed*spee
						h.y = h.y+h.n/speed*spee
						h.z = h.z+h.o/speed*spee
						h.mode = "mort"
						h.m = 0
						h.n = 0
						h.o = 0
						spee = 10000
					end
					if h.mode == "stand" then
						local id = nil
						local near = nil
						local dist = 1000
						for e,g in ipairs(carto) do
							if e ~= h.equipe then
								for u,k in ipairs(g[math.floor(h.x/5)][math.floor(h.y/5)]) do
									if h.z > k.z
									and k.mode ~= "mort"
									and h.z < k.z+k.tipe.hauteur then
										local dis = math.sqrt((h.x+h.m/speed*spee-k.x)^2+(h.y+h.n/speed*spee-k.y)^2)
										if dist > dis then
											dist = dis
											near = k
											id = u
										end
									end
								end
							end
						end
						if near ~= nil
						and dist < h.tipe.colision+near.tipe.colision then
							h.mode = "mort"
							h.m = 0
							h.n = 0
							h.o = 0
							h.tipe.mort(h.tipe,h,i)
							near.santer = math.max(near.santer-h.tipe.domage,0)
							if near.santer == 0 then
								near.tipe.mort(near.tipe,near,id)
								near.mode = "mort"
							else
								near.tipe.hit(near.tipe,near,id)
							end
						end
					end
					spee = spee+1
				end
			end
		elseif h.mode == "mort" then

		end
		h.tipe.update(h.tipe,h,i,dot)
		for e,g in ipairs(h.app) do
			if math.floor(g.frame) ~= g.lastframe then
				if g.sprite[math.floor(g.frame)].son ~= nil
				and g.sprite[math.floor(g.frame)].temposon < crono then
					table.insert(soundlist,{love.audio.newSource(g.sprite[math.floor(g.frame)].son),crono+5})
					soundlist[table.maxn(soundlist)][1]:setVolume(math.min(1,300/math.sqrt((Q.x-cam_x)^2+(Q.y-cam_y)^2+(1000/zoom)^2)^1.3))
					love.audio.play(soundlist[table.maxn(soundlist)][1])
					g.sprite[math.floor(frame)].temposon = crono+.05
				end
			end
		end
		if h.timer < crono then
			table.remove(missi,i)
		end
	end
	for i,h in ipairs(effet) do
		if h.T > crono
		and h.alpha > 0 then



			if math.abs(h.x-cam_x) < love.graphics.getWidth()/2/zoom
			and math.abs(h.y-cam_y) < love.graphics.getHeight()/2/zoom then
				table.insert(drawlist[math.min(30,math.floor(h.z/10))+1].mob,h)
			end

			h.alpha = h.alpha+h.tipe.alphaplus

			h.S = h.S+h.tipe.Splus
			h.m = h.tipe.frix*h.m
			h.n = h.tipe.frix*h.n
			h.app.x = h.app.x+h.m
			h.app.y = h.app.y+h.n
			h.app.z = h.app.z+h.p
			h.app.A = h.app.A+h.tipe.rot
			h.app.frame = math.min(h.app.frame+.2,table.maxn(h.app.sprite))
			h.app.lastframe = math.floor(h.app.frame)
		else
			table.remove(effet,i)
		end
	end
	for i,h in ipairs(soundlist) do
		if h[2] < crono then
			table.remove(soundlist,i)
			
		end
	end
	S.update(dot)
	fps = fps+.01*(1/dot-fps)
	crono = crono+dot
end
function I.draw(I)
	for i,h in ipairs(drawlist) do
		for e,g in ipairs(h.terrain) do
			love.graphics.draw( g.tex[1].image , (g.x-cam_x+.5)*zoom*50+love.graphics.getWidth()/2,(g.y-cam_y+.5)*zoom*50+love.graphics.getHeight()/2,0,zoom/2,zoom/2,g.tex[1].image:getWidth()/2,g.tex[1].image:getHeight()/2)
		end
		for e,g in ipairs(h.mob) do
			love.graphics.draw( g.sprite[g.frame].image , (g.x-cam_x)*zoom*50+love.graphics.getWidth()/2,(g.y-cam_y)*zoom*50+love.graphics.getHeight()/2,g.A,zoom)
		end
	end
	love.graphics.print( fps , 30 , 30 )

end

