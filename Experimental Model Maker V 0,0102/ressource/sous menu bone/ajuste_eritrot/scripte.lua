function B.init(B)				
	B.X = love.graphics.getWidth()-100
	B.Y = love.graphics.getHeight()-300
	B.text = "eritrot"

	B.popup = {}
	B.popup.X = B.X-100
	B.popup.Y = B.Y+25
	B.popup.text = "ajuste l'eredite de la rotation de l'os par raport a sa base"
	B.os = 0
end
function B.clic_gauche(B)
	bone.controle = bone_timeline_add_anim(model)
	bone.controle.prestep.eritrot = math.floor((bone.controle.prestep.eritrot+.06)*20)/20
	model_jump(model,model.anim,model.temp)
end
function B.clic_droit(B)
	bone.controle = bone_timeline_add_anim(model)
	bone.controle.prestep.eritrot = math.floor((bone.controle.prestep.eritrot-.04)*20)/20
	model_jump(model,model.anim,model.temp)
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

		B.Y = love.graphics.getHeight()-300+decal4
		B.popup.Y = B.Y+25
		B.text = "eritrot: "..math.floor(model.bone[bone.select].tete.vec.eritrot*100).."%"
		decal4 = decal4+25
	end
end
function B.condition(B)
	return ( bone.select ~= 0 and model.model_data.bone[bone.select].tete.tipe == 1 and mode == "editer" and mode_edit == "edit bone" )
end
