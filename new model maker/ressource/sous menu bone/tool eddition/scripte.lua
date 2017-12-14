function B.init(B)
	B.X = love.graphics.getWidth()-210
	B.Y = 200
	B.text = "animation"
	B.popup = {}
	B.popup.X = B.X-50
	B.popup.Y = B.Y+50
	B.popup.text = "selectionner l'outil d'animation d'os"
	bout_tool_pos = B
end
function B.clic_gauche(B)
	bone.tool = "positionnement"
	bone.eta  = 0
	B.X = love.graphics.getWidth()-210
	bout_tool_crea.X = love.graphics.getWidth()-190
end
function B.clic_droit(B)
end
function B.update(B,dot)

end
function B.condition(B)
	return( mode == "editer" and mode_edit == "edit bone" )
end
