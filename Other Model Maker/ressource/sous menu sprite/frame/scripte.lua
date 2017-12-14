function B.init(B)
	B.X = 100
	B.Y = love.graphics.getHeight()-300
	B.text = "frame"
	B.popup = {}
	B.popup.X = B.X-100
	B.popup.Y = B.Y+25
	B.popup.text = "ajuste le frame du sprite"
	B.os = 0
end
function B.clic_gauche(B)
	bone.controle = sprite_timeline_add_anim(model)
	if bone.controle.prestep.eta.frame < table.maxn(model.model_data.sprite_list[model.model_data.sprite[sprite.select].sprite]) then

		local tempe = model.temp
		local orloge = model.orloge
		model_jump(model,model.anim,tempe-20)
		bone.controle.prestep.eta.frame = bone.controle.prestep.eta.frame+1
		model_jump(model,model.anim,tempe)
		model.orloge = orloge

	end
end
function B.clic_droit(B)
	bone.controle = sprite_timeline_add_anim(model)
	if bone.controle.prestep.eta.frame > 1 then

		local tempe = model.temp
		local orloge = model.orloge
		model_jump(model,model.anim,tempe-20)
		bone.controle.prestep.eta.frame = bone.controle.prestep.eta.frame-1
		model_jump(model,model.anim,tempe)
		model.orloge = orloge

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
		B.Y = 350+decal4
		B.popup.Y = B.Y+25
		decal4 = decal4+25
		B.text = "frame: "..model.sprite[sprite.select].frame..""
	end
end
function B.condition(B)

	return ( sprite.select ~= 0 and mode == "editer" and mode_edit == "edit sprite" )
end
