function add_bone(model,base,tete,eritrot)
	new = {}
	new.base = base
	new.tete = {}
	new.tete.tipe = tete.tipe
	local pos_X = 0
	local pos_Y = 0
	if base.tipe == 0 then
		pos_X = base.pos.X
		pos_Y = base.pos.Y
	elseif base.tipe == 1 then
		pos_X = model.bone[base.pos].tete.pos.X
		pos_Y = model.bone[base.pos].tete.pos.Y
	end
	new.tete.L = 1
	table.insert(model.model_data.bone , new )
	local newbone = create_bone(model,new)
	table.insert( model.bone , newbone )
	bone.select = table.maxn(model.bone)
	model_jump(model,model.anim,model.temp)
	for i,h in ipairs(model.model_data.bone) do
		h.id = i
	end
	return (new)
end
function bone_add_anim(model,anim,frame,os)
	new = {}
	new.os = os
	local ref = {}
	if model.model_data.bone[os].tete.tipe == 0 then
		ref.X = model.bone[os].tete.pos.X
		ref.Y = model.bone[os].tete.pos.Y
		ref.input = model.bone[os].tete.input
	elseif model.model_data.bone[os].tete.tipe == 1 then
		ref.D = model.bone[os].tete.vec.D
		ref.L = model.bone[os].tete.vec.L
		ref.eritrot = model.bone[os].tete.vec.eritrot
		ref.input = model.bone[os].tete.input
	end
	new.temp = 0
	local tempe = model.temp
	local orloge = model.orloge
	model_jump(model,model.anim,model.orloge-20)
	local w = frame+1
	if w > table.maxn(model.model_data.anim[anim]) then
		w = 1
	end
	local nextep = 0
	while nextep == 0 do
		if w == frame then
			nextep = new
			new.prestep = new
		else
			for i,h in ipairs(model.model_data.anim[anim][w].bone) do
				if h.os == os then
					nextep = h
				end
			end
			w = w+1
			if w > table.maxn(model.model_data.anim[anim]) then
				w = 1
			end
		end
	end
	new.prestep = nextep.prestep
	nextep.prestep = new
	new.pos = {}
	if model.model_data.bone[os].tete.tipe == 0 then
		new.pos.X = new.prestep.pos.X
		new.pos.Y = new.prestep.pos.Y
		new.input = new.prestep.input
		new.prestep.pos.X = ref.X
		new.prestep.pos.Y = ref.Y
		new.prestep.input = ref.input
	elseif model.model_data.bone[os].tete.tipe == 1 then
		new.pos.D = new.prestep.pos.D
		new.pos.L = new.prestep.pos.L
		new.eritrot = new.prestep.eritrot
		new.input = new.prestep.input
		new.prestep.pos.D = ref.D
		new.prestep.pos.L = ref.L
		new.prestep.eritrot = ref.eritrot
		new.prestep.input = ref.input
	end
	table.insert(model.model_data.anim[anim][frame].bone , new )
	for e,g in ipairs(model_data.anim[model.anim]) do
		for i,h in ipairs(g.bone) do
			h.step = e
		end
	end
	for e,g in ipairs(model_data.anim[model.anim]) do
		for i,h in ipairs(g.bone) do
			if h.step >= h.prestep.step then
				h.prestep.temp = math.abs(g.tempo-model_data.anim[model.anim][h.prestep.step].tempo)
			else
				h.prestep.temp = math.abs(g.tempo-model_data.anim[model.anim][h.prestep.step].tempo+(model_data.anim[model.anim][table.maxn(model_data.anim[model.anim])].tempo+model_data.anim[model.anim][table.maxn(model_data.anim[model.anim])].temp))
			end
		end
		for i,h in ipairs(g.sprite) do
			if h.step >= h.prestep.step then
				h.prestep.temp = math.abs(g.tempo-model_data.anim[model.anim][h.prestep.step].tempo)
			else
				h.prestep.temp = math.abs(g.tempo-model_data.anim[model.anim][h.prestep.step].tempo+(model_data.anim[model.anim][table.maxn(model_data.anim[model.anim])].tempo+model_data.anim[model.anim][table.maxn(model_data.anim[model.anim])].temp))
			end
		end
	end
	for i,h in ipairs(model.model_data.bone) do
		h.id = i
	end

	model_jump(model,model.anim,tempe)
	model.orloge = orloge

	return (new)
end
function bone_remove(model_data,os)
	for i,h in ipairs(model_data.bone) do
		if h.base.tipe == 1 then
			if h.base.pos == os then
				h.base.tipe = 0
				h.base.pos = {X = model.bone[os].tete.pos.X ,Y = model.bone[os].tete.pos.Y,A = model.bone[os].tete.pos.A,scale = 1}
				model.bone[i].base.pos = h.base.pos
			end
		end
		if h.tete.tipe == 2 then
			if h.tete.pos == os then
				h.tete.tipe = 0
				model.bone[i].tete.pos = { X = model.bone[i].tete.pos.X , Y = model.bone[i].tete.pos.Y , A = 0 }
				model.bone[i].tete.input = 0
				model.bone[i].tete.pos.scale = 1
				model.bone[i].tete.anipos = {}
				model.bone[i].tete.anipos.passer =  { pos = { X = model.bone[i].tete.pos.X , Y = model.bone[i].tete.pos.Y }}
				model.bone[i].tete.anipos.futur =   { pos = { X = model.bone[i].tete.pos.X , Y = model.bone[i].tete.pos.Y } , prestep = model.bone[i].tete.anipos.passer }
				model.bone[i].tete.anipos.passer.prestep = model.bone[i].tete.anipos.futur
				model.bone[i].tete.timer = { passer = 0 , futur = .1}
			end
		end
	end
	local tempe = model.temp--model.orloge
	model_jump(model,model.anim,model.orloge-1)
	for i,h in ipairs(model_data.bone) do
		if h.base.tipe == 1
		and h.base.pos > os then
			h.base.pos = h.base.pos-1
		end
		if h.tete.tipe == 2
		and h.tete.pos > os then
			h.tete.pos = h.tete.pos-1
		end
	end
	for i,h in ipairs(model_data.sprite) do
		if h.chef == os then
			sprite_remove(model_data,i)
		end
	end
	for i,h in ipairs(model_data.sprite) do
		if h.chef > os then
			h.chef = h.chef-1
		end
	end
	bone_eradicate_anim(model_data,os)
	table.remove(model_data.bone,os)
	table.remove(model.bone,os)
	for i,h in ipairs(model.model_data.bone) do
		h.id = i
	end
	model_jump(model,model.anim,tempe)
