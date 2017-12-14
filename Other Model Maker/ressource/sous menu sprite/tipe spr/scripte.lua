function B.init(B)
	B.X = love.graphics.getWidth()-100
	B.Y = 325
	B.text = "scale:"
	B.popup = {}
	B.popup.X = B.X-50
	B.popup.Y = B.Y+25
	B.popup.text = ""
end
function B.clic_gauche(B)
	sprite.eritscale = sprite.eritscale+1
	if sprite.eritscale > 2 then
		sprite.eritscale = 1
	end
end
function B.clic_droit(B)
	sprite.eritscale = sprite.eritscale-1
	if sprite.eritscale < 0 then
		sprite.eritscale = 2
	end
end
function B.update(B,dot)
	if B.condi then

		B.Y = 125+decal2
		B.popup.Y = B.Y+25
		decal2 = decal2+25

		if sprite.eritscale == 0 then
			B.text = "scale: indif"
			B.popup.text = "crera un sprite indiferent de la longueur de son os maitre"
		elseif sprite.eritscale == 1 then
			B.text = "scale: long"
			B.popup.text = "crera un sprite dependant de la longueur de son os maitre en longueur seulement"
		elseif sprite.eritscale == 2 then
			B.text = "scale: ball"
			B.popup.text = "crera un sprite dependant de la longueur de son os maitre en toute direction"

		end
	end
end
function B.condition(B)
	return( mode == "editer" and mode_edit == "edit sprite" )
end
