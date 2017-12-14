function B.init(B)				
	B.X = 300
	B.Y = 525
	B.text = "move Y"
	B.popup = {}
	B.popup.X = B.X+50
	B.popup.Y = B.Y+50
	B.popup.text = "deplacer le sprite sur laxe des y"
end
function B.clic_gauche(B)
	if model.model_data.sprite[sprite_sel].eritscale == 1 then
		model.model_data.sprite[sprite_sel].Y = model.model_data.sprite[sprite_sel].Y+.2
	else
		model.model_data.sprite[sprite_sel].D = model.model_data.sprite[sprite_sel].D+.05
	end
end



function B.clic_droit(B)
	if model.model_data.sprite[sprite_sel].eritscale == 1 then
		model.model_data.sprite[sprite_sel].Y = model.model_data.sprite[sprite_sel].Y-.2
	else
		model.model_data.sprite[sprite_sel].D = model.model_data.sprite[sprite_sel].D-.05
	end
end
function B.autre(B,bu)
	if bu == "wu" then
		B.clic_gauche(B)
	elseif bu == "wd" then
		B.clic_droit(B)
	end
end



function B.update_popup(B)

end
function B.condition()
	if sprite_sel ~= table.maxn(model.sprite)+1 then
		return(true)
	else
		return(false)
	end
end
