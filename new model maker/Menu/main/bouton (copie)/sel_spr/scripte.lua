function B.init(B)				
	B.X = 100
	B.Y = 500
	B.text = "select sprite"
	sprite_sel = table.maxn(model.model_data.sprite)+1
	B.popup = {}
	B.popup.X = B.X+50
	B.popup.Y = B.Y+50
	B.popup.text = "clic droit pour +\nclic gauche pour -"
end
function B.clic_gauche(B)
	if sprite_sel <= table.maxn(model.model_data.sprite) then
		sprite_sel = sprite_sel+1
	end
end



function B.clic_droit(B)
	if sprite_sel > 1 then
		sprite_sel = sprite_sel-1
	end
end
function B.autre(B,bu)
	if bu == "wu" then

		B.clic_droit(B)
	elseif bu == "wd" then
		B.clic_gauche(B)

	end
end

function B.update_popup(B)

end
function B.condition()

		return( true )

end
