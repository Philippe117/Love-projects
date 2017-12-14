function B.init(B)				
	B.X = 200
	B.Y = timeline.Y-25
	B.text = "remove point"

	B.popup = {}
	B.popup.X = B.X+50
	B.popup.Y = B.Y+25
	B.popup.text = "enleve le point de reference de l'animation"

end
function B.clic_gauche(B)
	remove_point(model.model_data,model.anim,timeline.select)
	timeline.select = 0
	timeline.canselect = 0
	bone.select = 0
	bone.canselect = 0

	--txt = txt+2
end
function B.clic_droit(B)
end
function B.update(B,dot)
	if time_eta == 3.5 then
		B.X = timeline.X+40*timeline.ref
		B.popup.X = B.X+50
		decal = 0
		B.Y = timeline.Y-25-25*decal
		B.popup.Y = B.Y+25
	end
end
function B.condition(B)

	return(time_eta == 3.5 and mode == "editer" )
end
