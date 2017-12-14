function B.init(B)				
	B.X = 100
	B.Y = 550
	B.text = "eritrot:oui"


	B.popup = {}
	B.popup.X = B.X+50
	B.popup.Y = B.Y+50
	B.popup.text = "switcher en mode non'eritrot"
end
function B.clic_gauche(B)
	if model.model_data.sprite[sprite_sel].eritrot == 0 then
		B.text = "eritrot:oui"
		model.model_data.sprite[sprite_sel].eritrot = 1
		B.popup.text = "switcher en mode non'eritrot"
	else
		model.model_data.sprite[sprite_sel].eritrot = 0
		B.text = "eritrot:non"
		tool_mode2 = 0
		B.popup.text = "switcher en mode eritrot"
	end
end



function B.clic_droit(B)
	
end
function B.update_popup(B)
		if model.model_data.sprite[sprite_sel].eritrot == 1 then
			B.text = "eritrot:oui"
			B.popup.text = "switcher en mode non'eritrot"
		else
			B.text = "eritrot:non"
			B.popup.text = "switcher en mode eritrot"
		end
end
function B.condition()
	if sprite_sel ~= table.maxn(model.sprite)+1 then




		return(true)

	else
		return(false)
	end
end
