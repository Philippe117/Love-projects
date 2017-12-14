function I.load(I)
	-- menu
	sourmode = 0
	niv = "niveau_1"
	senario = "test"
	--save
	equipelist = {{},{}}

	crono = 0
	




	moux = 0
	mouy = 0
	mouz = 0
	zoom = 1
	cam_x = 20.001
	cam_y = 20.001
	cam_z = 800
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
	local list = love.filesystem.enumerate("Data/Carte/"..niv.."/Texture")                --texture
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
	wx = 0
	while wx < carter:getWidth() do
		wy = 0
		while wy < carter:getHeight() do
			local blo = colibl(wx,wy)
			if tex(blo) ~= nil then
				local ver = coliv(wx,wy)
				local omb = math.max(math.min((2*coliv(wx-1,wy-1)+coliv(wx-1,wy)+coliv(wx,wy-1))/4-ver,25),-25)
				local lum = math.max(math.min((2*coliv(wx+1,wy+1)+coliv(wx+1,wy)+coliv(wx,wy+1))/4-ver,25),-25)
				if lum > 9 then
					lum = 0
				end


				table.insert(drawlist[math.floor(coliv(wx,wy)/10)+1].terrain , {	tex = tex(blo),
													x = wx,
													y = wy,
													z = ver,
													omb = omb,
													lum = lum
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
	creation(25,25,200,0,unit_Dude,1)
	hero = unit[table.maxn(unit)]

	txt = 1

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
	table.insert( unit , {	x = sx+math.random(-100,100)/10,
				y = sy+math.random(-100,100)/10,
				z = sz,
				m = 0,
				n = 0,
				o = 0,
				A = A,
				Az = 0,
				mode = "normal",
				tipe = tiper,
				equipe = equi
						})
	tiper.creation(tiper,unit[table.maxn(unit)],table.maxn(unit))
	
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
				A = A,
				Az = Az
							} )
	typ.creation(typ,missi[table.maxn(missi)],table.maxn(missi))
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

function point(app,X,Y)
	local A = math.atan2(((app.y+math.sin(app.A)*math.cos(app.Az)-cam_y)*50*zoom*cam_z/(cam_z-(app.z+math.sin(app.Az))*zoom)-(app.y-cam_y)*50*zoom*cam_z/(cam_z-app.z*zoom)),((app.x+math.cos(app.A)*math.cos(app.Az)-cam_x)*50*zoom*cam_z/(cam_z-(app.z+math.sin(app.Az))*zoom)-(app.x-cam_x)*50*zoom*cam_z/(cam_z-app.z*zoom)))


	return(app.x+(X-app.sprite.x)*math.cos(-A)*math.cos(app.Az)/100+(Y-app.sprite.y)*math.sin(-A)/100),(app.y+(Y-app.sprite.y)*math.cos(-A)/100+(X-app.sprite.x)*math.sin(A)*math.cos(app.Az)/100)
end


function reset_pos(Q)
	if carto[Q.equipe][math.max(1,math.min(table.maxn(carto[1]),math.floor(Q.x/5)))][math.max(1,math.min(table.maxn(carto[1][1]),math.floor(Q.y/5)))] ~= {} then
		carto[Q.equipe][math.max(1,math.min(table.maxn(carto[1]),math.floor(Q.x/5)))][math.max(1,math.min(table.maxn(carto[1][1]),math.floor(Q.y/5)))] = {}
	end

end
function declare_pos(Q)
	table.insert(carto[Q.equipe][math.max(1,math.min(table.maxn(carto[1]),math.floor(Q.x/5)))][math.max(1,math.min(table.maxn(carto[1][1]),math.floor(Q.y/5)))],Q)
end


