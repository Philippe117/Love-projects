function B.init(B)				
	B.X = 0
	B.Y = 300
	B.text = "input ajust:"
	B.popup = {}
	B.popup.X = B.X+50
	B.popup.Y = B.Y+50
	B.popup.text = "tourner la roulette pour ajuster le ratio de l'input"
	B.ido = 30
end
function B.clic_gauche(B)
	for i,h in ipairs(model.model_data.anim[model.anim]) do
		for u,k in ipairs(h.bone) do
			if k.os == bone.select and k.input ~= nil then
				k.prestep.input = math.min(1,k.prestep.input*1.1111)
				model_jump(model,model.anim,model.temp)
			end
		end
	end

end
function B.clic_droit(B)
	for i,h in ipairs(model.model_data.anim[model.anim]) do
		for u,k in ipairs(h.bone) do
			if k.os == bone.select and k.input ~= nil then
				k.input = k.input*.9
				model_jump(model,model.anim,model.temp)
			end
		end
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
	if B.condi == true then
		B.text = "input: "..math.floor(model.bone[bone.select].tete.input*100).."%"
	end

end
function B.condition(B)

	return ( bone.select ~= 0 and mode == "editer" and mode_edit == "edit bone" and model.model_data.bone[bone.select].tete.input ~= nil )
end
