function B.init(B)
	B.X = love.graphics.getWidth()-150
	B.Y = love.graphics.getHeight()-300
	B.text = "aff long :on"
	B.popup = {}
	B.popup.X = B.X-50
	B.popup.Y = B.Y+25
	B.popup.text = "affecte la longueur des os de mode vecteur"
	bone.affectlong = true
	B.clic_gauche(B)
end
function B.clic_gauche(B)
	if bone.affectlong then
		B.text = "aff long :off"
		B.popup.text = "n'affecte pas la longueur des os de mode vecteur"
	else
		B.text = "aff long :on"
		B.popup.text = "affecte la longueur des os de mode vecteur"
	end
	bone.affectlong = not bone.affectlong
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
	return( mode == "editer" and mode_edit == "edit bone" and bone.tool == "positionnement"  )
end
