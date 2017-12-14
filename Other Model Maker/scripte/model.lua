local new = new_function(fonction,"load",0)
function new.F()
	model_data_id = 1
	model = {}
	rapporter_erreur( "scripte des model loader")
end
function load_model(lieux,nom)
	local new = {}
	new.id = model_data_id
	model_data_id = model_data_id+1
	if nom then
		lieux = ""..lieux.."/"..nom..""
		new.nom = nom
	else
		new.nom = lieux
	end
	model[new.nom] = new
	new.bone = {}
	new.anim = {}
	if love.filesystem.exists( ""..lieux.."/scripte.lua" ) == true then
		M = new
		love.filesystem.load(""..lieux.."/scripte.lua" )()
	else
		rapporter_erreur( "problème de chargement du modèle "..nom..", Scripte inexistant")
	end
	for i,h in ipairs(new.bone) do
		new.bone[h.nom] = h
	end
	for i,h in ipairs(new.anim) do
		new.anim[h.nom] = h
	end

	return (new)
end
function create_model(model_data)
	local new = {}
	new.data = model_data
	new.bone = {}
	new.anim = 1
	new.speed = 1
	new.temps = 0
	new.anim_change_ratio = 0
	new.anim_change_rate = 2
	frame_trigger = 0
	for i,h in ipairs(new.data.bone) do
		create_bone( new , h )
	end

--	jump_model(new,2,0,.1)
	return (new)
end
function is_model(data)
	return(data.bone ~= nil )
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
	local new = {	frame = 1	}
	return (new)
end
function create_bone(model,data)
	local newbone = {}
	if data.base.tipe == 0 then
		newbone.base = { pos = data.base.pos }
		newbone.base.pos.vec = {}
		newbone.base.pos.vec.D = math.atan2( newbone.base.pos.Y , newbone.base.pos.X )
		newbone.base.pos.vec.L = math.sqrt((newbone.base.pos.X)^2+(newbone.base.pos.Y)^2)
		newbone.base.vec = {}
		newbone.base.vec.D = 0
		newbone.base.vec.L = 1
		newbone.base.L = 1
		newbone.base.pos.scale = 1
	elseif data.base.tipe == 1 then
		newbone.base = model.bone[data.base.pos].tete
	end
	if data.tete.tipe == 0 then
		newbone.tete = {}
		newbone.tete.pos = {}
		newbone.tete.pos.X = data.tete.pos.X
		newbone.tete.pos.Y = data.tete.pos.Y

		newbone.old_pos = {}
		newbone.old_pos.X = data.tete.pos.X
		newbone.old_pos.Y = data.tete.pos.Y

		newbone.tete.vec = {}
		newbone.tete.vec.D = math.atan2( newbone.tete.pos.Y-newbone.base.pos.Y , newbone.tete.pos.X-newbone.base.pos.X )
		newbone.tete.vec.L = math.sqrt((newbone.tete.pos.X-newbone.base.pos.X)^2+(newbone.tete.pos.Y-newbone.base.pos.Y)^2)
		newbone.tete.pos.vec = {}
		newbone.tete.pos.vec.D = math.atan2( newbone.tete.pos.Y , newbone.tete.pos.X )
		newbone.tete.pos.vec.L = math.sqrt((newbone.tete.pos.X)^2+(newbone.tete.pos.Y)^2)

	elseif data.tete.tipe == 1 then
		newbone.tete = {}
		newbone.tete.vec = {	D = data.tete.vec.D ,
					L = data.tete.vec.L ,
					eritrot = 1
					}
		newbone.old_vec = {	D = data.tete.vec.D ,
					L = data.tete.vec.L ,
					eritrot = 1
					}

		newbone.tete.pos = {}
		newbone.tete.pos.X = newbone.base.pos.X+newbone.tete.vec.L*math.cos( newbone.tete.vec.D )
		newbone.tete.pos.Y = newbone.base.pos.Y+newbone.tete.vec.L*math.sin( newbone.tete.vec.D )
		newbone.tete.pos.vec = {}
		newbone.tete.pos.vec.D = math.atan2( newbone.tete.pos.Y , newbone.tete.pos.X )
		newbone.tete.pos.vec.L = math.sqrt((newbone.tete.pos.X)^2+(newbone.tete.pos.Y)^2)
	elseif data.tete.tipe == 2 then
		newbone.tete = {}
		newbone.tete.pos = model.bone[data.tete.pos].tete.pos
		newbone.tete.vec = {}
		newbone.tete.vec.D = math.atan2( newbone.tete.pos.Y-newbone.base.pos.Y , newbone.tete.pos.X-newbone.base.pos.X )
		newbone.tete.vec.L = math.sqrt((newbone.tete.pos.X-newbone.base.pos.X)^2+(newbone.tete.pos.Y-newbone.base.pos.Y)^2)
	end
	newbone.L = math.sqrt((newbone.base.pos.X-newbone.tete.pos.X)^2+(newbone.base.pos.Y-newbone.tete.pos.Y)^2)
	newbone.frame = 0
	newbone.data = data
	newbone.chef = model
	newbone.maitre = model.maitre or model.chef or model
	table.insert( model.bone , newbone )
	return (newbone)
