function B.init(B)
	B.X = 0
	B.Y = 275
	B.text = "remove sprite"
	B.popup = {}
	B.popup.X = B.X+50
	B.popup.Y = B.Y+25
	B.popup.text = "enleve le sprite selectionner"
end
function B.clic_gauche(B)
	sprite_remove(model.model_data,sprite.select)
	sprite.select = math.min(sprite.select,table.maxn(model.model_data.sprite))
end
function B.clic_droit(B)
end
function B.update(B,dot)
end
function B.condition(B)
	return( sprite.select ~= 0 and mode == "editer" and mode_edit == "edit sprite" )
end
