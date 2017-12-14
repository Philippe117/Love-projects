function B.init(B)				
	B.X = love.graphics.getWidth()-200
	B.Y = 0
	B.text = "edit sprite"
	B.popup = {}
	B.popup.X = B.X
	B.popup.Y = B.Y+50
	B.popup.text = "permet d'editer les animation des sprite"
	bout_mode_edit_spr = B
end
function B.clic_gauche(B)
	mode_edit = B.text
	bout_mode_edit_bone.Y = 0
	timeline.mode = "sprite"
	B.Y = 10
end
function B.clic_droit(B)

end
function B.condition()
	return(mode == "editer")
end
