function B.init(B)
	B.X = 0
	B.Y = love.graphics.getHeight()-300
	B.text = "Y"

	B.popup = {}
	B.popup.X = B.X
	B.popup.Y = B.Y+25
	B.popup.text = "ajuste le decalage en Y du sprite"
	B.os = 0
end
function B.clic_gauche(B)
	model.model_data.sprite[sprite.select].Y = math.floor((model.model_data.sprite[sprite.select].Y+4/camera.zoom)*100)/100
end
function B.clic_droit(B)
	model.model_data.sprite[sprite.select].Y = math.floor((model.model_data.sprite[sprite.select].Y-4/camera.zoom)*100)/100
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
		B.text = "Y: "..(math.floor(model.model_data.sprite[sprite.select].Y*10)/10)..""
	end
end
function B.condition(B)

	return ( sprite.select ~= 0 and mode == "editer" and mode_edit == "edit sprite" and model.model_data.sprite[sprite.select].eritscale == 1 )
end
