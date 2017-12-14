function B.init(B)				
	B.X = 50
	B.Y = love.graphics.getHeight()-100
	B.text = "Y"
	B.popup = {}
	B.popup.X = B.X+50
	B.popup.Y = B.Y-50
	B.popup.text = "ajuste la position en Y du model entier"
end
function B.clic_gauche(B)

	for i,h in ipairs(model.model_data.bone) do
		if h.base.tipe == 0 then
			h.base.pos.Y = h.base.pos.Y+5/camera.zoom
		end
	end

	for u,k in ipairs(model.model_data.anim) do
		for e,g in ipairs(k) do
			for i,h in ipairs(g.bone) do
				if model.model_data.bone[h.os].tete.tipe == 0 then
					h.pos.Y = h.pos.Y+5/camera.zoom
				end
			end
		end
	end

	model_jump(model,model.anim,model.temp+20)
	model_jump(model,model.anim,model.temp-20)



end
function B.clic_droit(B)
	for i,h in ipairs(model.model_data.bone) do
		if h.base.tipe == 0 then
			h.base.pos.Y = h.base.pos.Y-5/camera.zoom
		end
	end

	for u,k in ipairs(model.model_data.anim) do
		for e,g in ipairs(k) do
			for i,h in ipairs(g.bone) do
				if model.model_data.bone[h.os].tete.tipe == 0 then
					h.pos.Y = h.pos.Y-5/camera.zoom
				end
			end
		end
	end

	model_jump(model,model.anim,model.temp+20)
	model_jump(model,model.anim,model.temp-20)




end

function B.autre(B,bu)
	if bu == "wu" then
		B.clic_gauche(B)
	elseif bu == "wd" then
		B.clic_droit(B)
	end
end
function B.update(B,dot)
end
function B.condition(B)
	return( mode == "editer" )
end
