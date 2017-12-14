
model_data_id = 0
local new = new_function(fonction,"load",0)
function new.F()
	model_id = 0

end
function load_model(lieux,nom)
	local new = {}
	new.id = model_data_id
	model_data_id = model_data_id+1
	if nom ~= nil then
		lieux = ""..lieux.."/"..nom..""
		new.nom = nom
	else
		new.nom = lieux
	end
	new.sprite_list = {}
	local list = love.filesystem.getDirectoryItems(""..lieux.."/sprite")
	for i,h in ipairs(list) do
		table.insert( new.sprite_list , {nom = h} )
	end
	for i,h in ipairs(new.sprite_list) do
		num = 1
		while love.filesystem.exists( ""..lieux.."/sprite/"..h.nom.."/"..num..".png" ) do
			h[num] = love.graphics.newImage(""..lieux.."/sprite/"..h.nom.."/"..num..".png")
			num = num+1
		end
		if num == 1 then
			while love.filesystem.exists( ""..lieux.."/sprite/"..h.nom.."/"..num..".gif" ) do
				h[num] = love.graphics.newImage(""..lieux.."/sprite/"..h.nom.."/"..num..".gif")
				h[num]:setFilter( "nearest","nearest" )
				num = num+1
			end
		end
	end
	new.bone = {}
	new.sprite = {}
	new.atach = {}
	new.input = {}
	if love.filesystem.exists( ""..lieux.."/scripte.lua" ) == true then
		M = new
		love.filesystem.load(""..lieux.."/scripte.lua" )()
	else
		love.filesystem.load("model/scripte.lua" )()
	end
	for u,k in ipairs(new.anim) do
		local temp = 0
		for e,g in ipairs(k) do
			g.id = e
			if e > 1 then
				g.prestep = k[e-1]
			else
				g.prestep = k[table.maxn(k)]
			end
			g.tempo = temp
			for i,h in ipairs(g.bone) do
				h.step = e
				h.anim = u
				for d,f in ipairs(k[h.prestep].bone) do
					if h.os == f.os then
						h.prestep = f
					end
				end
			end
			for i,h in ipairs(g.sprite) do
				h.step = e
				h.anim = u
				for d,f in ipairs(k[h.prestep].sprite) do
					if h.spr == f.spr then
						h.prestep = f
					end
				end
			end
			temp = temp+g.temp
		end
		for e,g in ipairs(k) do
			for i,h in ipairs(g.bone) do
				if h.step >= h.prestep.step then
					h.prestep.temp = math.abs(g.tempo-k[h.prestep.step].tempo)
				else
					h.prestep.temp = math.abs(g.tempo-k[h.prestep.step].tempo+(k[table.maxn(k)].tempo+k[table.maxn(k)].temp))
				end
			end
			for i,h in ipairs(g.sprite) do
				if h.step >= h.prestep.step then
					h.prestep.temp = math.abs(g.tempo-k[h.prestep.step].tempo)
				else
					h.prestep.temp = math.abs(g.tempo-k[h.prestep.step].tempo+(k[table.maxn(k)].tempo+k[table.maxn(k)].temp))
				end
			end
		end
		k.temp = k[table.maxn(k)].tempo+k[table.maxn(k)].temp
	end
	for i,h in ipairs(new.input) do
		new.input[h.nom] = i
	end
	return(new)