end
function interpolation( in1 , in2 , ratio , Sdep , Sari )
	if ratio == 0 then
		return (in2)
	elseif ratio == 0 then
		return (in1)
	else
		Sdep = Sdep or 1
		Sari = Sari or Sdep
		if Sdep+Sari ~= 2 then
			ratio = 1-(1-ratio^Sari)^Sdep
		end
		return in1*ratio+in2*(1-ratio)
	end
end
function jump_model(model,anim,temps,rate)
	model.anim = anim
	if anim then

		model.anim_change_rate = rate or model.anim_change_rate
		model.anim_change_ratio = 1
		model.frame_trigger = -1
		for i,h in ipairs(model.bone) do
			if h.data.tete.tipe == 0 then
				h.old_pos.X = h.tete.pos.X
				h.old_pos.Y = h.tete.pos.Y
				if not model.data.anim[anim].bone[i][0] then

				end


			elseif h.data.tete.tipe == 1 then
				h.old_vec.D = h.tete.vec.D
				h.old_vec.L = h.tete.vec.L
			end
		end
		model.temps = temps or 0
		update_model(model,0)
	else
		for i,h in ipairs(model.bone) do
			if h.data.tete.tipe == 0 then
				h.tete.pos.X = h.data.tete.pos.X
				h.tete.pos.Y = h.data.tete.pos.Y
				h.tete.vec.D = math.atan2( h.tete.pos.Y-h.base.pos.Y , h.tete.pos.X-h.base.pos.X )
				h.tete.vec.L = math.sqrt((h.tete.pos.X-h.base.pos.X)^2+(h.tete.pos.Y-h.base.pos.Y)^2)
				h.tete.pos.vec.D = math.atan2( h.tete.pos.Y , h.tete.pos.X )
				h.tete.pos.vec.L = math.sqrt((h.tete.pos.X)^2+(h.tete.pos.Y)^2)
			elseif h.data.tete.tipe == 1 then
				h.tete.vec.D = h.data.tete.vec.D
				h.tete.vec.L = h.data.tete.vec.L
				h.tete.pos.X = h.base.pos.X+h.tete.vec.L*math.cos( h.tete.vec.D )
				h.tete.pos.Y = h.base.pos.Y+h.tete.vec.L*math.sin( h.tete.vec.D )
				h.tete.pos.vec.D = math.atan2( h.tete.pos.Y , h.tete.pos.X )
				h.tete.pos.vec.L = math.sqrt((h.tete.pos.X)^2+(h.tete.pos.Y)^2)
			elseif h.data.tete.tipe == 2 then
				h.tete.vec.D = math.atan2( h.tete.pos.Y-h.base.pos.Y , h.tete.pos.X-h.base.pos.X )
				h.tete.vec.L = math.sqrt((h.tete.pos.X-h.base.pos.X)^2+(h.tete.pos.Y-h.base.pos.Y)^2)
				h.tete.pos.vec.D = math.atan2( h.tete.pos.Y , h.tete.pos.X )
				h.tete.pos.vec.L = math.sqrt((h.tete.pos.X)^2+(h.tete.pos.Y)^2)
			end
		end
	end
