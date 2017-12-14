function model_load()
	app = {}
	prefix = {	"",
			"sans",
			"tete",
			"bouche",
			"epaule",
			"avant_bras",
			"main",
			"torce",
			"ventre",
			"henche",
			"cuisse",
			"tipias",
			"pied",
			"arme",
			"autre"
			}
	sufix = {	"",
			"nom",
			"gauche",
			"droite",
			"haut",
			"bas"
			}
	model = {}
	local list = love.filesystem.getDirectoryItems("Data/app/model")
	for i,h in ipairs(list) do
		table.insert( model , {nom = h , spritelist = {} } )
	end
	for i,h in ipairs(model) do
		_G["model_"..(h.nom)..""] = h
		local list = love.filesystem.getDirectoryItems("Data/app/model/"..h.nom.."/sprite")
		for e,g in ipairs(list) do
			table.insert( h.spritelist , {nom = g,sprite = {}} )
		end
		for e,g in ipairs(h.spritelist) do
			_G["model_"..(h.nom).."_sprite_"..g.nom..""] = g
			num = 1
			while love.filesystem.exists( "Data/app/model/"..h.nom.."/sprite/"..g.nom.."/"..num..".png" ) == true do
				table.insert(g.sprite,{image = love.graphics.newImage("Data/app/model/"..h.nom.."/sprite/"..g.nom.."/"..num..".png")})
				num = num+1
			end
			if num == 1 then
				while love.filesystem.exists( "Data/app/model/"..h.nom.."/sprite/"..g.nom.."/"..num..".gif" ) == true do
					table.insert(g.sprite,{image = love.graphics.newImage("Data/app/model/"..h.nom.."/sprite/"..g.nom.."/"..num..".gif")})
					g.sprite[num].image:setFilter( "nearest","nearest" )
					num = num+1
				end
			end
		end
		love.filesystem.load("Data/app/model/"..h.nom.."/scripte.lua" )()

		h.bone = bones
		h.animation = animations
		h.sprite = sprites
		h.atach = atachs
		local w = 1
		while w < 4 do
			for e,g in ipairs(h.bone) do
				if g.debut.tipe == 1 then
					if h.bone[g.debut.chef].fin.X ~= nil then
						g.debut.X = h.bone[g.debut.chef].fin.X
					else
						g.debut.X = 0
					end
					if h.bone[g.debut.chef].fin.Y ~= nil then
						g.debut.Y = h.bone[g.debut.chef].fin.Y
					else
						g.debut.Y = 0
					end
				end
				if g.fin.tipe == 0 then
					if g.fin.X ~= g.anim[1][1].X
					or g.fin.Y ~= g.anim[1][1].Y then
						g.fin.X = g.anim[1][1].X
						g.fin.Y = g.anim[1][1].Y
					end
					g.fin.A = math.atan2((g.fin.Y-g.debut.Y),(g.fin.X-g.debut.X))
				elseif g.fin.tipe == 1 then
					if h.bone[g.fin.chef].fin.X ~= nil then
						g.fin.X = h.bone[g.fin.chef].fin.X
					else
						g.fin.X = 0
					end
					if h.bone[g.fin.chef].fin.Y ~= nil then
						g.fin.Y = h.bone[g.fin.chef].fin.Y
					else
						g.fin.Y = 0
					end
				elseif g.fin.tipe == 2 then
					if g.fin.angle ~= g.anim[1][1].angle
					or g.fin.L ~= g.anim[1][1].L then
						g.fin.angle = g.anim[1][1].angle
						g.fin.L = g.anim[1][1].L
					end
					if g.debut.tipe == 1
					and g.eritrot == true then
						g.fin.A = h.bone[g.debut.chef].fin.A+g.fin.angle
						g.fin.X = g.debut.X+g.fin.L*math.cos(g.fin.A)
						g.fin.Y = g.debut.Y+g.fin.L*math.sin(g.fin.A)
					else
						g.fin.A = g.fin.angle
						g.fin.X = g.debut.X+g.fin.L*math.cos(g.fin.A)
						g.fin.Y = g.debut.Y+g.fin.L*math.sin(g.fin.A)
					end
				end
			end
			w = w+1
		end
		for e,g in ipairs(h.bone) do
			g.fin.A = math.atan2((g.fin.Y-g.debut.Y),(g.fin.X-g.debut.X))
			g.fin.sx = math.sqrt((g.debut.X-g.fin.X)^2+(g.debut.Y-g.fin.Y)^2)/g.fin.long
		end
		for e,g in ipairs(h.sprite) do
			g.sprite = h.spritelist[g.sprite]

		end
		for e,g in ipairs(h.atach) do
			g.nom = ""..prefix[g.nom[1]].."_"..sufix[g.nom[2]].."_"..g.nom[3]..""
		end
	end
