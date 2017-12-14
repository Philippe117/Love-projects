function B.init(B)				
	B.X = 0
	B.Y = 150
	B.text = "show\nsprite et scelette"
	draw_mode = 2
	B.popup = {}
	B.popup.X = B.X+50
	B.popup.Y = B.Y+50
	B.popup.text = "clique gauche pour\nvoir les sprite seulement"
end
function B.clic_gauche(B)
	if draw_mode == 1 then
		draw_mode = 2
		B.text = "show\nsprite et scelette"
		B.popup.text = "clique gauche pour\nvoir les sprite seulement"
	elseif draw_mode == 2 then
		draw_mode = 3
		B.text = "show sprite"
		B.popup.text = "clique gauche pour\nvoir les os seulement"
	elseif draw_mode == 3 then
		draw_mode = 1
		B.text = "show scelette"
		B.popup.text = "clique gauche pour\nvoir les sprite et les os"
	end

end



function B.clic_droit(B)
	
end
function B.update_popup(B)

end
function B.condition()

		return( true )

end