function test_pos(ex,ey,equ)
	if equ == 0 then
		equip = table.maxn(carto)
		equ = 1
	else
		equip = equ
	end
	local list = {}
	while equ <= equip do

		table.insert(list,carto[equ][math.max(1,math.min(table.maxn(carto[1]),math.floor(ex/5)))][math.max(1,math.min(table.maxn(carto[1][1]),math.floor(ey/5)))])

		if math.floor(ex/5)*5-ex < -2.5 then
			--x+1
			table.insert(list,carto[equ][math.max(1,math.min(table.maxn(carto[1]),math.floor(ex/5)+1))][math.max(1,math.min(table.maxn(carto[1][1]),math.floor(ey/5)))])

			if math.floor(ey/5)*5-ey < -2.5 then
				--x+1,y+1
				table.insert(list,carto[equ][math.max(1,math.min(table.maxn(carto[1]),math.floor(ex/5)+1))][math.max(1,math.min(table.maxn(carto[1][1]),math.floor(ey/5)+1))])

			else
				--x+1,y-1
				table.insert(list,carto[equ][math.max(1,math.min(table.maxn(carto[1]),math.floor(ex/5)+1))][math.max(1,math.min(table.maxn(carto[1][1]),math.floor(ey/5)-1))])

			end
		else
			--x-1
			table.insert(list,carto[equ][math.max(1,math.min(table.maxn(carto[1]),math.floor(ex/5)-1))][math.max(1,math.min(table.maxn(carto[1][1]),math.floor(ey/5)))])

			if math.floor(ey/5)*5-ey < -2.5 then
				--x-1,y+1
				table.insert(list,carto[equ][math.max(1,math.min(table.maxn(carto[1]),math.floor(ex/5)-1))][math.max(1,math.min(table.maxn(carto[1][1]),math.floor(ey/5)+1))])
			else
				--x-1,y-1
				table.insert(list,carto[equ][math.max(1,math.min(table.maxn(carto[1]),math.floor(ex/5)-1))][math.max(1,math.min(table.maxn(carto[1][1]),math.floor(ey/5)-1))])
			end
		end
		if math.floor(ey/5)*5-ey < -2.5 then
			--y+1
			table.insert(list,carto[equ][math.max(1,math.min(table.maxn(carto[1]),math.floor(ex/5)))][math.max(1,math.min(table.maxn(carto[1][1]),math.floor(ey/5)+1))])
		else
			--y-1
			table.insert(list,carto[equ][math.max(1,math.min(table.maxn(carto[1]),math.floor(ex/5)))][math.max(1,math.min(table.maxn(carto[1][1]),math.floor(ey/5)-1))])
		end
		equ = equ+1
	end

	return(list)

end
function recherche(ex,ey,A,arc,dist,equ)
	if equ == 0 then
		equip = table.maxn(carto)
		equ = 1
	else
		equip = equ
	end
	local list = {}
	while equ <= equip do
		local wx = -dist/5
		while wx <= dist/5 do
			if ex/5+wx < table.maxn(carto[1]) then
				if ex/5+wx > 0 then
					local wy = -dist/5
					while wy <= dist/5 do
						if ey/5+wy < table.maxn(carto[1][1]) then
							if ey/5+wy > 0 then

								if math.sqrt(wx^2+wy^2) < dist/5+1 then

								--if math.abs(angle(A,math.atan2(wy,wx))) > arc+1 then
									table.insert(list,carto[equ][math.max(1,math.min(table.maxn(carto[1]),math.floor(ex/5+wx)))][math.max(1,math.min(table.maxn(carto[1][1]),math.floor(ey/5+wy)))])

								--end
								end
							end

						else
							wy = 100000
						end
						wy = wy+1
					end
				end

			else
				wx = 100000
			end
			wx = wx+1

		end

		equ = equ+1

	end

	return(list)
end



function I.MP(I,mx,my,bu)
	if hero ~= nil then
		hero.tipe.MP(hero.tipe,hero,mx,my,bu)
	else




	end
end
function I.MR(I,mx,my,bu)
	if hero ~= nil then
		hero.tipe.MR(hero.tipe,hero,mx,my,bu)
	else



	end
end
function I.KP(I,k)
	if hero ~= nil then
		hero.tipe.KP(hero.tipe,hero,k)
	else

	end
	if k == "escape" then
		love.event.push('q')
	end
end
function I.KR(I,k)
	if hero ~= nil then
		hero.tipe.KR(hero.tipe,hero,k)
	else



	end