end
function model_create(model2,eX,eY,eZ,A,sens)

	table.insert(app , {	model = model2,
				X = eX,
				Y = eY,
				Z = eZ,
				etat = "normal",
				A = A,
				alpha = 1 ,
				sc = 1,
				sx = sens,
				anim = 1,
				frame = 1,
				lastanim = 1,
				lastframe = 1,
				nextanim = 1,
				ratio = 0,
				timer = 0,
				speed = 1,
				bone = {},
				atach = {},
				input = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
						 } )
	local newp = app[table.maxn(app)]
	for i,h in ipairs(model2.bone) do
		newp.bone[i] = {debut = { X = h.debut.X , Y = h.debut.Y },
				fin = {X = h.fin.X ,Y = h.fin.Y , A = h.fin.A , sx = h.fin.sx}
					}
	end
	for i,h in ipairs(model2.atach) do
		newp.atach[i] = {X = 0 , Y = 0 , A = model2.atach[i].pA , sc = 1 }
	end

end
function frame_pulse(app,anim,frame,mem)
	local out = false
	if mem == nil then
		mem = false
	end
	if app.app.anim == anim
	and app.app.frame == frame then
		if mem == false then
			mem = true
			out = true
		end
	else
		if mem == true then
			mem = false
		end
	end
	return mem,out
