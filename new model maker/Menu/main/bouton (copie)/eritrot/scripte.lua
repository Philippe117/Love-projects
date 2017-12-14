function B.init(B)				
	B.X = 225
	B.Y = 350
	B.text = "eritrot:oui"

	tool_mode2 = 1

	B.popup = {}
	B.popup.X = B.X+50
	B.popup.Y = B.Y+50
	B.popup.text = "switcher en mode non'eritrot"
end
function B.clic_gauche(B)
	if tool_mode2 == 0 then
		B.text = "eritrot:oui"
		tool_mode2 = 1
		B.popup.text = "switcher en mode non'eritrot"
	else
		B.text = "eritrot:non"
		tool_mode2 = 0
		B.popup.text = "switcher en mode eritrot"
	end
end



function B.clic_droit(B)
	
end
function B.update_popup(B)

end
function B.condition()
	if tool == "os"
	and tool_mode == 1 then
		return(true)
	else
		return(false)
	end
end
