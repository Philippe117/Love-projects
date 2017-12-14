function B.init(B)				
	B.X = 0
	B.Y = 0
	B.text = "exit"

	B.popup = {}
	B.popup.X = B.X
	B.popup.Y = B.Y+50
	B.popup.text = "quiter l'editeur?"
end
function B.clic_gauche(B)
	love.event.push('quit')
end
function B.clic_droit(B)
	love.event.push('quit')
end
function B.update_popup(B)

end
function B.condition()
	return(true)
end
