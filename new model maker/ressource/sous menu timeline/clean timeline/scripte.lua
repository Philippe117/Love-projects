function B.init(B)				
	B.X = 0
	B.Y = love.graphics.getHeight()-25
	B.text = "clean timeline"
	B.popup = {}
	B.popup.X = B.X+50
	B.popup.Y = B.Y-50
	B.popup.text = "enleve les point de reference d'animation inutiliser"
end
function B.clic_gauche(B)
	local i = table.maxn(model.model_data.anim[model.anim])
	while i > 0 do
		local h = model.model_data.anim[model.anim][i]
		if table.maxn(h.bone) == 0 and table.maxn(h.sprite) == 0 then
			remove_point(model_data,model.anim,i)	
		end
		i = i-1
	end
end
function B.clic_droit(B)
end
function B.update(B,dot)
end
function B.condition(B)
	return( mode == "editer" )
end
