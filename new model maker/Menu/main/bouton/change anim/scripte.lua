function B.init(B)				
	B.X = 200
	B.Y = 0
	B.text = "anim:"

	B.popup = {}
	B.popup.X = B.X+50
	B.popup.Y = B.Y+50
	B.popup.text = "rouler pour changer d'animation\ncliquer pour changer le nom"
	B.ido = 20
end
function B.clic_gauche(B)
	set_clavier(model.model_data.anim[model.anim].nom,love.graphics.getWidth()/2-300,love.graphics.getHeight()/2-100,B.ido)
end

function B.clic_droit(B)


end
function B.autre(B,bu)
	if bu == "wu" then
		if model.anim < table.maxn(model.model_data.anim) then
			model_jump(model,model.anim+1)
		elseif model.model_data.anim[model.anim].nom ~= "new_anim" then
			local new = { { temp = 1 , bone =  {} , sprite = {} } }
			new.nom = "new_anim"
			new[1].prestep = new[1]
			new[1].tempo = 0
			table.insert(model.model_data.anim,new)
			model_jump(model,model.anim+1)
			timeline.select = 0
		end
	elseif bu == "wd" then
		if model.anim > 1 then
			timeline.select = 0
			model_jump(model,model.anim-1)
		end
	end
end
function B.update(B,dot)
	if B.condi then
		if clavier.id == B.ido then
			B.ido = B.ido+1
			if B.ido == 29 then
				B.ido = 0
			end
			if not clavier.actif then
				if clavier.texte == "" then
					if table.maxn(model.model_data.anim) == model.anim then
						model.model_data.anim[model.anim].nom = "new_anim"
					else
						table.remove(model.model_data.anim,model.anim)
					end
				else
					model.model_data.anim[model.anim].nom = clavier.texte
				end
			end

		end
		B.text = "anim:"..model.anim.."- "..model.model_data.anim[model.anim].nom..""
	end
end
function B.update_popup(B)

end
function B.condition()
	return(true)
end
