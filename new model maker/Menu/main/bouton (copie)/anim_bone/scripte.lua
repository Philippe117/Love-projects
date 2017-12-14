function B.init(B)				
	B.X = 0
	B.Y = 350
	B.text = "anim os tool"

	B.popup = {}
	B.popup.X = B.X+50
	B.popup.Y = B.Y+50
	B.popup.text = "animer les os"
end
function B.clic_gauche(B)

	tool = "anim_os"
	tool_mode = 0

end



function B.clic_droit(B)
	
end
function B.update_popup(B)

end
function B.condition()

		return( true )

end
