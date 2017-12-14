function B.init(B)
	B.X = love.graphics.getWidth()-190
	B.Y = 150
	B.text = "creation"
	B.popup = {}
	B.popup.X = B.X-50
	B.popup.Y = B.Y+50
	B.popup.text = "selectionner l'outil de creation d'os"
	bout_tool_crea = B
end
function B.clic_gauche(B)
	bone.tool = B.text
	bone.eta  = 0
	B.X = love.graphics.getWidth()-210
	bout_tool_pos.X = love.graphics.getWidth()-190
end
function B.clic_droit(B)
end
function B.update(B,dot)
	
end
function B.condition(B)
	return( mode == "editer" and mode_edit == "edit bone" )
end
