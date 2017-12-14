function B.init(B)
	B.X = love.graphics.getWidth()-210
	B.Y = 10
	B.text = "exit"

	B.popup = {}
	B.popup.X = B.X-100
	B.popup.Y = B.Y+50
	B.popup.text = "quiter le jeux"

end
function B.clic_gauche(B)
	love.event.push('q')
end
function B.clic_droit(B)
	love.event.push('q')
end
function B.update_popup(B)

end


function B.condition()
	return(true)
end
