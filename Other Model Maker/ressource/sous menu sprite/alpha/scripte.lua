function B.init(B)
	B.X = 100
	B.Y = love.graphics.getHeight()-300
	B.text = "alpha"

	B.popup = {}
	B.popup.X = B.X-100
	B.popup.Y = B.Y+25
	B.popup.text = "ajuste le niveau d'aupacite du sprite"
	B.os = 0
end
function B.clic_gauche(B)
	bone.controle = sprite_timeline_add_anim(model)
	local tempe = model.temp
	local orloge = model.orloge
	model_jump(model,model.anim,tempe-20)
	bone.controle.prestep.eta.alpha = math.min(255,bone.controle.prestep.eta.alpha+5)
	model_jump(model,model.anim,tempe)
	model.orloge = orloge
end
function B.clic_droit(B)

	

	bone.controle = sprite_timeline_add_anim(model)
	local tempe = model.temp
	local orloge = model.orloge
	model_jump(model,model.anim,tempe-20)
	bone.controle.prestep.eta.alpha = math.max(0,bone.controle.prestep.eta.alpha-5)
	model_jump(model,model.anim,tempe)
	model.orloge = orloge
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
		B.text = "alpha: "..math.floor(model.sprite[sprite.select].alpha/2.55).."%"
	end
end
function B.condition(B)

	return ( sprite.select ~= 0 and mode == "editer" and mode_edit == "edit sprite" )
end
