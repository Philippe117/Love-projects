function B.init(B)				
	B.X = 0
	B.Y = love.graphics.getHeight()-125
	B.text = "position precedente"
	B.popup = {}
	B.popup.X = B.X+50
	B.popup.Y = B.Y-50
	B.popup.text = "cree un point pour tout les os et les sprite identique a leur precedent"
end
function B.clic_gauche(B)


	local sprsel = sprite.select
	for i,h in ipairs(model.sprite) do
		sprite.select = i
		sprite.controle = sprite_timeline_add_anim(model)
		sprite.controle.prestep.eta = {alpha = sprite.controle.prestep.prestep.eta.alpha , frame = sprite.controle.prestep.prestep.eta.frame}
	end
	sprite.select = sprsel
	local bosel = bone.select
	for i,h in ipairs(model.bone) do
		bone.select = i
		if model.model_data.bone[bone.select].tete.tipe ~= 2 then
			bone.controle = bone_timeline_add_anim(model)
			if model.model_data.bone[bone.select].tete.tipe == 0 then
				bone.controle.prestep.pos = {X = bone.controle.prestep.prestep.pos.X , Y = bone.controle.prestep.prestep.pos.Y}
			elseif model.model_data.bone[bone.select].tete.tipe == 1 then
				bone.controle.prestep.pos = {D = bone.controle.prestep.prestep.pos.D , L = bone.controle.prestep.prestep.pos.L }
			end
		end
	end
	bone.select = bosel

end
function B.clic_droit(B)

end

function B.update(B,dot)
end
function B.condition(B)
	return( mode == "editer" )
end