end
function bone_eradicate_anim(model_data,os)
	for i,h in ipairs(model_data.anim) do
		for e,g in ipairs(h) do
			for u,k in ipairs(g.bone) do
				if k.os == os then
					table.remove(g.bone,u)
				end
			end
			for u,k in ipairs(g.bone) do
				if k.os > os then
					k.os = k.os-1
				end
			end
		end
	end
end
function bone_remove_anim(model_data,anim,frame,anim_os)
	local tempe = model.temp--model.orloge
	local orloge = model.orloge
	--model_jump(model,model.anim,model.orloge)
	for i,h in ipairs(model_data.anim[anim][frame].bone) do
		h.id = i
	end
	local w = frame+1
	if w > table.maxn(model_data.anim[anim]) then
		w = 1
	end
	local nextep = 0
	while nextep == 0 do
		if w == frame then
			nextep = anim_os
		else
			for i,h in ipairs(model_data.anim[anim][w].bone) do
				if h.os == anim_os.os then
					nextep = h
				end
			end
			w = w+1
			if w > table.maxn(model_data.anim[anim]) then
				w = 1
			end
		end
	end
	if nextep ~= anim_os then
		txt = txt+1
		if model_data.bone[anim_os.os].tete.tipe == 0 then
			anim_os.prestep.pos.X = anim_os.pos.X
			anim_os.prestep.pos.Y = anim_os.pos.Y
		else
			anim_os.prestep.pos.D = anim_os.pos.D
			anim_os.prestep.pos.L = anim_os.pos.L
			anim_os.prestep.eritrot = anim_os.eritrot
		end
		nextep.prestep = anim_os.prestep
		table.remove(model_data.anim[anim][frame].bone,anim_os.id)
		for e,g in ipairs(model_data.anim[anim]) do
			for i,h in ipairs(g.bone) do
				h.step = e
			end
		end
		for e,g in ipairs(model_data.anim[model.anim]) do
			for i,h in ipairs(g.bone) do
				if h.step >= h.prestep.step then
					h.prestep.temp = math.abs(g.tempo-model_data.anim[model.anim][h.prestep.step].tempo)
				else
					h.prestep.temp = math.abs(g.tempo-model_data.anim[model.anim][h.prestep.step].tempo+(model_data.anim[model.anim][table.maxn(model_data.anim[model.anim])].tempo+model_data.anim[model.anim][table.maxn(model_data.anim[model.anim])].temp))
				end
			end
			for i,h in ipairs(g.sprite) do
				if h.step >= h.prestep.step then
					h.prestep.temp = math.abs(g.tempo-model_data.anim[model.anim][h.prestep.step].tempo)
				else
					h.prestep.temp = math.abs(g.tempo-model_data.anim[model.anim][h.prestep.step].tempo+(model_data.anim[model.anim][table.maxn(model_data.anim[model.anim])].tempo+model_data.anim[model.anim][table.maxn(model_data.anim[model.anim])].temp))
				end
			end
		end
		model_jump(model,model.anim,tempe)
		model.orloge = orloge

	end
end
function bone_timeline_add_anim(model)
	local tempe = model.temp
	local orloge = model.orloge
	timeline.select = 0
	local near = .2
	for i,h in ipairs(model.model_data.anim[model.anim]) do
		local dist = math.abs(h.tempo-model.temp+model.orloge)
		if dist < near then
			near = dist
			timeline.select = i
		end
		if i == 1 then
			dist = math.abs(-(model.temp-model.orloge)+(model.model_data.anim[model.anim][table.maxn(model.model_data.anim[model.anim])].tempo+model.model_data.anim[model.anim][table.maxn(model.model_data.anim[model.anim])].temp))
			if dist < near then
				near = dist
				timeline.select = 1
			end
		end
	end
	local controle = 0
	if timeline.select == 0 then
		timeline.select = add_point(model.model_data,model.anim,model.temp-model.orloge)
		controle = bone_add_anim(model,model.anim,timeline.select,bone.select)
	else
		model_jump(model,model.anim,model.orloge+model.model_data.anim[model.anim][timeline.select].tempo)
		tempe = model.temp
		for i,h in ipairs(model.model_data.anim[model.anim][timeline.select].bone) do
			if h.os == bone.select then
				controle = h
			end
		end
		if controle == 0 then
			controle = bone_add_anim(model,model.anim,timeline.select,bone.select)
		end
	end
	model_jump(model,model.anim,tempe)
	model.orloge = orloge
	return(controle)
end
