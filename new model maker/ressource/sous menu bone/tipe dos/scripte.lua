function B.init(B)
	B.X = love.graphics.getWidth()-150
	B.Y = love.graphics.getHeight()-300
	B.text = "mode coord"
	B.popup = {}
	B.popup.X = B.X-50
	B.popup.Y = B.Y+25
	B.popup.text = "cree des os de type coordonee cartesienne"
	bone.create_mode = 0
	B.clic_gauche(B)
end
function B.clic_gauche(B)
	if bone.create_mode == 0 then
		B.text = "mode vec"
		B.popup.text = "cree des os de type vectoriel"
		bone.create_mode = 1
	else
		B.text = "mode coord"
		B.popup.text = "cree des os de type coordonee cartesienne"
		bone.create_mode = 0
	end
end
function B.clic_droit(B)
end
function B.update(B,dot)
	if B.condi == true then
		B.Y = 275+decal2
		B.popup.Y = B.Y+25
		decal2 = decal2+25
	end
end
function B.condition(B)
	return( mode == "editer" and mode_edit == "edit bone" and bone.tool == "creation"  )
end
