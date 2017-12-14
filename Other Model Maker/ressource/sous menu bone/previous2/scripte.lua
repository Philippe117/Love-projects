function B.init(B)
	B.X = love.graphics.getWidth()-100
	B.Y = 200
	B.text = "derniere position"
	B.popup = {}
	B.popup.X = B.X-100
	B.popup.Y = B.Y+75
	B.popup.text = "positionne l'os a la dernierre position"
end
function B.clic_gauche(B)
	if model.model_data.bone[bone.select].tete.tipe ~= 2 then
		bone.controle = bone_timeline_add_anim(model)
		if model.model_data.bone[bone.select].tete.tipe == 0 then
			bone.controle.prestep.pos = {X = bone.controle.prestep.prestep.pos.X , Y = bone.controle.prestep.prestep.pos.Y}
		elseif model.model_data.bone[bone.select].tete.tipe == 1 then
			bone.controle.prestep.pos = {D = bone.controle.prestep.prestep.pos.D , L = bone.controle.prestep.prestep.pos.L }
		end
		model_jump(model,model.anim,model.temp+20)
		model_jump(model,model.anim,model.temp-20)
	end
end
function B.clic_droit(B)
end
function B.update(B,dot)
	if B.condi == true then
		B.Y = love.graphics.getHeight()-300+decal4
		B.popup.Y = B.Y+25
		decal4 = decal4+25
	end
end
function B.condition(B)
	return(bone.eta == 2 and mode == "editer" )
end
