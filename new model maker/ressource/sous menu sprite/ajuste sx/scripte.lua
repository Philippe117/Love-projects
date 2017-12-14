function B.init(B)
	B.X = 0
	B.Y = love.graphics.getHeight()-300
	B.text = "sX"

	B.popup = {}
	B.popup.X = B.X+100
	B.popup.Y = B.Y+25
	B.popup.text = "ajuste la taille en X du sprite"
	bouton_sx = B
end
function B.clic_gauche(B)
	local prop = model.model_data.sprite[sprite.select].sy/model.model_data.sprite[sprite.select].sx
	model.model_data.sprite[sprite.select].sx = model.model_data.sprite[sprite.select].sx+math.abs(model.model_data.sprite[sprite.select].sx)*.05+.01
	if sprite.prop then
		model.model_data.sprite[sprite.select].sy = model.model_data.sprite[sprite.select].sx*prop
	end
end
function B.clic_droit(B)
	local prop = model.model_data.sprite[sprite.select].sy/model.model_data.sprite[sprite.select].sx
	model.model_data.sprite[sprite.select].sx = model.model_data.sprite[sprite.select].sx-math.abs(model.model_data.sprite[sprite.select].sx)*.05-.01
	if sprite.prop then
		model.model_data.sprite[sprite.select].sy = model.model_data.sprite[sprite.select].sx*prop
	end
end
function B.autre(B,bu)
	if bu == "wu" then
		B.clic_gauche(B)
	elseif bu == "wd" then
		B.clic_droit(B)
	end
end
function B.update(B,dot)
	if B.condi == true then
		B.Y = 335+decal3
		B.popup.Y = B.Y+25
		decal3 = decal3+25
		B.text = "sx: "..(math.floor(model.model_data.sprite[sprite.select].sx*100)/100)..""
	end
end
function B.condition(B)

	return ( sprite.select ~= 0 and mode == "editer" and mode_edit == "edit sprite" )
end