end
function create_model(model_data)

	local new = {}
	new.id = model_id
	model_id = model_id+1
	new.model_data = model_data
	new.bone = {}
	new.sprite = {}
	new.atach = {}
	new.anim = 1
	new.speed = 1
	new.temp = 0
	new.timer = {}
	new.timer.passer = 0
	new.timer.futur = 0
	new.orloge = 0
	new.input = {}
	for i,h in ipairs(new.model_data.bone) do
		table.insert( new.bone , create_bone( new , h ) )
	end
	for i,h in ipairs(new.model_data.sprite) do
		table.insert( new.sprite , create_sprite(new,h) )
	end
	for i,h in ipairs(new.model_data.atach) do
		table.insert( new.atach , create_atach(new,h) )
	end
	for i,h in ipairs(new.model_data.input) do
		local newo = {0,0}
		new.input[h.nom] = newo
		table.insert( new.input , newo )

	end
	new.frame = 0
	while new.frame < table.maxn(model_data.anim[1]) do
		new.frame = new.frame+1
		for i,h in ipairs(model_data.anim[1][new.frame].bone) do
			if new.model_data.bone[h.os].tete.tipe ~= 2 then
				new.bone[h.os].tete.anipos.passer = new.bone[h.os].tete.anipos.futur
				new.bone[h.os].tete.anipos.futur = h
				new.bone[h.os].tete.timer.passer = new.temp
				new.bone[h.os].tete.timer.futur = new.temp+h.temp
			end
		end
		for i,h in ipairs(model_data.anim[1][new.frame].sprite) do
			new.sprite[h.spr].anieta.passer = new.sprite[h.spr].anieta.futur
			new.sprite[h.spr].anieta.futur = h
			new.sprite[h.spr].timer.passer = new.temp
			new.sprite[h.spr].timer.futur = new.temp+h.temp
			new.sprite[h.spr].frame = h.prestep.eta.frame
		end
	end
	model_jump(new,new.anim,new.model_data.anim[new.anim][table.maxn(new.model_data.anim[new.anim])].tempo+new.model_data.anim[new.anim][table.maxn(new.model_data.anim[new.anim])].temp)


	return (new)
end
function is_model(data)
	return(data.bone ~= nil and data.sprite ~= nil )
end
function create_atach(model,data)
	local new = model.bone[data.chef].tete.pos
	model.atach[data.nom] = new
	new.atach_data = data
	for i,h in ipairs(model.model_data.atach) do
		h.id = i
	end
	return (new)
end
function create_sprite(model,data)
	if data.alpha == nil then
		data.alpha = 255
	end
	local new = {	frame = 1 ,
			temp = 0 ,
			sprite_data = data ,
			alpha = data.alpha	}
	new.anieta = {}
	new.anieta.passer = { eta = { frame = 1 , alpha = data.alpha} , eritrot=1 ,temp = 1}
	new.anieta.futur = { eta = { frame = 1 , alpha = data.alpha } , eritrot=1, prestep = new.anieta.futur ,temp = 1}
	new.anieta.passer.prestep = new.anieta.futur
	new.timer = { passer = 0 , futur = .1}
	return (new)
end
function create_bone(model,data)
	local newbone = {}
	if data.base.tipe == 0 then
		newbone.base = { pos = data.base.pos }
		newbone.base.pos.A = 0
		newbone.base.pos.scale = 1
	elseif data.base.tipe == 1 then
		newbone.base = model.bone[data.base.pos].tete
	end
	if data.tete.tipe == 0 then
		newbone.tete = {}
		newbone.tete.pos = {}
		newbone.tete.pos.X = 0
		newbone.tete.pos.Y = 0
		newbone.tete.pos.A = 0
		newbone.tete.input = 0
		newbone.tete.pos.scale = 1
		newbone.tete.anipos = {}
		newbone.tete.anipos.passer =  { pos = {X=newbone.base.pos.X,Y=newbone.base.pos.Y}}
		newbone.tete.anipos.futur = { pos = {X=newbone.base.pos.X,Y=newbone.base.pos.Y} , prestep = newbone.tete.anipos.passer }
		newbone.tete.anipos.passer.prestep = newbone.tete.anipos.futur
		newbone.tete.timer = { passer = 0 , futur = .1}
	elseif data.tete.tipe == 1 then
		newbone.tete = {}
		newbone.tete.pos = {}
		newbone.tete.pos.X = 0
		newbone.tete.pos.Y = 0
		newbone.tete.pos.A = 0
		newbone.tete.input = 0
		newbone.tete.pos.scale = 1
		newbone.tete.vec = {	D = 0 ,
					L = 1 ,
					eritrot = 0
						 }
		newbone.tete.anipos = {}
		newbone.tete.anipos.passer = { pos = {D = 0 , L = 1} , eritrot=1 }
		newbone.tete.anipos.futur = { pos = {D = 0 , L = 1} , eritrot=1, prestep = newbone.tete.anipos.futur }
		newbone.tete.anipos.passer.prestep = newbone.tete.anipos.futur
		newbone.tete.timer = { passer = 0 , futur = .1}
	elseif data.tete.tipe == 2 then
		newbone.tete = {}
		newbone.tete.pose = model.bone[data.tete.pos].tete.pos
		newbone.tete.pos = {}
		newbone.tete.pos.X = 0
		newbone.tete.pos.Y = 0
		newbone.tete.pos.A = 0
		newbone.tete.input = 0
		newbone.tete.pos.scale = 1
	end
	return (newbone)
