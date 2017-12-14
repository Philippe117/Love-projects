function B.init(B)
	B.X = 0
	B.Y = 250
	B.text = "folow: off"
	B.popup = {}
	B.popup.X = B.X+50
	B.popup.Y = B.Y+25
	B.popup.text = "Centrer la camera sur le sprite"
	B.folow = false	
end
function B.clic_gauche(B)
	B.folow = not B.folow
	if B.folow then
		B.text = "folow: on"
	else
		B.text = "folow: off"
	end
end
function B.clic_droit(B)
end
function B.update(B,dot)
	if B.condi and B.folow and sprite.select ~= 0 then
		local a = model.pos.A+model.bone[model.model_data.sprite[sprite.select].chef].tete.pos.A
		local scale = model.bone[model.model_data.sprite[sprite.select].chef].tete.pos.scale
		if model.model_data.sprite[sprite.select].eritscale == 0 then
			cam_x = model.pos.X+model.bone[model.model_data.sprite[sprite.select].chef].base.pos.X+model.model_data.sprite[sprite.select].L*math.cos(model.model_data.sprite[sprite.select].D+a)
			cam_y = model.pos.Y+model.bone[model.model_data.sprite[sprite.select].chef].base.pos.Y+model.model_data.sprite[sprite.select].L*math.sin(model.model_data.sprite[sprite.select].D+a)
		elseif model.model_data.sprite[sprite.select].eritscale == 1 then
			cam_x = model.pos.X+model.bone[model.model_data.sprite[sprite.select].chef].base.pos.X+model.model_data.sprite[sprite.select].X*math.cos(a)*scale+model.model_data.sprite[sprite.select].Y*math.sin(a)
			cam_y = model.pos.Y+model.bone[model.model_data.sprite[sprite.select].chef].base.pos.Y+model.model_data.sprite[sprite.select].X*math.sin(a)*scale-model.model_data.sprite[sprite.select].Y*math.cos(a)
		elseif model.model_data.sprite[sprite.select].eritscale == 2 then
			cam_x = model.pos.X+model.bone[model.model_data.sprite[sprite.select].chef].base.pos.X+model.model_data.sprite[sprite.select].L*math.cos(model.model_data.sprite[sprite.select].D+a)*scale
			cam_y = model.pos.Y+model.bone[model.model_data.sprite[sprite.select].chef].base.pos.Y+model.model_data.sprite[sprite.select].L*math.sin(model.model_data.sprite[sprite.select].D+a)*scale
		end
	end

end
function B.condition(B)
	return(  mode == "editer" and mode_edit == "edit sprite" )
end
