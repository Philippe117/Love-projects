function B.init(B)				
	B.X = 200
	B.Y = timeline.Y-50
	B.text = "remove anim os"

	B.popup = {}
	B.popup.X = B.X+50
	B.popup.Y = B.Y+25
	B.popup.text = "enleve la reference d'animation de l'os selectionner"
	B.os = 0
end
function B.clic_gauche(B)
	bone_remove_anim(model.model_data,model.anim,timeline.select,B.os)

end
function B.clic_droit(B)
end
function B.update(B,dot)
	if time_eta == 3.5 then
		B.X = timeline.X+40*timeline.ref
		B.popup.X = B.X+50
		decal = decal+1
		B.Y = timeline.Y-25-25*decal
		B.popup.Y = B.Y+25
	end
end
function B.condition(B)
	local rep = false
	if time_eta == 3.5 and bone.select ~= 0 and timeline.select ~= 0 then
		for i,h in ipairs(model.model_data.anim[model.anim][timeline.select].bone) do
			if h.os == bone.select then
				B.os = h
				rep = true
			end
		end
	end
	return (rep and mode == "editer")
end
