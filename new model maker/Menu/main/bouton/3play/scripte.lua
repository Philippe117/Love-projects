function B.init(B)				
	B.X = 175
	B.Y = love.graphics.getHeight()-130
	B.text = ""
	B.frame = 2
	bout_play = B
	B.last_speed = 1
end
function B.clic_gauche(B)
	if B.frame == 1
	or B.frame == 3 then
		model.speed = B.last_speed
	else
		model.speed = 0
	end
end
function B.autre(B,bu)
	if bu == "wu" then
		model.speed = model.speed+.1
	elseif bu == "wd" then
		model.speed = model.speed-.1
	end
end
function B.update(B,dot)
	if model.speed == 0 then
		if B.last_speed < 0 then
			B.frame = 3
		else
			B.frame = 1
		end
	else
		B.last_speed = model.speed
		B.frame = 2
	end

end
function B.clic_droit(B)

end
function B.update_popup(B)

end
function B.condition()
	return(true)
end
