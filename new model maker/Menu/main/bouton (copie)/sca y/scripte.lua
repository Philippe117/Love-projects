function B.init(B)				
	B.X = 300
	B.Y = 575
	B.text = "sise Y"
	B.popup = {}
	B.popup.X = B.X+50
	B.popup.Y = B.Y+50
	B.popup.text = "redimensioner sur laxe des y"
end
function B.clic_gauche(B)

	model.model_data.sprite[sprite_sel].sy = model.model_data.sprite[sprite_sel].sy+.01

end



function B.clic_droit(B)
	model.model_data.sprite[sprite_sel].sy = model.model_data.sprite[sprite_sel].sy-.01
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
	if sprite_sel ~= table.maxn(model.sprite)+1 then
		return(true)
	else
		return(false)
	end
end
