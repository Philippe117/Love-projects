function B.init(B)				
	B.X = 0
	B.Y = love.graphics.getHeight()-50
	B.text = "shrink anim"
	B.popup = {}
	B.popup.X = B.X+50
	B.popup.Y = B.Y-50
	B.popup.text = "ajuste la longueur de l'animation"
end
function B.clic_gauche(B)

	for i,h in ipairs(model.model_data.anim[model.anim]) do
		h.tempo = h.tempo*1.055555
		h.temp = h.temp*1.05555
	end
	for e,g in ipairs(model_data.anim[model.anim]) do
		for i,h in ipairs(g.bone) do
			if h.step >= h.prestep.step then
				h.prestep.temp = math.abs(g.tempo-model_data.anim[model.anim][h.prestep.step].tempo)
			else
				h.prestep.temp = math.abs(g.tempo-model_data.anim[model.anim][h.prestep.step].tempo+(model_data.anim[model.anim][table.maxn(model_data.anim[model.anim])].tempo+model_data.anim[model.anim][table.maxn(model_data.anim[model.anim])].temp))
			end
		end
		for i,h in ipairs(g.sprite) do
			if h.step >= h.prestep.step then
				h.prestep.temp = math.abs(g.tempo-model_data.anim[model.anim][h.prestep.step].tempo)
			else
				h.prestep.temp = math.abs(g.tempo-model_data.anim[model.anim][h.prestep.step].tempo+(model_data.anim[model.anim][table.maxn(model_data.anim[model.anim])].tempo+model_data.anim[model.anim][table.maxn(model_data.anim[model.anim])].temp))
			end
		end
	end
	model_jump(model,model.anim,model.temp+20)
	model_jump(model,model.anim,model.temp-20)



end
function B.clic_droit(B)

	for i,h in ipairs(model.model_data.anim[model.anim]) do
		h.tempo = h.tempo*.95
		h.temp = h.temp*.95
	end

	local temp = 0
	for e,g in ipairs(model_data.anim[model.anim]) do
		g.tempo = temp
		temp = temp+g.temp
	end
	for e,g in ipairs(model_data.anim[model.anim]) do
		for i,h in ipairs(g.bone) do
			if h.step >= h.prestep.step then
				h.prestep.temp = math.abs(g.tempo-model_data.anim[model.anim][h.prestep.step].tempo)
			else
				h.prestep.temp = math.abs(g.tempo-model_data.anim[model.anim][h.prestep.step].tempo+(model_data.anim[model.anim][table.maxn(model_data.anim[model.anim])].tempo+model_data.anim[model.anim][table.maxn(model_data.anim[model.anim])].temp))
			end
		end
		for i,h in ipairs(g.sprite) do
			if h.step >= h.prestep.step then
				h.prestep.temp = math.abs(g.tempo-model_data.anim[model.anim][h.prestep.step].tempo)
			else
				h.prestep.temp = math.abs(g.tempo-model_data.anim[model.anim][h.prestep.step].tempo+(model_data.anim[model.anim][table.maxn(model_data.anim[model.anim])].tempo+model_data.anim[model.anim][table.maxn(model_data.anim[model.anim])].temp))
			end
		end
	end
--	model_jump(model,model.anim,tempe)
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
