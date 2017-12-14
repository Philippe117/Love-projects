function B.init(B)				
	B.X = love.graphics.getWidth()-400
	B.Y = 10
	B.text = "edit bone"
	B.popup = {}
	B.popup.X = B.X
	B.popup.Y = B.Y+50
	B.popup.text = "permet d'editer les animation des os"
	bout_mode_edit_bone = B
	mode_edit = B.text

end
function B.clic_gauche(B)
	mode_edit = B.text
	timeline.mode = "bone"
	bout_mode_edit_spr.Y = 0
	B.Y = 10

end
function B.clic_droit(B)

end
function B.condition()
	return( mode == "editer")
end