end
function I.update(I,dot)

	moux = (love.mouse.getX()-love.graphics.getWidth()/2)/50/zoom/cam_z*(cam_z-mouz*zoom)+cam_x
	mouy = (love.mouse.getY()-love.graphics.getHeight()/2)/50/zoom/cam_z*(cam_z-mouz*zoom)+cam_y
	mouz = mouz+.1*(coliv(moux,mouy)-mouz)/zoom





	elu = elu+1
	if unit[elu] == nil then
		elu = 1
	end
	local w = 1
	while w < 50 do
		elu = elu+1
		if unit[elu] == nil then
			elu = 1
		end
		if unit[elu] == hero
		or unit[elu].mode == "mort" then
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
		hero.tipe.update_hero(hero.tipe,hero,dot)
	end
	for i,h in ipairs(drawlist) do
		h.mob = {}
	end
	for i,h in ipairs(unit) do
		reset_pos(h)
		h.m = .975*h.m
		h.n = .975*h.n
		h.o = .975*h.o
		h.x = h.x+h.m*dot
		h.y = h.y+h.n*dot
		h.z = h.z+h.o*dot*25

	end
	for i,h in ipairs(unit) do
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
			if math.abs(g.x-cam_x) < love.graphics.getWidth()/2/zoom
			and math.abs(g.y-cam_y) < love.graphics.getHeight()/2/zoom then
				table.insert(drawlist[math.min(29,math.floor(g.z/10))+1].mob,g)
			end
			if math.floor(g.frame) ~= g.lastframe then
				if g.sprite[math.floor(g.frame)].son ~= nil
				and g.sprite[math.floor(g.frame)].temposon < crono then
					table.insert(soundlist,{love.audio.newSource(g.sprite[math.floor(g.frame)].son),crono+5})
					soundlist[table.maxn(soundlist)][1]:setVolume(math.min(1,300/math.sqrt((g.x-cam_x)^2+(g.y-cam_y)^2+((g.z-cam_z)/zoom)^2)^1.3))
					love.audio.play(soundlist[table.maxn(soundlist)][1])
					g.sprite[math.floor(g.frame)].temposon = crono+.05
				end
			end
		end
	end
	for i,h in ipairs(obj) do
		for e,g in ipairs(h.app) do
			g.lastframe = math.floor(g.frame)
		end
		h.tipe.update(h.tipe,h,i,dot)
		for e,g in ipairs(h.app) do
			if math.abs(g.x-cam_x) < love.graphics.getWidth()/2/zoom
			and math.abs(g.y-cam_y) < love.graphics.getHeight()/2/zoom then
				ble.insert(drawlist[math.min(30,math.floor(g.z/10))+1].mob,g )
			end
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
				table.insert(drawlist[math.min(29,math.floor(g.z/10))+1].mob,g)
			end



			g.x = h.x
			g.y = h.y
			g.z = h.z
			g.A = h.A
			g.lastframe = math.floor(g.frame)
		end
		h.x = h.x+h.m*dot
		h.y = h.y+h.n*dot
		h.z = h.z+h.o*dot*25
		local speed = math.sqrt(h.m^2+h.n^2+h.o^2)
		if h.mode == "stand" then
			if speed > 0 then
				local spee = -25
				while spee < speed*dot do
					if coliv(h.x+h.m/speed*spee*dot,h.y+h.n/speed*spee*dot)+1 > h.z+h.o/speed*spee*dot*25 then
						while coliv(h.x+h.m/speed*spee*dot,h.y+h.n/speed*spee*dot)+1 > h.z+h.o/speed*spee*dot*25 do
							spee = spee-.5
						end
						while coliv(h.x+h.m/speed*spee*dot,h.y+h.n/speed*spee*dot)+1 > h.z+h.o/speed*spee*dot*25 do
							spee = spee+.1
						end
						while coliv(h.x+h.m/speed*spee*dot,h.y+h.n/speed*spee*dot)+1 > h.z+h.o/speed*spee*dot*25 do
							spee = spee-.02
						end
						h.x = h.x+h.m/speed*spee*dot
						h.y = h.y+h.n/speed*spee*dot
						h.z = h.z+h.o/speed*spee*dot*25
						h.mode = "mort"
						h.m = 0
						h.n = 0
						h.o = 0
						h.tipe.mort(h.tipe,h,i,"pierre")
						spee = 10000
					end
					if h.mode == "stand" then
						local id = nil
						local near = nil
						local dist = 1000
						local equi = 1
						if equi == h.equipe then
							equi = equi+1
						end
						while carto[equi] ~= nil do

							local list = test_pos(h.x,h.y,equi)
							for e,g in ipairs(list) do
								for u,k in ipairs(g) do
									if h.z > k.z
									and k.mode ~= "mort"
									and h.z < k.z+k.tipe.hauteur*25 then
										local dis = math.sqrt((h.x+h.m/speed*spee-k.x)^2+(h.y+h.n/speed*spee-k.y)^2)
										if dist > dis then
											dist = dis
											near = k
											id = u
										end
									end
								end
							end
							equi = equi+1
							if equi == h.equipe then
								equi = equi+1
							end
						end




						if near ~= nil
						and dist < h.tipe.colision+near.tipe.colision then
							h.mode = "mort"
							h.m = 0
							h.n = 0
							h.o = 0
							h.tipe.mort(h.tipe,h,i,"sang")
							near.santer = math.max(near.santer-math.random(h.tipe.domagemin,h.tipe.domagemax),0)
							if near.santer == 0 then
								near.tipe.mort(near.tipe,near,id)
								near.mode = "mort"
							else
								near.tipe.hit(near.tipe,near,id,h)
							end


						end
					end
					spee = spee+1
				end
			end
		elseif h.mode == "mort" then

			h.app[1].frame = math.min(h.app[1].frame+.15,table.maxn(h.app[1].sprite))


		end
		h.tipe.update(h.tipe,h,i,dot)
		for e,g in ipairs(h.app) do
			if math.floor(g.frame) ~= g.lastframe then
				if g.sprite[math.floor(g.frame)].son ~= nil
				and g.sprite[math.floor(g.frame)].temposon < crono then
					table.insert(soundlist,{love.audio.newSource(g.sprite[math.floor(g.frame)].son),crono+5})
					soundlist[table.maxn(soundlist)][1]:setVolume(math.min(1,300/math.sqrt((g.x-cam_x)^2+(g.y-cam_y)^2+(1000/zoom)^2)^1.3))
					love.audio.play(soundlist[table.maxn(soundlist)][1])
					g.sprite[math.floor(g.frame)].temposon = crono+.05
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
			h.app.z = h.app.z+h.p*25
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
			if math.abs(g.x-cam_x+.5)*50*zoom*cam_z/(cam_z-g.z*zoom) < love.graphics.getWidth()/2+50*cam_z/(cam_z-g.z*zoom)*zoom
			and math.abs(g.y-cam_y+.5)*50*zoom*cam_z/(cam_z-g.z*zoom) < love.graphics.getHeight()/2+50*cam_z/(cam_z-g.z*zoom)*zoom then



				if g.omb < 0 then

					love.graphics.setColor(255*(400+g.z)/650,255*(400+g.z)/650,255*(400+g.z)/650)
				else
					love.graphics.setColor(255*(400+g.z)/650-5*g.omb,255*(400+g.z)/650-5*g.omb,255*(400+g.z)/650-5*g.omb)
				end
				love.graphics.draw( g.tex[1].image , (g.x-cam_x+.5)*50*zoom*cam_z/(cam_z-g.z*zoom)+love.graphics.getWidth()/2 , (g.y-cam_y+.5)*50*zoom*cam_z/(cam_z-g.z*zoom)+love.graphics.getHeight()/2 ,0,zoom*cam_z/(cam_z-g.z*zoom)/2,zoom*cam_z/(cam_z-g.z*zoom)/2,g.tex[1].image:getWidth()/2,g.tex[1].image:getHeight()/2)
				if g.lum > 0 then
					love.graphics.setBlendMode( "additive" )
					love.graphics.setColor(255,255,255,10*g.lum)
					love.graphics.draw( lum , (g.x-cam_x+.5)*50*zoom*cam_z/(cam_z-g.z*zoom)+love.graphics.getWidth()/2 , (g.y-cam_y+.5)*50*zoom*cam_z/(cam_z-g.z*zoom)+love.graphics.getHeight()/2 ,0,zoom*cam_z/(cam_z-g.z*zoom)/2,zoom*cam_z/(cam_z-g.z*zoom)/2,57.5,57.5)
					love.graphics.setBlendMode( "alpha" )
				end
			end

		end
		for e,g in ipairs(h.mob) do

			if math.abs(g.x-cam_x+.5)*50*zoom*cam_z/(cam_z-g.z*zoom) < love.graphics.getWidth()/2+100*cam_z/(cam_z-g.z*zoom)*zoom
			and math.abs(g.y-cam_y+.5)*50*zoom*cam_z/(cam_z-g.z*zoom) < love.graphics.getHeight()/2+100*cam_z/(cam_z-g.z*zoom)*zoom then


				--love.graphics.setColor(2*g.z,2*g.z,2*g.z)
				love.graphics.setColor(255*(600+g.z)/850,255*(600+g.z)/850,255*(600+g.z)/850)
				love.graphics.draw( g.sprite[math.floor(g.frame)].image , (g.x-cam_x)*50*zoom*cam_z/(cam_z-g.z*zoom)+love.graphics.getWidth()/2 , (g.y-cam_y)*50*zoom*cam_z/(cam_z-g.z*zoom)+love.graphics.getHeight()/2 , math.atan2(((g.y+math.sin(g.A)*math.cos(g.Az)-cam_y)*50*zoom*cam_z/(cam_z-(g.z+math.sin(g.Az))*zoom)-(g.y-cam_y)*50*zoom*cam_z/(cam_z-g.z*zoom)),((g.x+math.cos(g.A)*math.cos(g.Az)-cam_x)*50*zoom*cam_z/(cam_z-(g.z+math.sin(g.Az))*zoom)-(g.x-cam_x)*50*zoom*cam_z/(cam_z-g.z*zoom))) ,zoom*cam_z/(cam_z-g.z*zoom)/2*math.cos(g.Az),zoom*cam_z/(cam_z-g.z*zoom)/2,g.sprite.x,g.sprite.y)
			end

		end
	end










	love.graphics.setColor(255,255,255)
	for e,g in ipairs(unit) do

		if g.cible ~= nil then
			love.graphics.draw( souris , (g.x-cam_x)*50*zoom*cam_z/(cam_z-g.z*zoom)+love.graphics.getWidth()/2 , (g.y-cam_y)*50*zoom*cam_z/(cam_z-g.z*zoom)+love.graphics.getHeight()/2 ,0,zoom*cam_z/(cam_z-g.z*zoom)/2,zoom*cam_z/(cam_z-g.z*zoom)/2)
		end

		love.graphics.print( g.mode , (g.x-cam_x)*50*zoom*cam_z/(cam_z-g.z*zoom)+love.graphics.getWidth()/2 , (g.y-cam_y)*50*zoom*cam_z/(cam_z-g.z*zoom)+love.graphics.getHeight()/2 ,0,zoom*cam_z/(cam_z-g.z*zoom)/8)
	end




			love.graphics.draw( souris , (unit[elu].x-cam_x)*50*zoom*cam_z/(cam_z-unit[elu].z*zoom)+love.graphics.getWidth()/2 , (unit[elu].y-cam_y)*50*zoom*cam_z/(cam_z-unit[elu].z*zoom)+love.graphics.getHeight()/2 ,1,zoom*cam_z/(cam_z-unit[elu].z*zoom)/2,zoom*cam_z/(cam_z-unit[elu].z*zoom)/2)


	love.graphics.draw( souris , (moux-cam_x)*50*zoom*cam_z/(cam_z-mouz*zoom)+love.graphics.getWidth()/2 , (mouy-cam_y)*50*zoom*cam_z/(cam_z-mouz*zoom)+love.graphics.getHeight()/2 ,mouA,zoom*cam_z/(cam_z-mouz*zoom)/2,zoom*cam_z/(cam_z-mouz*zoom)/2)


	love.graphics.print( fps , 30 , 30 )
	love.graphics.print( txt , 30 , 90 )
	love.graphics.print( zoom , 30 , 60 )

end

