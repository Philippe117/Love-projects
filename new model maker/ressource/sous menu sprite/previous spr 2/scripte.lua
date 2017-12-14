function B.init(B)				
	B.X = 100
	B.Y = 200
	B.text = "derniere position"
	B.popup = {}
	B.popup.X = B.X-100
	B.popup.Y = B.Y+75
	B.popup.text = "ajuste l'animation du sprite a la position précedente dans la ligne du temps"
end
function B.clic_gauche(B)
	if model.model_data.sprite[sprite.select].tete.tipe ~= 2 then
		sprite.controle = sprite_timeline_add_anim(model)
		if model.model_data.sprite[sprite.select].tete.tipe == 0 then
			sprite.controle.prestep.pos = {X = sprite.controle.prestep.prestep.pos.X , Y = sprite.controle.prestep.prestep.pos.Y}
		elseif model.model_data.sprite[sprite.select].tete.tipe == 1 then
			sprite.controle.prestep.pos = {D = sprite.controle.prestep.prestep.pos.D , L = sprite.controle.prestep.prestep.pos.L }
		end
		model_jump(model,model.anim,model.temp+20)
		model_jump(model,model.anim,model.temp-20)
	end
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
	return(sprite.select ~= 0 and mode == "editer" and mode_edit == "edit sprite" )
end
