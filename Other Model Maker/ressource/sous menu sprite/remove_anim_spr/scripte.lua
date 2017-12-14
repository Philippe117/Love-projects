function B.init(B)				
	B.X = 100
	B.Y = 300
	B.text = "remove anim spr"

	B.popup = {}
	B.popup.X = B.X-100
	B.popup.Y = B.Y+25
	B.popup.text = "enleve le point d'animation du sprite selectionne au noment selectionne"
	B.spr = 0
end
function B.clic_gauche(B)
	sprite_remove_anim(model.model_data,model.anim,timeline.select,B.spr)

end
function B.clic_droit(B)
end
function B.update(B,dot)
	if B.condi == true then
		B.Y = 350+decal4
		B.popup.Y = B.Y+25
		decal4 = decal4+25
	end
end
function B.condition(B)
	local rep = false
	if sprite.select ~= 0 and timeline.select ~= 0 then
		for i,h in ipairs(model.model_data.anim[model.anim][timeline.select].sprite) do
			if h.spr == sprite.select then
				B.spr = h
				rep = true
			end
		end
	end
	return (rep and mode == "editer")
end
