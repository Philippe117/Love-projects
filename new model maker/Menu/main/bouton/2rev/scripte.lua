function B.init(B)				
	B.X = 125
	B.Y = love.graphics.getHeight()-130
	B.text = ""
	bout_rev = B
end
function B.clic_gauche(B)

	model.speed = -1

end
function B.clic_droit(B)
	model.speed = -2
end
function B.autre(B,bu)
	if bu == "wu" then
		model.speed = model.speed+.1
	elseif bu == "wd" then
		model.speed = model.speed-.1
	end
end
function B.update_popup(B)

end
function B.condition()
	return(true)
end
