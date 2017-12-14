function B.init(B)
	B.X = love.graphics.getWidth()-100
	B.Y = 125
	B.text = "alpha"
	B.popup = {}
	B.popup.X = B.X-100
	B.popup.Y = B.Y+25
	B.popup.text = "ajuste le niveau d'aupacite du futur sprite"
	B.os = 0
	sprite.alpha = 255
end
function B.clic_gauche(B)
	sprite.alpha = math.min(255,math.floor((sprite.alpha+5)*20)/20)
end
function B.clic_droit(B)
	sprite.alpha = math.max(0,math.floor((sprite.alpha-5)*20)/20)
end
function B.autre(B,bu)
	if bu == "wu" then
		B.clic_gauche(B)
	elseif bu == "wd" then
		B.clic_droit(B)
	end
end
function B.update(B,dot)
	if B.condi == true then
		B.Y = 125+decal2
		B.popup.Y = B.Y+25
		decal2 = decal2+25
		B.text = "alpha: "..math.floor(sprite.alpha/2.55).."%"
	end
end
function B.condition(B)
	return ( sprite.select ~= 0 and mode == "editer" and mode_edit == "edit sprite" )
end
