function B.init(B)
	B.X = 0
	B.Y = 200
	B.text = "sel sprite"
	B.popup = {}
	B.popup.X = B.X
	B.popup.Y = B.Y-50
	B.popup.text = "selectione le sprite"
	B.os = 0
	sprite.possel = B.Y
end
function B.clic_gauche(B)
	sprite.select = math.min(table.maxn(model.model_data.sprite),sprite.select+1)
end
function B.clic_droit(B)
	sprite.select = math.max(0,sprite.select-1)
end
function B.autre(B,bu)
	if bu == "wu" then
		B.clic_gauche(B)
	elseif bu == "wd" then
		B.clic_droit(B)
	end
end
function B.update(B,dot)
	if B.condi then
		B.text = "sprite select: "..sprite.select.."         "
	end
end
function B.condition(B)
	return ( mode == "editer" and mode_edit == "edit sprite" )
end
