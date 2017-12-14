NC = "NC"
speed = 1000
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
		for e,g in ipairs(h.bone) do
			g.maxn = table.maxn(g)
		end
	end

	return (new)
end
function create_model(model_data)
	local new = {}
	new.data = model_data
	new.bone = {}
	new.speed = 1
	frame_trigger = 0
	for i,h in ipairs(new.data.bone) do
		create_bone( new , h )
	end

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
	local new = {}
	if data.base.tipe == 0 then
		new.base = { pos = data.base.pos }
		new.base.pos.vec = {}
		new.base.pos.vec.D = math.atan2( new.base.pos.Y , new.base.pos.X )
		new.base.pos.vec.L = math.sqrt((new.base.pos.X)^2+(new.base.pos.Y)^2)
		new.base.vec = {D=0,L=1}
		new.base.pos.scale = 1
	elseif data.base.tipe == 1 then
		new.base = model.bone[data.base.pos].tete
	end
	if data.tete.tipe ~= 2 then
		if data.tete.tipe == 0 then
			new.tete = {}
			new.tete.pos = {}
			new.tete.pos.X = data.tete.pos.X
			new.tete.pos.Y = data.tete.pos.Y

			new.old_pos = {}
			new.old_pos.X = new.tete.pos.X
			new.old_pos.Y = new.tete.pos.Y
			new.tete.vec = {}
			new.tete.vec.D = math.atan2( new.tete.pos.Y-new.base.pos.Y , new.tete.pos.X-new.base.pos.X )
			new.tete.vec.L = math.sqrt((new.tete.pos.X-new.base.pos.X)^2+(new.tete.pos.Y-new.base.pos.Y)^2)

		elseif data.tete.tipe == 1 then
			new.tete = {}
			new.tete.vec = {	D = data.tete.vec.D ,
						L = data.tete.vec.L ,
						eritrot = 1,
						eritscale = 0
						}
			new.old_vec = {}
			new.old_vec.D = new.tete.vec.D
			new.old_vec.L = new.tete.vec.L

			new.anim_change_ratio = 0
			new.anim_change_rate = 2
			new.tete.pos = {}
			new.tete.pos.X = new.base.pos.X+new.tete.vec.L*math.cos( new.tete.vec.D+new.base.vec.D )
			new.tete.pos.Y = new.base.pos.Y+new.tete.vec.L*math.sin( new.tete.vec.D+new.base.vec.D )
		end
		new.temps = 0
		new.tete.pos.vec = {}
		new.tete.pos.vec.D = math.atan2( new.tete.pos.Y , new.tete.pos.X )
		new.tete.pos.vec.L = math.sqrt((new.tete.pos.X)^2+(new.tete.pos.Y)^2)
		new.tete.pos.scale = 1
	else
		new.tete = {}
		new.tete.pos = model.bone[data.tete.pos].tete.pos
		new.tete.vec = {}
		new.tete.vec.D = math.atan2( new.tete.pos.Y-new.base.pos.Y , new.tete.pos.X-new.base.pos.X )
		new.tete.vec.L = math.sqrt((new.tete.pos.X-new.base.pos.X)^2+(new.tete.pos.Y-new.base.pos.Y)^2)
	end

	new.L = math.sqrt((new.base.pos.X-new.tete.pos.X)^2+(new.base.pos.Y-new.tete.pos.Y)^2)
	new.anim_index = 0
	new.anim_ecart = 0
	new.tete.L = 1


	new.data = data
	new.chef = new
	new.maitre = model
	table.insert( model.bone , new )
	return (new)
end
function interpolation( in1 , in2 , ratio , Sdep , Sari )
	in1 = in1 or 0
	in2 = in2 or 0
	if in1 ~= in2 then
		if ratio == 1 then
			return in2
		elseif ratio == 0 then
			return in1
		else
			Sdep = Sdep or 1
			Sari = Sari or Sdep
			if Sdep ~=1 or Sari ~= 1 then
				ratio = 1-(1-ratio^Sari)^Sdep
			end
			return in1*(1-ratio)+in2*ratio
		end
	else
		return in1
	end
