function B.init(B)
	B.X = 100
	B.Y = 250
	B.text = "move"
	B.popup = {}
	B.popup.X = 0
	B.popup.Y = B.Y+25
	B.popup.text = "determine le niveau du sprite dans la pile"
	B.os = 0
end
function B.clic_gauche(B)
	if sprite.select < table.maxn(model.model_data.sprite) then
		model.model_data.sprite[sprite.select] , model.model_data.sprite[sprite.select+1] = model.model_data.sprite[sprite.select+1] , model.model_data.sprite[sprite.select]
		model.sprite[sprite.select] , model.sprite[sprite.select+1] = model.sprite[sprite.select+1] , model.sprite[sprite.select]
		sprite.select = sprite.select+1
		sprite.decsel = sprite.decsel+.99
	end

end
function B.clic_droit(B)
	if sprite.select > 1 then
		model.model_data.sprite[sprite.select] , model.model_data.sprite[sprite.select-1] = model.model_data.sprite[sprite.select-1] , model.model_data.sprite[sprite.select]
		model.sprite[sprite.select] , model.sprite[sprite.select-1] = model.sprite[sprite.select-1] , model.sprite[sprite.select]
		sprite.select = sprite.select-1
		sprite.decsel = sprite.decsel-.99
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

end
function B.condition(B)
	return ( mode == "editer" and mode_edit == "edit sprite" and sprite.select ~= 0 )
end
