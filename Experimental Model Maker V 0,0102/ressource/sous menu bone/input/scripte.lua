function B.init(B)				
	B.X = 0
	B.Y = 250
	B.text = "input:"
	B.popup = {}
	B.popup.X = B.X+50
	B.popup.Y = B.Y+50
	B.popup.text = "cliquer pour asigner une input a l'os selectioner ou tourner la roulette pour tester les mouvement"
	B.ido = 30
end
function B.clic_gauche(B)
	if model.model_data.bone[bone.select].tete.input == nil then
		set_clavier("",love.graphics.getWidth()/2-300,love.graphics.getHeight()/2-100,B.ido)
	else
		set_clavier(model_data.input[model.model_data.bone[bone.select].tete.input].nom,love.graphics.getWidth()/2-300,love.graphics.getHeight()/2-100,B.ido)
	end
	B.can = 0
end



function B.clic_droit(B)
end


function B.autre(B,bu)
	if model.model_data.bone[bone.select].tete.input ~= nil then
		if bu == "wu" then
			if love.mouse.getX() < B.X+B.normal[1]:getWidth()/2 then
				if model.model_data.bone[bone.select].tete.tipe == 0 then
					model.input[model.model_data.bone[bone.select].tete.input][1] = model.input[model.model_data.bone[bone.select].tete.input][1]+5/camera.zoom
				elseif model.model_data.bone[bone.select].tete.tipe == 1 then
					model.input[model.model_data.bone[bone.select].tete.input][1] = model.input[model.model_data.bone[bone.select].tete.input][1]+.1
					model.input[model.model_data.bone[bone.select].tete.input][1] = model.input[model.model_data.bone[bone.select].tete.input][1]-math.floor(model.input[model.model_data.bone[bone.select].tete.input][1]/math.pi/2)*math.pi*2
				end

			else
				if model.model_data.bone[bone.select].tete.tipe == 0 then
					model.input[model.model_data.bone[bone.select].tete.input][2] = model.input[model.model_data.bone[bone.select].tete.input][2]+5/camera.zoom
				elseif model.model_data.bone[bone.select].tete.tipe == 1 then
					model.input[model.model_data.bone[bone.select].tete.input][2] = model.input[model.model_data.bone[bone.select].tete.input][2]+.1
					model.input[model.model_data.bone[bone.select].tete.input][1] = model.input[model.model_data.bone[bone.select].tete.input][1]-math.floor(model.input[model.model_data.bone[bone.select].tete.input][1]/math.pi/2)*math.pi*2

				end


			end
		elseif bu == "wd" then
			if love.mouse.getX() < B.X+B.normal[1]:getWidth()/2 then
				if model.model_data.bone[bone.select].tete.tipe == 0 then
					model.input[model.model_data.bone[bone.select].tete.input][1] = model.input[model.model_data.bone[bone.select].tete.input][1]-5/camera.zoom
				elseif model.model_data.bone[bone.select].tete.tipe == 1 then
					model.input[model.model_data.bone[bone.select].tete.input][1] = model.input[model.model_data.bone[bone.select].tete.input][1]-.1
					model.input[model.model_data.bone[bone.select].tete.input][1] = model.input[model.model_data.bone[bone.select].tete.input][1]-math.floor(model.input[model.model_data.bone[bone.select].tete.input][1]/math.pi/2)*math.pi*2

				end

			else
				if model.model_data.bone[bone.select].tete.tipe == 0 then
					model.input[model.model_data.bone[bone.select].tete.input][2] = model.input[model.model_data.bone[bone.select].tete.input][2]-5/camera.zoom
				elseif model.model_data.bone[bone.select].tete.tipe == 1 then
					model.input[model.model_data.bone[bone.select].tete.input][2] = model.input[model.model_data.bone[bone.select].tete.input][2]-.1
					model.input[model.model_data.bone[bone.select].tete.input][1] = model.input[model.model_data.bone[bone.select].tete.input][1]-math.floor(model.input[model.model_data.bone[bone.select].tete.input][1]/math.pi/2)*math.pi*2


				end

			end

		end
		model_jump(model,model.anim,model.temp)

	end
end






function B.update(B,dot)


	if B.condi then

		if clavier.id == B.ido then
			B.ido = B.ido+1
			if B.ido == 39 then
				B.ido = 30
			end
			if not clavier.actif then
				if clavier.texte == "" then
					if model.model_data.bone[bone.select].tete.input ~= nil then
						remove_input_intel(model,model.model_data.bone[bone.select].tete.input)
						model.model_data.bone[bone.select].tete.input = nil
					end
					B.can = 0
					B.text = "input:"
				else
					if model.model_data.bone[bone.select].tete.input ~= nil then
						local mem = model.model_data.bone[bone.select].tete.input
						model.model_data.bone[bone.select].tete.input = nil
						remove_input_intel(model,mem)
					end


					if model.input[clavier.texte] == nil then
						rapporter_erreur("model_data_"..model.model_data.id.."_input_"..clavier.texte.."")
						table.insert( model.model_data.input , {nom = clavier.texte})
						table.insert( model.input , { 0 , 0 } )
						model.input[clavier.texte] = table.maxn(model.input)
					end

					for i,h in ipairs(model.input) do
						if h == model.input[clavier.texte] then
							model.model_data.bone[bone.select].tete.input = i
						end
					end
					for u,k in ipairs(model.model_data.anim) do
						for e,g in ipairs(k) do
							for i,h in ipairs(g.bone) do
								if h.os == bone.select then
									h.input = 1
								end
							end
						end
					end
					

					B.text = "input: "..model.model_data.input[model.model_data.bone[bone.select].tete.input].nom..""
				end
			end
		end


		if model.model_data.bone[bone.select].tete.input ~= nil then
			B.text = "input: "..model.model_data.input[model.model_data.bone[bone.select].tete.input].nom..""
		else
			B.text = "input:"
		end
	end

end
function B.condition(B)
	return( bone.select ~= 0 and mode == "editer" and mode_edit == "edit bone" )
end
