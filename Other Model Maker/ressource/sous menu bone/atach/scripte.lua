function B.init(B)
	B.X = 0
	B.Y = 200
	B.text = "atach:"
	B.popup = {}
	B.popup.X = B.X+50
	B.popup.Y = B.Y+50
	B.popup.text = "cliquer pour asigner un point d'atache"
	B.atach = 0
	B.can = 0
	B.ido = 10
end
function B.clic_gauche(B)
	if B.can == bone.select then
		local new = create_atach(model,add_atach(model,bone.select))
		B.atach = new
		table.insert(model.atach,new)
		set_clavier(B.atach.atach_data.nom,love.graphics.getWidth()/2-300,love.graphics.getHeight()/2-100,B.ido)
		B.can = 0
	else
		set_clavier(B.atach.atach_data.nom,love.graphics.getWidth()/2-300,love.graphics.getHeight()/2-100,B.ido)
		B.can = 0
	end
end



function B.clic_droit(B)
end
function B.update(B,dot)


	if B.condi then

		if clavier.id == B.ido then
			B.ido = B.ido+1
			if B.ido == 19 then
				B.ido = 10
			end
			if not clavier.actif then
				if clavier.texte == "" then
					remove_atach(model,B.atach.id)
					B.atach = 0
					B.can = 0
					B.text = "atach:"
				else
					B.atach.atach_data.nom = ""
					B.atach.atach_data.nom = check_nom(model.model_data.atach,clavier.texte)
					B.text = "atach: "..B.atach.atach_data.nom..""
				end
			end

		end


		if B.can ~= bone.select then

			if B.atach ~= model.bone[bone.select].tete.pos then
				B.atach = 0
				for i,h in ipairs(model.atach) do
					if h == model.bone[bone.select].tete.pos then
						B.atach = h
					end
				end
			end

			if B.atach == model.bone[bone.select].tete.pos then
				B.text = "atach: "..B.atach.atach_data.nom..""
			else
				B.can = bone.select
			end
		else
			B.text = "atach:"
		end
	end

end
function B.condition(B)
	return( bone.select ~= 0 and mode == "editer" and mode_edit == "edit bone" )
end
