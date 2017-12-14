function B.init(B)
	B.X = 0
	B.Y = love.graphics.getHeight()-300
	B.text = "sY"

	B.popup = {}
	B.popup.X = B.X+100
	B.popup.Y = B.Y+25
	B.popup.text = "ajuste la taille en Y du sprite"
	B.os = 0
end
function B.clic_gauche(B)
	local prop = model.model_data.sprite[sprite.select].sx/model.model_data.sprite[sprite.select].sy
	model.model_data.sprite[sprite.select].sy = model.model_data.sprite[sprite.select].sy*1.11111111
	if sprite.prop then
		model.model_data.sprite[sprite.select].sx = model.model_data.sprite[sprite.select].sy*prop
	end
end
function B.clic_droit(B)
	local prop = model.model_data.sprite[sprite.select].sx/model.model_data.sprite[sprite.select].sy
	model.model_data.sprite[sprite.select].sy = model.model_data.sprite[sprite.select].sy*.9
	if sprite.prop then
		model.model_data.sprite[sprite.select].sx = model.model_data.sprite[sprite.select].sy*prop
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
		B.text = "sy: "..(math.floor(model.model_data.sprite[sprite.select].sy*100)/100)..""
	end
end
function B.condition(B)

	return ( sprite.select ~= 0 and mode == "editer" and mode_edit == "edit sprite" )
end
