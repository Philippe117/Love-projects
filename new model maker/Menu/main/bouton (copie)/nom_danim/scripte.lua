function B.init(B)				
	B.X = 700
	B.Y = 0
	B.text = "nom: sans nom"
	Bout_anim_non = B
	B.popup = {}
	B.popup.X = B.X+50
	B.popup.Y = B.Y+50
	B.popup.text = "le nom de l'animation"
	B.on = false
end
function B.clic_gauche(B)
	if B.on then
		model.model_data.anim[model.anim].nom = ok_clavier(model.model_data.anim[model.anim].nom)
	else
		set_clavier(model.model_data.anim[model.anim].nom,-400,-400)
	end
	B.on = not B.on
end
function B.clic_droit(B)
	
end
function B.update_popup(B)

end
function B.condition()
	if Bout_anim_non.on then
		love.mouse.setPosition(Bout_anim_non.X+50,Bout_anim_non.Y+25)
		Bout_anim_non.text = "nom: "..clavier.texte..""
	else
--		Bout_anim_non.text = "nom: "..model.model_data.anim[model.anim].nom..""
	end
	return( true )
end