end
function positionnement_dans_le_temps(H)
	if H.anim then
		H.anim_index = H.anim_index or 1
		H.temps = H.temps or 0
		H.anim.maxn = H.anim.maxn or 1
		if H.anim.maxn > 1 then
			local w = H.anim_index
			while H.anim_index < H.anim.maxn and H.temps > H.anim[H.anim_index].temps do
				H.anim_index = H.anim_index+1
			end
			while H.anim_index > 0 and H.temps <= H.anim[H.anim_index-1].temps do
				H.anim_index = H.anim_index-1
			end
			local past = 0
			local ratio = 0
			if H.anim_index > 0 then
				past = H.anim[H.anim_index-1]
				H.anim_ecart = 1/(H.anim[H.anim_index].temps-past.temps)
			else
				past = H.anim[H.anim.maxn]
				H.anim_ecart = 1/H.anim[H.anim_index].temps
			end
			return 1-((H.anim[H.anim_index].temps-H.temps)*H.anim_ecart) , past , H.anim[H.anim_index]  --ratio
		else
			H.anim_index = 1
			return 1 , H.anim[1] , H.anim[1] --ratio   wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
		end
	else
		local index = H.nom or "objet inconu"
		rapporter_erreur( "impossible d'animer: "..index..", animation inexistante")
	end
end
function update_model(model,dot)
	if model and world.speed ~= 0 and model.speed ~= 0 then
		--txt = model.anim
		for i,h in ipairs(model.bone) do
			update_bone(h,dot)
		end
		--for i,h in ipairs(model.sprite) do
		--	update_sprite(h,dot)
		--end
	end
end


function update_bone(bn,dot)
	dot = dot or 0
	if bn.data.tete.tipe == 2 then
		bn.tete.vec.D = math.atan2( bn.tete.pos.Y-bn.base.pos.Y , bn.tete.pos.X-bn.base.pos.X )
		bn.tete.vec.L = math.sqrt((bn.tete.pos.X-bn.base.pos.X)^2+(bn.tete.pos.Y-bn.base.pos.Y)^2)
	else

		local ratio , past , futur = 0,0,0
		if bn.anim and table.maxn(bn.anim)>0 then
			bn.temps = bn.temps+bn.speed*bn.maitre.speed*world.speed*dot
			while bn.temps > bn.anim[bn.anim.maxn].temps do
				bn.temps = bn.temps-bn.anim[bn.anim.maxn].temps
			end
			while bn.temps < 0 do
				bn.temps = bn.temps+bn.anim[bn.anim.maxn].temps
			end
			ratio , past , futur = positionnement_dans_le_temps(bn)
			bn.test = ""..past.temps.."-"..futur.temps..""

			if bn.data.tete.tipe == 0 then
				bn.tete.pos.X = interpolation( past.pos.X , futur.pos.X , ratio , futur.Sdep , futur.Sari )
				bn.tete.pos.Y = interpolation( past.pos.Y , futur.pos.Y , ratio , futur.Sdep , futur.Sari )
				bn.tete.vec.D = math.atan2( bn.tete.pos.Y-bn.base.pos.Y , bn.tete.pos.X-bn.base.pos.X )
				bn.tete.vec.L = math.sqrt((bn.tete.pos.X-bn.base.pos.X)^2+(bn.tete.pos.Y-bn.base.pos.Y)^2)
			elseif bn.data.tete.tipe == 1 then
				past.vec.eritrot = past.vec.eritrot or 1
				futur.vec.eritrot = futur.vec.eritrot or 1
				bn.tete.vec.eritrot = interpolation( past.vec.eritrot , futur.vec.eritrot , ratio , futur.Sdep , futur.Sari )
				bn.tete.vec.eritscale = interpolation( past.vec.eritscale , futur.vec.eritscale , ratio , futur.Sdep , futur.Sari )
				bn.tete.vec.D = interpolation( past.vec.D , past.vec.D+angle(past.vec.D,futur.vec.D) , ratio , futur.Sdep , futur.Sari )+bn.base.vec.D*bn.tete.vec.eritrot
				bn.tete.vec.L = interpolation( past.vec.L , futur.vec.L , ratio , futur.Sdep , futur.Sari )
			end
		end
	-- change ratio ------------------
		if bn.anim_change_ratio ~= 0 then

			bn.anim_change_ratio = math.max(0,bn.anim_change_ratio-bn.anim_change_rate*dot)

			if bn.data.tete.tipe == 0 then
			--txt2 = bn.anim_change_ratio
