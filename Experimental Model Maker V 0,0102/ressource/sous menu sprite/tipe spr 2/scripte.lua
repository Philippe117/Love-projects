function B.init(B)
	B.X = love.graphics.getWidth()-100
	B.Y = 350
	B.text = "rot:"
	B.popup = {}
	B.popup.X = B.X-50
	B.popup.Y = B.Y+25
	B.popup.text = ""
end
function B.clic_gauche(B)
	sprite.eritrot = 1-sprite.eritrot
end
function B.clic_droit(B)
	sprite.eritrot = 1-sprite.eritrot
end
function B.update(B,dot)
	if B.condi then
		B.Y = 125+decal2
		B.popup.Y = B.Y+25
		decal2 = decal2+25

		if sprite.eritrot == 1 then
			B.text = "rot: oui"
			B.popup.text = "crera un sprite indiferent de la rotation de son os maitre"
		elseif sprite.eritrot == 0 then
			B.text = "rot: non"
			B.popup.text = "crera un sprite dependant de la rotation de son os maitre"
		end
	end
end
function B.condition(B)
	return( mode == "editer" and mode_edit == "edit sprite" )
end
