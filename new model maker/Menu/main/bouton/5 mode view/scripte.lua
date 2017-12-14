function B.init(B)				
	B.X = love.graphics.getWidth()/2-50
	B.Y = 0
	B.text = "visioner"
	B.popup = {}
	B.popup.X = B.X
	B.popup.Y = B.Y+50
	B.popup.text = "passer en mode visionement"
end
function B.clic_gauche(B)
	mode = B.text
	if B.text == "visioner" then
		B.text = "editer"
		B.popup.text = "passer en mode edition"
	elseif B.text == "editer" then
		B.text = "visioner"
		B.popup.text = "passer en mode visionement"
	end

end
function B.clic_droit(B)

end
function B.condition()
	return(true)
end