--txt2 = bn.tete.pos.X
				bn.tete.pos.X = interpolation( bn.tete.pos.X , bn.old_pos.X , bn.anim_change_ratio , 2 , 2 )
--txt3 = bn.tete.pos.X

				bn.tete.pos.Y = interpolation( bn.tete.pos.Y , bn.old_pos.Y , bn.anim_change_ratio , 2 , 2 )
			elseif bn.data.tete.tipe == 1 then
				bn.tete.vec.D = bn.tete.vec.D+interpolation( 0 , angle(bn.tete.vec.D , bn.old_vec.D ) , bn.anim_change_ratio , 2 , 2 )
				bn.tete.vec.L = interpolation( bn.tete.vec.L , bn.old_vec.L , bn.anim_change_ratio , 2 , 2 )
				bn.tete.vec.eritscale = interpolation( bn.tete.vec.eritscale , bn.old_vec.eritscale , bn.anim_change_ratio , 2 , 2 )
				bn.tete.vec.eritrot = interpolation( bn.tete.vec.eritrot , bn.old_vec.eritrot , bn.anim_change_ratio , 2 , 2 )
			end
		end
	----------------------------------
		if bn.data.tete.tipe == 0 then
			bn.tete.vec.D = math.atan2( bn.tete.pos.Y-bn.base.pos.Y , bn.tete.pos.X-bn.base.pos.X )
			bn.tete.vec.L = math.sqrt((bn.tete.pos.X-bn.base.pos.X)^2+(bn.tete.pos.Y-bn.base.pos.Y)^2)
		elseif bn.data.tete.tipe == 1 then
			local ang = bn.tete.vec.D+angle(bn.tete.vec.D,bn.tete.vec.D+bn.base.vec.D)*bn.tete.vec.eritrot
			bn.tete.pos.X = bn.base.pos.X+bn.tete.vec.L*math.cos( ang )*((1-bn.tete.vec.eritscale)+bn.base.pos.scale*bn.tete.vec.eritscale)
			bn.tete.pos.Y = bn.base.pos.Y+bn.tete.vec.L*math.sin( ang )*((1-bn.tete.vec.eritscale)+bn.base.pos.scale*bn.tete.vec.eritscale)
		end
		bn.tete.pos.vec.D = math.atan2( bn.tete.pos.Y , bn.tete.pos.X )
		bn.tete.pos.vec.L = math.sqrt((bn.tete.pos.X)^2+(bn.tete.pos.Y)^2)
	end
	bn.scale = bn.L/bn.data.L
end
function update_sprite(spr,dot)
	local past , futur , ratio = positionnement_dans_le_temps(model,i,spr)
	spr.color.R = interpolation( past.color.R , futur.color.R , ratio , futur.Sdep , futur.Sari )
	spr.color.V = interpolation( past.color.V , futur.color.V , ratio , futur.Sdep , futur.Sari )
	spr.color.B = interpolation( past.color.B , futur.color.B , ratio , futur.Sdep , futur.Sari )
	spr.color.A = interpolation( past.color.A , futur.color.A , ratio , futur.Sdep , futur.Sari )
