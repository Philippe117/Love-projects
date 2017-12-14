function B.init(B)				
	B.X = 560
	B.Y = 0
	B.text = ""
	B.frame = 2
	bout_play = B
end
function B.clic_gauche(B)
	if model.speed == 0 then
		model.speed = 1
	--	B.text = "pause"
		B.frame = 2

	else
		model.speed = 0
	--	B.text = "play"
		B.frame = 1

	end
end
function B.clic_droit(B)
	
end
function B.update_popup(B)

end
function B.condition()
	return(true)
end