end
function model_jump(model,anim,temp,speed)
	if model.anim ~= anim then
		model.frame = 1
		model.anim = anim
		model.temp = 0
		model.orloge = 0
		model.timer.passer = 0
		model.timer.futur = model.model_data.anim[anim][1].temp
		for i,h in ipairs(model.bone) do
			if model.model_data.bone[i].tete.tipe == 0 then
				h.tete.anipos.passer =  { pos = {X=h.tete.pos.X,Y=h.tete.pos.Y},temp = .1}
				h.tete.anipos.futur = { pos = {X=h.tete.pos.X,Y=h.tete.pos.Y} , prestep = h.tete.anipos.passer,temp = .1 }
				h.tete.anipos.passer.prestep = h.tete.anipos.futur
				h.tete.timer = { passer = 0 , futur = .1}
			elseif model.model_data.bone[i].tete.tipe == 1 then
				h.tete.anipos.passer = { pos = {D = h.tete.vec.D , L = h.tete.vec.L} , eritrot=h.tete.vec.eritrot,temp = .1 }
				h.tete.anipos.futur = { pos = {D = h.tete.vec.D , L = h.tete.vec.L} , eritrot=h.tete.vec.eritrot, prestep = h.tete.anipos.futur,temp = .1 }
				h.tete.anipos.passer.prestep = h.tete.anipos.futur
				h.tete.timer = { passer = 0 , futur = .1}
			end
		end
		for i,h in ipairs(model.sprite) do
			h.anieta.passer = { eta = { frame = h.frame , alpha = h.alpha} ,temp = .1}
			h.anieta.futur = { eta = { frame = h.frame , alpha = h.alpha } , prestep = h.anieta.futur ,temp = .1}
			h.anieta.passer.prestep = h.anieta.futur
			h.timer = { passer = 0 , futur = .1}
		end
	end

	if temp == nil then
		temp = 0
	end
	if  speed == nil then
		speed = model.speed
	end
	if temp < model.temp then
		 model.speed = -1*world.speed
	else
		 model.speed = 1*world.speed
	end
	model.temp = temp
	update_model(model,0)
	model.speed = speed
