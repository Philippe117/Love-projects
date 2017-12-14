function B.init(B)				
	B.X = 0
	B.Y = 300
	B.text = "add os tool"

	B.popup = {}
	B.popup.X = B.X+50
	B.popup.Y = B.Y+50
	B.popup.text = "ajouter des os"
end
function B.clic_gauche(B)

	tool = "os"
	tool_mode = 0
	bout_coordangl.text = "Mode coord"
	bout_coordangl.popup.text = "switcher en mode angle"
end



function B.clic_droit(B)
	
end
function B.update_popup(B)

end
function B.condition()

		return( true )

end
