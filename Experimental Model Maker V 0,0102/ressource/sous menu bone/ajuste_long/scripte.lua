function B.init(B)				
	B.X = love.graphics.getWidth()-200
	B.Y = love.graphics.getHeight()-300
	B.text = "long"

	B.popup = {}
	B.popup.X = B.X
	B.popup.Y = B.Y+25
	B.popup.text = "ajuste la longueur de reference de l'os"
	B.os = 0
end
function B.clic_gauche(B)

	model.model_data.bone[bone.select].tete.L = math.floor((model.model_data.bone[bone.select].tete.L+4/camera.zoom)*100)/100
end
function B.clic_droit(B)
	model.model_data.bone[bone.select].tete.L = math.floor((model.model_data.bone[bone.select].tete.L-4/camera.zoom)*100)/100
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
		B.text = "long: "..math.floor(model.bone[bone.select].tete.pos.scale*100).."%"
		decal3 = decal3+25
	end
end
function B.condition(B)

	return ( bone.select ~= 0 and mode == "editer" and mode_edit == "edit bone" )
end
