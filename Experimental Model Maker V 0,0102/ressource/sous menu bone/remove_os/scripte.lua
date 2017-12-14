function B.init(B)				
	B.X = 200
	B.Y = 200
	B.text = "remove os"

	B.popup = {}
	B.popup.X = B.X+50
	B.popup.Y = B.Y+25
	B.popup.text = "enleve l'os selectionner et tous len elements en dependent"

end
function B.clic_gauche(B)
	bone_remove(model.model_data,bone.select)
	bone.select = 0
	bone.canselect = 0

	--txt = txt+2
end
function B.clic_droit(B)
end
function B.update(B,dot)
	if B.condi == true then

		B.X = bone.ref.X+10
		B.Y = bone.ref.Y
		B.popup.X = B.X+50
		B.popup.Y = B.Y+25
		decal = decal+25
	end
end
function B.condition(B)

	return(bone.eta == 2 and mode == "editer" )
end
