function B.init(B)				
	B.X = 0
	B.Y = love.graphics.getHeight()-75
	B.text = "model scale"
	B.popup = {}
	B.popup.X = B.X+50
	B.popup.Y = B.Y-50
	B.popup.text = "ajuste la taille du model entier"
end
function B.clic_gauche(B)

	for i,h in ipairs(model.model_data.bone) do
		if h.base.tipe == 0 then
			h.base.pos.X = h.base.pos.X*1.111
			h.base.pos.Y = h.base.pos.Y*1.111
		end
		h.tete.L = h.tete.L*1.111

	end
	for i,h in ipairs(model.model_data.sprite) do
		h.sx = h.sx*1.111
		h.sy = h.sy*1.111
		h.X = h.X*1.111
		h.Y = h.Y*1.111
		if h.eritscale ~= 1 then
			h.L = h.L*1.111
		end
	end
	for u,k in ipairs(model.model_data.anim) do
		for e,g in ipairs(k) do
			for i,h in ipairs(g.bone) do
				if model.model_data.bone[h.os].tete.tipe == 0 then
					h.pos.X = h.pos.X*1.111
					h.pos.Y = h.pos.Y*1.111
				elseif model.model_data.bone[h.os].tete.tipe == 1 then
					h.pos.L = h.pos.L*1.111

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
			h.base.pos.X = h.base.pos.X*.9
			h.base.pos.Y = h.base.pos.Y*.9
		end

		h.tete.L = h.tete.L*.9

	end
	for i,h in ipairs(model.model_data.sprite) do
		h.sx = h.sx*.9
		h.sy = h.sy*.9
		h.X = h.X*.9
		h.Y = h.Y*.9
		if h.eritscale ~= 1 then
			h.L = h.L*.9
		end
	end

	for u,k in ipairs(model.model_data.anim) do
		for e,g in ipairs(k) do
			for i,h in ipairs(g.bone) do
				if model.model_data.bone[h.os].tete.tipe == 0 then
					h.pos.X = h.pos.X*.9
					h.pos.Y = h.pos.Y*.9
				elseif model.model_data.bone[h.os].tete.tipe == 1 then
					h.pos.L = h.pos.L*.9

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
