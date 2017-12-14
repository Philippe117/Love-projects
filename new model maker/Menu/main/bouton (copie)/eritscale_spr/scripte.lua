function B.init(B)				
	B.X = 100
	B.Y = 600
	B.text = "eritscale"
	B.popup = {}
	B.popup.X = B.X+50
	B.popup.Y = B.Y+50
	B.popup.text = "switcher en mode eritscale"
end
function B.clic_gauche(B)
	if model.model_data.sprite[sprite_sel].eritscale == 0 then
		model.model_data.sprite[sprite_sel].eritscale = 1
		model.model_data.sprite[sprite_sel].D = 0
		model.model_data.sprite[sprite_sel].L = 0
		model.model_data.sprite[sprite_sel].X = 0
		model.model_data.sprite[sprite_sel].Y = 0
	elseif model.model_data.sprite[sprite_sel].eritscale == 1 then
		model.model_data.sprite[sprite_sel].eritscale = 2
		model.model_data.sprite[sprite_sel].D = 0
		model.model_data.sprite[sprite_sel].L = 0
		model.model_data.sprite[sprite_sel].X = 0
		model.model_data.sprite[sprite_sel].Y = 0

	elseif model.model_data.sprite[sprite_sel].eritscale == 2 then
		model.model_data.sprite[sprite_sel].eritscale = 0
		model.model_data.sprite[sprite_sel].D = 0
		model.model_data.sprite[sprite_sel].L = 0
		model.model_data.sprite[sprite_sel].X = 0
		model.model_data.sprite[sprite_sel].Y = 0

	end
end



function B.clic_droit(B)
	
end
function B.update_popup(B)


	if model.model_data.sprite[sprite_sel].eritscale == 0 then
		B.text = "scale:non"
		B.popup.text = "switcher en mode eritscale:longueur"

	elseif model.model_data.sprite[sprite_sel].eritscale == 1 then
		B.text = "scale:longueur"
		B.popup.text = "switcher en mode eritscale:global"

	elseif model.model_data.sprite[sprite_sel].eritscale == 2 then
		B.text = "scale:global"
		B.popup.text = "switcher en mode eritscale:non"

	end


end
function B.condition()
	if sprite_sel ~= table.maxn(model.sprite)+1 then




		return(true)

	else
		return(false)
	end
end
