function B.init(B)				
	B.X = love.graphics.getWidth()-200
	B.Y = 500
	B.text = "choisir"
	sprite_choisi = 1
	B.popup = {}
	B.popup.X = B.X-100
	B.popup.Y = B.Y+50
	B.popup.text = "clic droit pour +\nclic gauche pour -"
end
function B.clic_gauche(B)
	if sprite_choisi < table.maxn(model.model_data.sprite_list) then
		sprite_choisi = sprite_choisi+1
	end
end



function B.clic_droit(B)
	if sprite_choisi > 1 then
		sprite_choisi = sprite_choisi-1
	end
end
function B.autre(B,bu)
	if bu == "wu" then
		B.clic_gauche(B)
	elseif bu == "wd" then
		B.clic_droit(B)
	end
end
function B.update_popup(B)

end
function B.condition()

		return( true )

end
