function B.init(B)
	B.X = 75
	B.Y = 250
	B.text = ""
	B.popup = {}
	B.popup.X = 0
	B.popup.Y = B.Y+50
	B.popup.text = "verrouille les proportion du sprite"
	sprite.prop = true
end
function B.clic_gauche(B)
	sprite.prop = not sprite.prop
end
function B.clic_droit(B)

end
function B.autre(B,bu)

end
function B.update(B,dot)
	if B.condi then
		B.Y = bouton_sx.Y
		B.popup.Y = B.Y+50
		if sprite.prop then
			B.frame = 2
		else
			B.frame = 1
		end
	end
end
function B.condition(B)
	return ( mode == "editer" and mode_edit == "edit sprite" and sprite.select ~= 0 )
end