end
function model_update(dot)


	w = table.maxn(app)
	while w > 1 do
		if app[w-1].Y > app[w].Y then
			app[w-1],app[w] = app[w],app[w-1]
		end
		w = w-1
	end
	for e,g in ipairs(app) do
		if e > 1 then
			if app[e-1].Y > app[e].Y then
				app[e-1],app[e] = app[e],app[e-1]
			end
		end
	end





	for e,g in ipairs(app) do
		if g.etat == "fini" then
			table.remove(app,e)
		else
			if g.nextanim ~= g.anim then
				g.timer = g.timer-dot*g.speed*5
			else
				g.timer = g.timer-dot*g.speed
			end
			if g.speed > 0 then
				if g.timer < 0 then
					g.lastframe = g.frame
					g.lastanim = g.anim
					if g.nextanim ~= g.anim then
						g.frame = 1
						g.anim = g.nextanim
					else
						if g.frame >= table.maxn(g.model.animation[g.anim]) then
							g.frame = 1
						else
							g.frame = g.frame+1
						end
					end
					g.timer = g.model.animation[g.anim][g.frame].tempo
				end
			elseif g.speed < 0 then
				if g.timer > g.model.animation[g.anim][g.frame].tempo then
					g.frame = g.lastframe
					g.lastanim = g.anim
					if g.nextanim ~= g.anim then
						g.lastframe = table.maxn(g.model.animation[g.nextanim])
						g.anim = g.nextanim
					else
						if g.lastframe <= 1 then
							g.lastframe = table.maxn(g.model.animation[g.anim])
						else
							g.lastframe = g.lastframe-1
						end
					end
					g.timer = 0
				end
			end
			g.ratio = g.timer/g.model.animation[g.anim][g.frame].tempo
			if inview(g.X,g.Y,60) == true then
				for i,h in ipairs(g.bone) do
					if g.model.bone[i].debut.tipe == 1 then
						h.debut.X = g.bone[g.model.bone[i].debut.chef].fin.X
						h.debut.Y = g.bone[g.model.bone[i].debut.chef].fin.Y
					end
					if g.model.bone[i].fin.tipe == 0 then
						h.fin.X = g.model.bone[i].anim[g.lastanim][g.lastframe].X*g.ratio+g.model.bone[i].anim[g.anim][g.frame].X*(1-g.ratio)
						h.fin.Y = g.model.bone[i].anim[g.lastanim][g.lastframe].Y*g.ratio+g.model.bone[i].anim[g.anim][g.frame].Y*(1-g.ratio)
						if g.model.bone[i].input ~= 0 then
							local inratio = g.model.bone[i].anim[g.lastanim][g.lastframe].inratio*g.ratio+g.model.bone[i].anim[g.anim][g.frame].inratio*(1-g.ratio)
							h.fin.X = h.fin.X+(inratio*(g.input[g.model.bone[i].input]-g.model.bone[i].input_dev-h.fin.X))*g.sx
							h.fin.Y = h.fin.Y+inratio*(g.input[g.model.bone[i].input+1]-g.model.bone[i].input_dev2-h.fin.Y)
						end
						h.fin.A = math.atan2((h.fin.Y-h.debut.Y),(h.fin.X-h.debut.X))
					elseif g.model.bone[i].fin.tipe == 1 then
						h.fin.X = g.bone[g.model.bone[i].fin.chef].fin.X
						h.fin.Y = g.bone[g.model.bone[i].fin.chef].fin.Y
					elseif g.model.bone[i].fin.tipe == 2 then
						h.fin.angle = g.model.bone[i].anim[g.lastanim][g.lastframe].angle+angle(g.model.bone[i].anim[g.lastanim][g.lastframe].angle,g.model.bone[i].anim[g.anim][g.frame].angle)*(1-g.ratio)
						h.fin.L = g.model.bone[i].anim[g.lastanim][g.lastframe].L*g.ratio+g.model.bone[i].anim[g.anim][g.frame].L*(1-g.ratio)
						if g.model.bone[i].debut.tipe == 1
						and g.model.bone[i].eritrot == true then
							h.fin.A = g.bone[g.model.bone[i].debut.chef].fin.A+h.fin.angle
						else
							h.fin.A = h.fin.angle
						end
						if g.model.bone[i].input ~= 0 then
							local inratio = g.model.bone[i].anim[g.lastanim][g.lastframe].inratio*g.ratio+g.model.bone[i].anim[g.anim][g.frame].inratio*(1-g.ratio)
						--	h.fin.A = h.fin.A-g.model.bone[i].input_ratio*angle(math.pi+(angle(math.pi/2,(g.input[g.model.bone[i].input]+g.model.bone[i].input_dev))+math.pi/2-g.A)*g.sx,h.fin.A)
						--	h.fin.A = h.fin.A+g.model.bone[i].input_ratio*angle(h.fin.A,g.input[g.model.bone[i].input]-g.model.bone[i].input_dev-g.A)
							h.fin.A = h.fin.A+inratio*angle(h.fin.A,math.pi/2+g.sx*angle(math.pi/2,g.input[g.model.bone[i].input]-g.A)-g.model.bone[i].input_dev)
						end
						h.fin.X = h.debut.X+h.fin.L*math.cos(h.fin.A)
						h.fin.Y = h.debut.Y+h.fin.L*math.sin(h.fin.A)
						h.fin.A = math.atan2((h.fin.Y-h.debut.Y),(h.fin.X-h.debut.X))*g.sx
					end
						h.fin.A = math.atan2((h.fin.Y-h.debut.Y),(h.fin.X-h.debut.X))
						h.fin.sx = math.sqrt((h.debut.X-h.fin.X)^2+(h.debut.Y-h.fin.Y)^2)/g.model.bone[i].fin.long

					if fps < 39 then
						i = i+math.floor(math.random(40-fps))
					else
						i = i+1
					end


				end
				for i,h in ipairs(g.atach) do
					local ex = 0
					local ey = 0
					local eA = 0
					local esx = 1
					if h.eritscale == 0 then
						ex = g.bone[g.model.atach[i].chef].debut.X+(h.px*	math.cos(g.bone[h.chef].fin.A)+h.py*	math.sin(g.bone[h.chef].fin.A))
						ey = g.bone[g.model.atach[i].chef].debut.Y+h.py*	-math.cos(g.bone[h.chef].fin.A)+h.px*	math.sin(g.bone[h.chef].fin.A)
					elseif h.eritscale == 1 then
						ex = g.bone[h.chef].debut.X+(g.bone[h.chef].fin.sx*h.px*math.cos(g.bone[h.chef].fin.A)+h.py*			math.sin(g.bone[h.chef].fin.A))
						ey = g.bone[h.chef].debut.Y+h.py*		-math.cos(g.bone[h.chef].fin.A)+g.bone[h.chef].fin.sx*h.px*	math.sin(g.bone[h.chef].fin.A)
					elseif h.eritscale == 2 then
						ex = g.bone[h.chef].debut.X+(g.bone[h.chef].fin.sx*(h.px*	math.cos(g.bone[h.chef].fin.A)+h.py*	math.sin(g.bone[h.chef].fin.A)))
						ey = g.bone[h.chef].debut.Y+g.bone[h.chef].fin.sx*(h.py*-	math.cos(g.bone[h.chef].fin.A)+h.px*	math.sin(g.bone[h.chef].fin.A))
					end
					ex = g.bone[g.model.atach[i].chef].debut.X
					ey = g.bone[g.model.atach[i].chef].debut.Y
					if g.model.atach[i].eritrot == true then
						eA = g.bone[g.model.atach[i].chef].fin.A+g.model.atach[i].pA
					else
						eA = g.model.atach[i].pA
					end
					h.sc = g.bone[g.model.atach[i].chef].fin.sx
					h.X = g.X+g.sc*g.sx*ex*math.cos(g.A)-g.sc*ey*math.sin(g.A)
					h.Y = g.Y+g.sc*ey*math.cos(g.A)+g.sc*g.sx*ex*math.sin(g.A)
					h.A = eA+g.A
				end
			end
		end
	end
