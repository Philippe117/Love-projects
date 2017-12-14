function B.init(B)				
	B.X = 400
	B.Y = 600
	B.text = "alpha"
	anim_os_sel = 0
	B.popup = {}
	B.popup.X = B.X+50
	B.popup.Y = B.Y-50
	B.popup.text = "ajuste la transparence"
	Bout_alpha = B
end
function B.clic_gauche(B)

	local cache = {	temp = model.temp ,
			alpha = model.sprite[sprite_sel].alpha ,
			frame = model.sprite[sprite_sel].frame	}

	local truck = nil
	local a = 1
	while a <= table.maxn(model.model_data.sprite[sprite_sel].anim[model.anim]) do
		if model.temp == model.model_data.sprite[sprite_sel].anim[model.anim][a].temp then							model.model_data.sprite[sprite_sel].anim[model.anim][a] = cache

			truck = a
			a = 1000
		else

			if model.model_data.sprite[sprite_sel].anim[model.anim][a].temp > model.temp then
				cache , model.model_data.sprite[sprite_sel].anim[model.anim][a] = model.model_data.bone[select].tete.anim[model.anim][a] , cache

				if truck == nil then
					truck = a
				end
			end
		end
		a = a+1
	end
	if a ~= 1001 then
		model.model_data.sprite[sprite_sel].anim[model.anim][a] = cache
		if truck == nil then
			truck = a
		end
	end

	model.model_data.sprite[sprite_sel].anim[model.anim][truck].alpha = math.min(math.max(model.model_data.sprite[sprite_sel].anim[model.anim][truck].alpha+5,0),255)

	model_blink_anim(model,model.anim,model.temp)
end



function B.clic_droit(B)
	

	local cache = {	temp = model.temp ,
			alpha = model.sprite[sprite_sel].alpha ,
			frame = model.sprite[sprite_sel].frame	}

	local truck = nil
	local a = 1
	while a <= table.maxn(model.model_data.sprite[sprite_sel].anim[model.anim]) do
		if model.temp == model.model_data.sprite[sprite_sel].anim[model.anim][a].temp then							model.model_data.sprite[sprite_sel].anim[model.anim][a] = cache

			truck = a
			a = 1000
		else

			if model.model_data.sprite[sprite_sel].anim[model.anim][a].temp > model.temp then
				cache , model.model_data.sprite[sprite_sel].anim[model.anim][a] = model.model_data.sprite[sprite_sel].anim[model.anim][a] , cache

				if truck == nil then
					truck = a
				end
			end
		end
		a = a+1
	end
	if a ~= 1001 then
		model.model_data.sprite[sprite_sel].anim[model.anim][a] = cache
		if truck == nil then
			truck = a
		end
	end

	model.model_data.sprite[sprite_sel].anim[model.anim][truck].alpha = math.min(math.max(model.model_data.sprite[sprite_sel].anim[model.anim][truck].alpha-5,0),255)
	model_blink_anim(model,model.anim,model.temp)
end
function B.autre(B,bu)
	if bu == "wu" then
		B.clic_gauche(B)
	elseif bu == "wd" then
		B.clic_droit(B)
	end
end


function B.update_popup(B)
	B.popup.text = "ajuste la transparence : "..math.floor(model.sprite[sprite_sel].alpha)..""
end
function B.condition()
	if tool == "anim_sprite"
	and sprite_sel ~= table.maxn(model.sprite)+1 then
		Bout_alpha.text = "alpha:"..math.floor(model.sprite[sprite_sel].alpha)..""
		return( true )
	end
end
