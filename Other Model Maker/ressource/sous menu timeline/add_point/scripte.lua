function B.init(B)
	B.X = 200
	B.Y = timeline.Y-25
	B.text = "Add point"
	B.popup = {}
	B.popup.X = B.X+50
	B.popup.Y = B.Y+25
	B.popup.text = "ajouter un point de reference pour l'animation"
	decal = 0
end
function B.clic_gauche(B)
	add_point(model.model_data,model.anim,timeline.ref)
	--txt = txt+2
end
function B.clic_droit(B)
end
function B.update(B,dot)
	if time_eta == 3 then
		B.X = timeline.X+40*timeline.ref
		B.popup.X = B.X+50
		decal = decal+1
		B.Y = timeline.Y-25-25*decal
		B.popup.Y = B.Y+25
	end
end
function B.condition(B)
	return(time_eta == 3 and mode == "editer" )
end
