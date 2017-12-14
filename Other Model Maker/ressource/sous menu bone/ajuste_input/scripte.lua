function B.init(B)				
	B.X = love.graphics.getWidth()-200
	B.Y = love.graphics.getHeight()-300
	B.text = "input"

	B.popup = {}
	B.popup.X = B.X
	B.popup.Y = B.Y+25
	B.popup.text = "ajuste la valeur d'input de l'os"
	B.os = 0
end
function B.clic_gauche(B)
	bone.controle = bone_timeline_add_anim(model)
	bone.controle.prestep.input = math.min(1,math.floor((bone.controle.prestep.input+.06)*20)/20)
	model_jump(model,model.anim,model.temp)
end
function B.clic_droit(B)
	bone.controle = bone_timeline_add_anim(model)
	bone.controle.prestep.input = math.max(math.floor((bone.controle.prestep.input-.04)*20)/20)
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
		B.Y = love.graphics.getHeight()-300+decal3
		B.popup.Y = B.Y+25
		B.text = "input: "..math.floor(model.bone[bone.select].tete.input*100).."%"
		decal3 = decal3+25
	end
end
function B.condition(B)

	return ( bone.select ~= 0 and mode == "editer" and mode_edit == "edit bone" and model.model_data.bone[bone.select].tete.input ~= nil )
end
