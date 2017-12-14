function B.init(B)
	B.X = 200
	B.Y = 200
	B.text = "derniere position"
	B.popup = {}
	B.popup.X = B.X+50
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

		local orloge = model.orloge
		model_jump(model,model.anim,model.temp+20)
		model_jump(model,model.anim,model.temp-20)
		model.orloge = orloge

	end

end
function B.clic_droit(B)
end
function B.update(B,dot)
	if B.condi == true then
		decal = decal+1
		B.X = bone.ref.X+10
		B.Y = bone.ref.Y+25*decal
		B.popup.X = B.X+50
		B.popup.Y = B.Y+25
	end
end
function B.condition(B)
	return(bone.eta == 2 and mode == "editer" )
end