end
function update_model(model,dot)
	--txt = txt+1
	if model ~= nil
	and model.speed*world.speed ~= 0
	and model.model_data.anim[model.anim] ~=nil ~=nil then
		model.temp = model.temp+dot*model.speed*world.speed
		if model.speed*world.speed > 0 then
			if model.temp >= model.timer.futur then
				while model.temp >= model.timer.futur do
					model.frame = model.frame+1
					if model.frame > table.maxn(model.model_data.anim[model.anim]) then
						model.orloge = model.timer.futur
						model.frame = 1
					end
					model.timer.passer = model.timer.futur
					model.timer.futur = model.timer.futur+model.model_data.anim[model.anim][model.frame].temp
					for i,h in ipairs(model.model_data.anim[model.anim][model.frame].bone) do
						if model.model_data.bone[h.os].tete.tipe ~= 2 then
							model.bone[h.os].tete.anipos.passer = model.bone[h.os].tete.anipos.futur
							model.bone[h.os].tete.anipos.futur = h
							model.bone[h.os].tete.timer.passer = model.timer.passer
							model.bone[h.os].tete.timer.futur = model.bone[h.os].tete.timer.passer+h.temp
						end
					end
					for i,h in ipairs(model.model_data.anim[model.anim][model.frame].sprite) do
						model.sprite[h.spr].anieta.passer = model.sprite[h.spr].anieta.futur
						model.sprite[h.spr].anieta.futur = h
						model.sprite[h.spr].timer.passer = model.timer.passer
						model.sprite[h.spr].timer.futur = model.sprite[h.spr].timer.passer+h.temp
						model.sprite[h.spr].frame = h.prestep.eta.frame
					end
				end
			end
		else----------------------------------------------------------------
			if model.temp <= model.timer.passer then
				while model.temp <= model.timer.passer do
					for i,h in ipairs(model.model_data.anim[model.anim][model.frame].bone) do
						if model.model_data.bone[h.os].tete.tipe ~= 2 then
							model.bone[h.os].tete.anipos.futur = model.bone[h.os].tete.anipos.passer
							model.bone[h.os].tete.anipos.passer = h.prestep.prestep
	 						model.bone[h.os].tete.timer.futur = model.timer.passer
							model.bone[h.os].tete.timer.passer = model.timer.passer-model.bone[h.os].tete.anipos.futur.temp
						end
					end
					for i,h in ipairs(model.model_data.anim[model.anim][model.frame].sprite) do
						model.sprite[h.spr].frame = h.prestep.prestep.eta.frame
						model.sprite[h.spr].anieta.futur = model.sprite[h.spr].anieta.passer
						model.sprite[h.spr].anieta.passer = h.prestep.prestep
						model.sprite[h.spr].timer.futur = model.timer.passer
						model.sprite[h.spr].timer.passer = model.timer.passer-model.sprite[h.spr].anieta.futur.temp
					end
					model.frame = model.frame-1
					if model.frame < 1 then
						model.frame = table.maxn(model.model_data.anim[model.anim])
						model.orloge = model.timer.passer-model.model_data.anim[model.anim][model.frame].tempo-model.model_data.anim[model.anim][model.frame].temp
					end
					model.timer.futur = model.timer.passer
					model.timer.passer = model.timer.futur-model.model_data.anim[model.anim][model.frame].temp
				end
			end
		end-------------------------------------------------------------------
		for i,h in ipairs(model.bone) do
			local ratio = 0
			if model.model_data.bone[i].tete.tipe ~= 2 then
				ratio = math.max(0,math.min(1,(model.temp-h.tete.timer.passer)/math.max(.00001,h.tete.timer.futur-h.tete.timer.passer)))
			end
			if model.model_data.bone[i].tete.tipe == 0 then
				h.tete.pos.X = h.tete.anipos.passer.pos.X+(h.tete.anipos.futur.pos.X-h.tete.anipos.passer.pos.X)*ratio
				h.tete.pos.Y = h.tete.anipos.passer.pos.Y+(h.tete.anipos.futur.pos.Y-h.tete.anipos.passer.pos.Y)*ratio
				if model.model_data.bone[i].tete.input ~= nil then
					h.tete.input = h.tete.anipos.passer.input+(h.tete.anipos.futur.input-h.tete.anipos.passer.input)*ratio
					h.tete.pos.X = h.tete.pos.X+model.input[model.model_data.bone[i].tete.input][1]*h.tete.input
					h.tete.pos.Y = h.tete.pos.Y+model.input[model.model_data.bone[i].tete.input][2]*h.tete.input
				end
				h.tete.pos.A = math.atan2((h.tete.pos.Y-h.base.pos.Y),(h.tete.pos.X-h.base.pos.X))
				h.tete.pos.scale = math.sqrt((h.tete.pos.X-h.base.pos.X)^2+(h.tete.pos.Y-h.base.pos.Y)^2)/model.model_data.bone[i].tete.L
			elseif model.model_data.bone[i].tete.tipe == 1 then
				h.tete.vec.D = h.tete.anipos.passer.pos.D+angle(h.tete.anipos.passer.pos.D,h.tete.anipos.futur.pos.D)*ratio
				h.tete.vec.L = h.tete.anipos.passer.pos.L+(h.tete.anipos.futur.pos.L-h.tete.anipos.passer.pos.L)*ratio
				h.tete.vec.eritrot = h.tete.anipos.passer.eritrot+(h.tete.anipos.futur.eritrot-h.tete.anipos.passer.eritrot)*ratio
				h.tete.pos.A = h.tete.vec.D+angle(h.tete.vec.D,h.base.pos.A+h.tete.vec.D)*h.tete.vec.eritrot
				if model.model_data.bone[i].tete.input ~= nil then
					h.tete.input = h.tete.anipos.passer.input+(h.tete.anipos.futur.input-h.tete.anipos.passer.input)*ratio
					h.tete.pos.A = h.tete.pos.A+angle(h.tete.pos.A,h.tete.pos.A+model.input[model.model_data.bone[i].tete.input][1])*h.tete.input
				end
				h.tete.pos.scale = h.tete.vec.L/model.model_data.bone[i].tete.L
				h.tete.pos.X = h.base.pos.X+h.tete.vec.L*math.cos(h.tete.pos.A)
				h.tete.pos.Y = h.base.pos.Y+h.tete.vec.L*math.sin(h.tete.pos.A)
			elseif model.model_data.bone[i].tete.tipe == 2 then
				h.tete.pos.X = h.tete.pose.X
				h.tete.pos.Y = h.tete.pose.Y
				h.tete.pos.A = math.atan2((h.tete.pos.Y-h.base.pos.Y),(h.tete.pos.X-h.base.pos.X))
				h.tete.pos.scale = math.sqrt((h.tete.pos.X-h.base.pos.X)^2+(h.tete.pos.Y-h.base.pos.Y)^2)/model.model_data.bone[i].tete.L
			end
		end
		for i,h in ipairs(model.sprite) do
			local ratio = math.max(0,math.min(1,math.abs((model.temp-h.timer.passer)/math.max(.00001,h.timer.futur-h.timer.passer))))
			h.alpha = h.anieta.passer.eta.alpha+(h.anieta.futur.eta.alpha-h.anieta.passer.eta.alpha)*ratio
		end
	end