end
function model_set_anim(model,anim,temps,newspeed,transition) --transition en (seconde)
	rapporter_erreur( "set animation à "..temps.."s")
	if anim then
		if anim == NC then
			anim = nil
		elseif anim-anim == 0 then
			anim = model.data.anim[anim]
		end
		if anim then
			for i,h in ipairs(model.bone) do
				h.anim = anim.bone[i]
			end
		end
		if temps and temps ~= NC then
			for i,h in ipairs(model.bone) do
				h.temps = temps
			end
		end
		if newspeed and newspeed ~= NC then
			if newspeed > 60 then
				for i,h in ipairs(model.bone) do
					h.speed = h.speed+newspeed-speed
				end
			else
				for i,h in ipairs(model.bone) do
					h.speed = newspeed
				end
			end
		end

	else
		for i,h in ipairs(model.bone) do

			h.anim = nil
			h.temps = 0
			h.speed = 0

			
		end
	end

	local rate = 0
	local ratio = 0
	if transition and transition > 0 then
		rate = 1/transition
		ratio = 1
	else
		transition = 0
		rate = 0
		ratio = 0
	end
	for i,h in ipairs(model.bone) do
		if h.data.tete.tipe == 0 then
			h.old_pos.X = h.tete.pos.X
			h.old_pos.Y = h.tete.pos.Y
		elseif h.data.tete.tipe == 1 then
			h.old_vec.D = h.tete.vec.D
			h.old_vec.L = h.tete.vec.L
			h.old_vec.eritrot = h.tete.vec.eritrot
			h.old_vec.scale = h.tete.vec.scale
		end

		h.anim_change_ratio = ratio
		h.anim_change_rate = rate
	end


	for i,h in ipairs(model.bone) do
		update_bone(h)
	end
end

function draw_model(model,X,Y,A,sens,scale)
	A = A or 0
	sens = sens or 1
	scale = scale or 1
	local r, g, b, al = love.graphics.getColor( )
	for i,h in ipairs(model.sprite) do
		love.graphics.setColor(r,g,b,h.alpha*al)
		local a = A+h.chef.tete.pos.A+h.data.A
		local scale2 = h.chef.tete.scale*scale
		local eX = 0
		local eY = 0
		local D = h.chef.base.pos.vec.D
		if sens < 0 then
			local D = 2*A+math.pi()-h.chef.base.pos.vec.D
		end
		eX = h.chef.base.pos.vec.L*math.cos(D)
		eY = h.chef.base.pos.vec.L*math.sin(D)
		local eA = h.data.offset.D+a
		if h.data.offset.L ~= 0 then
			if sens < 0 then
				local eA = 2*A+math.pi()-eA
			end
			eX = eX+h.data.offset.L*math.cos(eA)
			eY = eY+h.data.offset.L*math.sin(eA)
		end
		local cos = math.abs(math.cos(h.data.A))
		local sin = math.abs(math.sin(h.data.A))
		if scaletype == "linear" then
			local eX = X+eX*scale2*sens
			local eY = Y+eY*scale
			love.graphics.draw( 	h.sprite[h.index] ,
						eX ,
						eY ,
						eA ,
						h.data.sX*scale*(1-(1-sens*h.chef.tete.scale)*cos) ,
						h.data.sY*scale*(1-(1-sens*h.chef.tete.scale)*sin) ,
						h.data.center )
		elseif scaletype == "proportionnel" then
			eX = X+eX*scale2*sens
			eY = Y+eY*scale2
			love.graphics.draw( 	h.sprite[h.index] ,
						eX ,
						eY ,
						eA ,
						h.data.sX*scale2*(1-(1-sens)*cos) ,
						h.data.sY*scale2*(1-(1-sens)*sin) ,
						h.data.center )
		else
			eX = X+eX*scale*sens
			eY = Y+eY*scale
			love.graphics.draw( 	h.sprite[h.index] ,
						eX ,
						eY ,
						eA ,
						h.data.sX*scale*(1-(1-sens)*cos) ,
						h.data.sY*scale*(1-(1-sens)*sin) ,
						h.data.center )

		end
	end

	love.graphics.setColor(r,g,b,al)
end
