function B.init(B)
	B.X = love.graphics.getWidth()-200
	B.Y = 225
	B.text = "add sprite"
	B.popup = {}
	B.popup.X = B.X-50
	B.popup.Y = B.Y+50
	B.popup.text = "cree le sprite choisie"
	sprite.eritrot = 1
	sprite.eritscale = 1
end
function B.clic_gauche(B)
	local new = add_sprite(model_data,sprite.select,sprite.choix,bone.select,sprite.eritrot,sprite.eritscale,sprite.alpha)
	sprite.select = new.id

end
function B.clic_droit(B)
end
function B.update(B,dot)

end
function B.condition(B)
	return( bone.select ~= 0 and sprite.choix ~= 0 and mode == "editer" and mode_edit == "edit sprite" )
end