end
function positionnement_dans_le_temps(model,i,h)
	local nexframe = -1
	local past = 0
	local futur = 0
	local ecart = 0
	local ratio = 0
	if model.anim and model.data.anim[model.anim].bone[i][0] then
		if model.temps <= model.data.anim[model.anim].bone[i][0].temps
		or model.temps > model.data.anim[model.anim].bone[i][table.maxn(model.data.anim[model.anim].bone[i])].temps then
			h.frame = table.maxn(model.data.anim[model.anim].bone[i])
			nexframe = 0
		else
			local w = h.frame
			while model.data.anim[model.anim].bone[i][h.frame].temps > model.temps do
				h.frame = h.frame-1
				if h.frame < 0 then h.frame = table.maxn(model.data.anim[model.anim].bone[i]) end
				if h.frame == w then rapporter_erreur( "boucle d'animation incomplète ver le bas pour l'os:"..i.." à l'animation: "..model.anim.." frame: "..h.frame.." temps: "..model.temps.."") break end
			end
			nexframe = h.frame+1
			if nexframe > table.maxn(model.data.anim[model.anim].bone[i]) then nexframe = 0 end
			while model.data.anim[model.anim].bone[i][nexframe].temps < model.temps do
				h.frame = nexframe
				nexframe = nexframe+1
				if nexframe > table.maxn(model.data.anim[model.anim].bone[i]) then nexframe = 0 end
				if nexframe == h.frame then rapporter_erreur( "boucle d'animation incomplète ver le haut pour l'os:"..i.." à l'animation "..model.anim.." frame: "..h.frame.." temps: "..model.temps.."") break end
			end
			h.frame = h.frame
		end
		past = model.data.anim[model.anim].bone[i][h.frame]
		futur = model.data.anim[model.anim].bone[i][nexframe]
		ecart = model.temps-model.data.anim[model.anim].bone[i][h.frame].temps
		if ecart < 0 then ecart = ecart+model.data.anim[model.anim].duration end
		ratio = math.max(0,math.min(1,1-ecart/past.duration))
	else
		past = h.data.tete
		futur = h.data.tete
		ratio = 0
	end
	return past , futur , ratio
end
function update_model(model,dot)
	if model and model.speed*world.speed ~= 0 then
		--txt = model.anim

		if model.anim then
			model.temps = model.temps+math.max(-.5,math.min(.1,dot*model.speed*world.speed))
			if model.temps > model.data.anim[model.anim].duration then
				model.temps = model.temps-model.data.anim[model.anim].duration
			elseif model.temps < 0 then
				model.temps = model.temps+model.data.anim[model.anim].duration
			end
			if model.anim_change_ratio ~= 0 then
				model.anim_change_ratio = math.max(0,model.anim_change_ratio-model.anim_change_rate*dot)
			end
		end

		for i,h in ipairs(model.bone) do
			if h.data.tete.tipe == 0 then
				--if i == 5 then txt = txt+1 end
				local past , futur , ratio = positionnement_dans_le_temps(model,i,h)
				h.tete.pos.X = interpolation( past.pos.X , futur.pos.X , ratio , past.Sdep , past.Sari )
				h.tete.pos.Y = interpolation( past.pos.Y , futur.pos.Y , ratio , past.Sdep , past.Sari )

				if model.anim_change_ratio ~= 0 then
					h.tete.pos.X = interpolation( h.old_pos.X , h.tete.pos.X , model.anim_change_ratio , 2 , 2 )
					h.tete.pos.Y = interpolation( h.old_pos.Y , h.tete.pos.Y , model.anim_change_ratio , 2 , 2 )
				end
				h.tete.vec.D = math.atan2( h.tete.pos.Y-h.base.pos.Y , h.tete.pos.X-h.base.pos.X )
				h.tete.vec.L = math.sqrt((h.tete.pos.X-h.base.pos.X)^2+(h.tete.pos.Y-h.base.pos.Y)^2)
				h.tete.pos.vec.D = math.atan2( h.tete.pos.Y , h.tete.pos.X )
				h.tete.pos.vec.L = math.sqrt((h.tete.pos.X)^2+(h.tete.pos.Y)^2)
			elseif h.data.tete.tipe == 1 then
				--txt = ""..model.temps.."\n"..h.frame..""
				local past , futur , ratio = positionnement_dans_le_temps(model,i,h)
				past.vec.eritrot = past.vec.eritrot or 1
				futur.vec.eritrot = futur.vec.eritrot or 1
				local eritrot = interpolation( past.vec.eritrot , futur.vec.eritrot , ratio , past.Sdep , past.Sari )
				h.tete.vec.D = interpolation( past.vec.D , past.vec.D+angle(past.vec.D,futur.vec.D) , ratio , past.Sdep , past.Sari )+h.base.vec.D*eritrot
				h.tete.vec.L = interpolation( past.vec.L , futur.vec.L , ratio , past.Sdep , past.Sari )

				if model.anim_change_ratio ~= 0 then
					h.tete.vec.D = interpolation( h.old_vec.D , h.old_vec.D+angle(h.old_vec.D , h.tete.vec.D ) , model.anim_change_ratio , 2 , 2 )
					h.tete.vec.L = interpolation( h.old_vec.L , h.tete.vec.L , model.anim_change_ratio , 2 , 2 )
				end
				h.tete.pos.X = h.base.pos.X+h.tete.vec.L*math.cos( h.tete.vec.D )
				h.tete.pos.Y = h.base.pos.Y+h.tete.vec.L*math.sin( h.tete.vec.D )
				h.tete.pos.vec.D = math.atan2( h.tete.pos.Y , h.tete.pos.X )
				h.tete.pos.vec.L = math.sqrt((h.tete.pos.X)^2+(h.tete.pos.Y)^2)
			elseif h.data.tete.tipe == 2 then
				h.tete.vec.D = math.atan2( h.tete.pos.Y-h.base.pos.Y , h.tete.pos.X-h.base.pos.X )
				h.tete.vec.L = math.sqrt((h.tete.pos.X-h.base.pos.X)^2+(h.tete.pos.Y-h.base.pos.Y)^2)
				h.tete.pos.vec.D = math.atan2( h.tete.pos.Y , h.tete.pos.X )
				h.tete.pos.vec.L = math.sqrt((h.tete.pos.X)^2+(h.tete.pos.Y)^2)
			end
		end
	end
