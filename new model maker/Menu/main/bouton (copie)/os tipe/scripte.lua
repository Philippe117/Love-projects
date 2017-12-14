function B.init(B)
	bout_coordangl = B				
	B.X = 200
	B.Y = 300
	B.text = "Mode coord"

	tool_mode = 0

	B.popup = {}
	B.popup.X = B.X+50
	B.popup.Y = B.Y+50
	B.popup.text = "switcher en mode angle"
end
function B.clic_gauche(B)
	if tool_mode == 0 then
		B.text = "Mode angle"
		tool_mode = 1
		B.popup.text = "switcher en mode coord"
	else
		B.text = "Mode coord"
		tool_mode = 0
		B.popup.text = "switcher en mode angle"
	end



end



function B.clic_droit(B)
	
end
function B.update_popup(B)

end
function B.condition()

		return( tool == "os" )

end