end
function draw_model(model,X,Y,A,sX,sY)
	if A == nil then
		A = 0
		sX = 1
		sY = 1
	elseif sX == nil then
		sX = 1
		sY = 1
	elseif sY == nil then
		sY = 1
	end
	r, g, b, al = love.graphics.getColor( )
	for i,h in ipairs(model.sprite) do

		love.graphics.setColor(r,g,b,255*h.alpha*al)
		local img = model.model_data.sprite_list[model.model_data.sprite[i].sprite][h.frame]
		local a = A+model.bone[model.model_data.sprite[i].chef].tete.pos.A
		local eA = (-(sX/sY)*math.pi/2+math.pi/2)+(sX/sY)*(A+model.bone[model.model_data.sprite[i].chef].tete.pos.A*model.model_data.sprite[i].eritrot+model.model_data.sprite[i].A)
		local scale = model.bone[model.model_data.sprite[i].chef].tete.pos.scale
		if model.model_data.sprite[i].eritscale == 0 then
			local eX = X+sX*(model.bone[model.model_data.sprite[i].chef].base.pos.X+model.model_data.sprite[i].L*math.cos(model.model_data.sprite[i].D+a))
			local eY = Y+sY*(model.bone[model.model_data.sprite[i].chef].base.pos.Y+model.model_data.sprite[i].L*math.sin(model.model_data.sprite[i].D+a))

			draw( 	img ,
				eX ,
				eY ,
				-(-(sX/sY)*math.pi/2+math.pi/2)+eA ,
				sX*model.model_data.sprite[i].sx ,
				sY*model.model_data.sprite[i].sy ,
				img:getWidth()/2 ,
				img:getHeight()/2 )
		elseif model.model_data.sprite[i].eritscale == 1 then


			local eX = X+sX*(model.bone[model.model_data.sprite[i].chef].base.pos.X+model.model_data.sprite[i].X*math.cos(a)*scale+model.model_data.sprite[i].Y*math.sin(a))
			local eY = Y+sY*(model.bone[model.model_data.sprite[i].chef].base.pos.Y+model.model_data.sprite[i].X*math.sin(a)*scale-model.model_data.sprite[i].Y*math.cos(a))
			love.graphics.draw( 	img,
						eX ,
						eY ,
						-(-(sX/sY)*math.pi/2+math.pi/2)+eA ,
						sX*model.model_data.sprite[i].sx*(1-(1-scale)*math.abs(math.cos(model.model_data.sprite[i].A))) ,
						sY*model.model_data.sprite[i].sy*(1-(1-scale)*math.abs(math.sin(model.model_data.sprite[i].A))) ,
						img:getWidth()/2 ,
						img:getHeight()/2 )
		elseif model.model_data.sprite[i].eritscale == 2 then
			local eX = X+sX*(model.bone[model.model_data.sprite[i].chef].base.pos.X+model.model_data.sprite[i].L*math.cos(model.model_data.sprite[i].D+a)*scale)
			local eY = Y+sY*(model.bone[model.model_data.sprite[i].chef].base.pos.Y+model.model_data.sprite[i].L*math.sin(model.model_data.sprite[i].D+a)*scale)
			love.graphics.draw(	img ,
						eX ,
						eY ,
						-(-(sX/sY)*math.pi/2+math.pi/2)+eA ,
						sX*model.model_data.sprite[i].sx*scale ,
						sY*model.model_data.sprite[i].sy*scale ,
						img:getWidth()/2 ,
						img:getHeight()/2 )
		end
	end
	love.graphics.setColor(r,g,b,al)
end
