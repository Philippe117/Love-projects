function B.init(B)				
	B.X = 500
	B.Y = 600
	B.text = "frame"
	anim_os_sel = 0
	B.popup = {}
	B.popup.X = B.X+50
	B.popup.Y = B.Y-50
	B.popup.text = "change le frame du sprite"
	Bout_fra = B
end
function B.clic_gauche(B)
	if model.sprite[sprite_sel].frame < table.maxn(model.model_data.sprite_list[model.model_data.sprite[sprite_sel].sprite]) then
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

		model.model_data.sprite[sprite_sel].anim[model.anim][truck].frame = model.model_data.sprite[sprite_sel].anim[model.anim][truck].frame+1

		model_blink_anim(model,model.anim,model.temp)
	end
end



function B.clic_droit(B)
	if model.sprite[sprite_sel].frame > 1 then
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

		model.model_data.sprite[sprite_sel].anim[model.anim][truck].frame = model.model_data.sprite[sprite_sel].anim[model.anim][truck].frame-1

		model_blink_anim(model,model.anim,model.temp)
	end
end
function B.autre(B,bu)
	if bu == "wu" then
		B.clic_gauche(B)
	elseif bu == "wd" then
		B.clic_droit(B)
	end
end


function B.update_popup(B)
	B.popup.text = "change le frame du sprite  :"..model.sprite[sprite_sel].frame..""
end
function B.condition()
	if tool == "anim_sprite"
	and sprite_sel ~= table.maxn(model.sprite)+1 then
		Bout_fra.text = "frame:"..model.sprite[sprite_sel].frame..""
		return( true )
	end
end