end
function model_draw()
	for e,g in ipairs(app) do
		if inview(g.X,g.Y,60) == true then
			for i,h in ipairs(g.model.sprite) do
				local ex = 0
				local ey = 0
				local eA = 0
				local esx = 1
				local esy = 1
				if h.eritscale == 0 then
					ex = g.bone[h.chef].debut.X+(h.px*	math.cos(g.bone[h.chef].fin.A)+h.py*	math.sin(g.bone[h.chef].fin.A))
					ey = g.bone[h.chef].debut.Y+h.py*	-math.cos(g.bone[h.chef].fin.A)+h.px*	math.sin(g.bone[h.chef].fin.A)
				elseif h.eritscale == 1 then
					ex = g.bone[h.chef].debut.X+(g.bone[h.chef].fin.sx*h.px*math.cos(g.bone[h.chef].fin.A)+h.py*			math.sin(g.bone[h.chef].fin.A))
					ey = g.bone[h.chef].debut.Y+h.py*		-math.cos(g.bone[h.chef].fin.A)+g.bone[h.chef].fin.sx*h.px*	math.sin(g.bone[h.chef].fin.A)
				elseif h.eritscale == 2 then
					ex = g.bone[h.chef].debut.X+(g.bone[h.chef].fin.sx*(h.px*	math.cos(g.bone[h.chef].fin.A)+h.py*	math.sin(g.bone[h.chef].fin.A)))
					ey = g.bone[h.chef].debut.Y+g.bone[h.chef].fin.sx*(h.py*-	math.cos(g.bone[h.chef].fin.A)+h.px*	math.sin(g.bone[h.chef].fin.A))
				end
				if h.eritrot == true then
					eA = (g.bone[h.chef].fin.A+h.pA)*g.sx
					if h.eritscale == 1 then
						if math.abs(h.pA)  < 1 then
							esx = g.bone[h.chef].fin.sx*h.psx
							esy = h.psy
						elseif math.abs(h.pA-math.pi/2)  < 1 then
							esy = g.bone[h.chef].fin.sx*h.psy
							esx = h.psx
						elseif math.abs(h.pA-math.pi )  < 1 then
							esx = g.bone[h.chef].fin.sx*h.psx
							esy = h.psy
						elseif math.abs(h.pA-math.pi/2*3)  < 1 then
							esy = g.bone[h.chef].fin.sx*h.psy
							esx = h.psx
						end
					elseif h.eritscale == 2 then
						esx = g.bone[h.chef].fin.sx*h.psx
						esy = g.bone[h.chef].fin.sx*h.psy
					else
						esy = h.psy
						esx = h.psx
					end
				--	love.graphics.print( 	g.bone[h.chef].fin.A ,
				--			 	(g.X+g.sx*g.sc*ex*math.cos(g.A)-g.sc*ey*math.sin(g.A)-cam_x  )*zoom+love.graphics.getWidth()/2 ,
				--				(g.Y+g.sc*ey*math.cos(g.A)+g.sx*g.sc*ex*math.sin(g.A)-cam_y-g.Z  )*zoom+love.graphics.getHeight()/2
				--				 )

				else
					esy = h.psy
					esx = h.psx

				end

			--	eA = g.sx*eA
				love.graphics.setColor(255,255,255,(h.anim[g.lastanim][g.lastframe].alpha*g.ratio+h.anim[g.anim][g.frame].alpha*(1-g.ratio))*g.alpha)
				love.graphics.draw( 	h.sprite.sprite[math.floor(h.anim[g.anim][g.frame].frame)].image ,
							(g.X+g.sx*g.sc*ex*math.cos(g.A)-g.sc*ey*math.sin(g.A)-cam_x  )*zoom+love.graphics.getWidth()/2 ,
							(g.Y+g.sc*ey*math.cos(g.A)+g.sx*g.sc*ex*math.sin(g.A)-cam_y-g.Z  )*zoom+love.graphics.getHeight()/2 ,
							eA+g.A,
							g.sx*g.sc*esx*zoom,
							g.sc*esy*zoom,
							h.sprite.sprite[math.floor(h.anim[g.anim][g.frame].frame)].image:getWidth()/2,
							h.sprite.sprite[math.floor(h.anim[g.anim][g.frame].frame)].image:getHeight()/2)
			end
			love.graphics.setColor(255,255,255)
		--	love.graphics.print( g.etat , 	(g.X-cam_x )*zoom+love.graphics.getWidth()/2 ,
		--					 	(g.Y-cam_y )*zoom+love.graphics.getHeight()/2
		--					 )
		end
	end
end
