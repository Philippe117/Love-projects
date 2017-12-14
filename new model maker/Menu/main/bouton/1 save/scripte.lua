function B.init(B)				
	B.X = 0
	B.Y = 50
	B.text = "save"

	B.popup = {}
	B.popup.X = B.X+50
	B.popup.Y = B.Y+50
	B.popup.text = "enregistrer le model"
end
function B.clic_gauche(B)
	if model.model_data.nom ~= "nouveau model" then
		save_model(model.model_data,modname)
	end
end
function B.clic_droit(B)
end
function B.update_popup(B)

end
function B.condition()
	return(true)
end
