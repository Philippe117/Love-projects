function start_sprite()
	sprite = {}
	sprite.select = 0
	sprite.decsel = 0
	sprite.choix = 0

	load_bouton("ressource/sous menu sprite")
end

function add_sprite(model_data,level,choix,chef,eritrot,eritscale,alpha)
	if alpha == nil then
		alpha = 255
	end
	local new = {}
	new.sprite = choix
	new.chef = chef
	new.eritrot = eritrot
	new.eritscale = eritscale
	new.X = model.model_data.bone[chef].tete.L/2
	new.Y = 0
	new.L = model.model_data.bone[chef].tete.L/2
	new.D = 0
	new.A = 0
	new.sx = model.model_data.bone[chef].tete.L/model.model_data.sprite_list[choix][1]:getWidth()
	new.sy = model.model_data.bone[chef].tete.L/model.model_data.sprite_list[choix][1]:getWidth()
	new.alpha = alpha
	local e = 1
	local cache = new
	for i,h in ipairs(model.model_data.sprite) do
		if i > level then
			cache , model.model_data.sprite[i] = model.model_data.sprite[i] , cache
		end
		e = i+1
	end
	if e >= level then
		model.model_data.sprite[e] = cache
	end
	for i,h in ipairs(model.model_data.sprite) do
		h.id = i
	end

	model.sprite = {}

	for i,h in ipairs(model.model_data.sprite) do
		table.insert(model.sprite,create_sprite(model,h))
	end

	model_jump(model,model.anim,model.temp+20)
	model_jump(model,model.anim,model.temp-20)
	return (new)

end

function sprite_remove(model_data,spr)
	sprite_eradicate_anim(model_data,spr)
	table.remove(model_data.sprite,spr)
	table.remove(model.sprite,spr)
	for i,h in ipairs(model.model_data.sprite) do
		h.id = i
	end
end
function sprite_remove_anim(model_data,anim,frame,anim_spr)
	local tempe = model.temp
	model_jump(model,model.anim,model.orloge-1)
	for i,h in ipairs(model_data.anim[anim][frame].sprite) do
		h.id = i
	end
	local w = frame+1
	if w > table.maxn(model_data.anim[anim]) then
		w = 1
	end
	local nextep = 0
	while nextep == 0 do
		if w == frame then
			nextep = anim_spr
		else
			for i,h in ipairs(model_data.anim[anim][w].sprite) do
				if h.spr == anim_spr.spr then
					nextep = h
				end
			end
			w = w+1
			if w > table.maxn(model_data.anim[anim]) then
				w = 1
			end
		end
	end
	--txt = 123
	if nextep ~= anim_spr then
		txt = txt+1
		anim_spr.prestep.alpha = anim_spr.alpha
		anim_spr.prestep.frame = anim_spr.frame
		nextep.prestep = anim_spr.prestep
		table.remove(model_data.anim[anim][frame].sprite,anim_spr.id)
		for e,g in ipairs(model_data.anim[anim]) do
			for i,h in ipairs(g.sprite) do
				h.step = e
			end
		end
		for e,g in ipairs(model_data.anim[model.anim]) do
			for i,h in ipairs(g.sprite) do
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
	end
end
function sprite_eradicate_anim(model_data,spr)
	for i,h in ipairs(model_data.anim) do
		for e,g in ipairs(h) do
			for u,k in ipairs(g.sprite) do
				if k.spr == spr then
					table.remove(g.sprite,u)
				end
			end
			for u,k in ipairs(g.sprite) do
				if k.spr >= spr then
					k.spr = k.spr-1
				end
			end
		end
	end
end
function sprite_add_anim(model,anim,frame,spr)

	new = {}
	new.spr = spr
	local ref = {}
	ref.alpha = model.sprite[spr].alpha
	ref.frame = model.sprite[spr].frame
	new.temp = 0
	local temper = model.temp
	local orloge = model.orloge
--	model_jump(model,model.anim,model.orloge-20)
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
			for i,h in ipairs(model.model_data.anim[anim][w].sprite) do
				if h.spr == spr then
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
	new.eta = {}
	new.eta.alpha = new.prestep.eta.alpha
	new.eta.frame = new.prestep.eta.frame
	new.prestep.eta.alpha = ref.alpha
	new.prestep.eta.frame = ref.frame
	table.insert(model.model_data.anim[anim][frame].sprite , new )
	for e,g in ipairs(model_data.anim[model.anim]) do
		for i,h in ipairs(g.sprite) do
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
	for i,h in ipairs(model.model_data.sprite) do
		h.id = i
	end
	--model.sprite[spr].anieta.futur = new

	model_jump(model,model.anim,temper)
	model.orloge = orloge
	return (new)






end
function sprite_timeline_add_anim(model)

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
		controle = sprite_add_anim(model,model.anim,timeline.select,sprite.select)
	else
		model_jump(model,model.anim,model.orloge+model.model_data.anim[model.anim][timeline.select].tempo)
		tempe = model.temp
		for i,h in ipairs(model.model_data.anim[model.anim][timeline.select].sprite) do
			if h.spr == sprite.select then
				controle = h
			end
		end
		if controle == 0 then
			controle = sprite_add_anim(model,model.anim,timeline.select,sprite.select)
		end
	end
	model_jump(model,model.anim,tempe)
	model.orloge = orloge
	return(controle)
end


function MP_sprite(mx,my,bu)
	if bu == "l" then
		if bone.canselect ~= 0 then
			bone.select = bone.canselect
			bone.ref = { X = moux , Y = mouy }
			bone.timer = crono+.4
			bone.eta = 1
		end
	end
end

function MR_sprite(mx,my,bu)



end

function update_sprite(dot)
	sprite.decsel = sprite.decsel+(sprite.select-sprite.decsel)/2


end
