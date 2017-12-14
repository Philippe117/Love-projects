function B.init(B)				
	B.X = 200
	B.Y = 200
	B.text = "derniere position"
	B.popup = {}
	B.popup.X = B.X+50
	B.popup.Y = B.Y+75
	B.popup.text = "positionne le sprite a la dernierre position"
end
function B.clic_gauche(B)

	sprite.controle = sprite_timeline_add_anim(model)
	sprite.controle.prestep.eta = {alpha = sprite.controle.prestep.prestep.eta.alpha , frame = sprite.controle.prestep.prestep.eta.frame}
	local orloge = model.orloge
	model_jump(model,model.anim,model.temp+20)
	model_jump(model,model.anim,model.temp-20)
	model.orloge = orloge

end
function B.clic_droit(B)
end
function B.update(B,dot)
	if B.condi == true then
		decal = decal+25
		B.X = sprite.ref.X+10
		B.Y = sprite.ref.Y+decal
		B.popup.X = B.X+50
		B.popup.Y = B.Y+25
	end
end
function B.condition(B)
	return(sprite.eta == 2 and mode == "editer" )
end