end
function draw_model(model,X,Y,A,sX,sY)
	A =A or 0
	sX = sX or 1
	sY = sY or sX
	local r, g, b, al = love.graphics.getColor( )
	for i,h in ipairs(model.sprite) do
		love.graphics.setColor(r,g,b,255*h.alpha*al)
		local img = model.model_data.sprite_list[model.model_data.sprite[i].sprite][h.frame]
		local a = A+model.bone[model.model_data.sprite[i].chef].tete.pos.A
		local eA = A+model.bone[model.model_data.sprite[i].chef].tete.pos.A*model.model_data.sprite[i].eritrot+model.model_data.sprite[i].A
		local scale = model.bone[model.model_data.sprite[i].chef].tete.pos.scale
		if model.model_data.sprite[i].eritscale == 0 then
			local eX = X+sX*(model.bone[model.model_data.sprite[i].chef].base.pos.X+model.model_data.sprite[i].L*math.cos(model.model_data.sprite[i].D+a))
			local eY = Y+sY*(model.bone[model.model_data.sprite[i].chef].base.pos.Y+model.model_data.sprite[i].L*math.sin(model.model_data.sprite[i].D+a))

			love.graphics.draw( 	img ,
				eX ,
				eY ,
				eA ,
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
						eA ,
						sX*model.model_data.sprite[i].sx*(1-(1-scale)*math.abs(math.cos(model.model_data.sprite[i].A))) ,
						sY*model.model_data.sprite[i].sy*(1-(1-scale)*math.abs(math.sin(model.model_data.sprite[i].A))) ,
						img:getWidth()/2 ,
						img:getHeight()/2 )
		elseif model.model_data.sprite[i].eritscale == 2 then
			local eX = X+sX*(model.bone[model.model_data.sprite[i].chef].base.pos.X+model.model_data.sprite[i].L*math.cos(model.model_data.sprite[i].D+a)*scale)
			local eY = Y+sY*(model.bone[model.model_data.sprite[i].chef].base.pos.Y+model.model_data.sprite[i].L*math.sin(model.model_data.sprite[i].D+a)*scale)
			love.graphics.draw( 	img ,
						eX ,
						eY ,
						eA ,
						sX*model.model_data.sprite[i].sx*scale ,
						sY*model.model_data.sprite[i].sy*scale ,
						img:getWidth()/2 ,
						img:getHeight()/2 )
		end
	end
	love.graphics.setColor(r,g,b,al)
end
