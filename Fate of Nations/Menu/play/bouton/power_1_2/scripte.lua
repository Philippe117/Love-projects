function B.init(B)
	B.X = inter_power_X+1*75
	B.Y = inter_power_Y+2*75 
	B.text = ""



	B.popup = {}
	B.popup.X = B.X
	B.popup.Y = B.Y-100
	B.popup.text = ""
end
function B.update_popup(B)
	if selection.tipe.pos_cap[1][2].power.description ~= nil then
		B.popup.text = selection.tipe.pos_cap[1][2].power.description
	else
		B.popup.text = ""
	end
end


function B.clic_gauche(B)
	if selection.tipe.pos_cap[1][2].power.condition(selection.tipe,selection,selection.tipe.pos_cap[1][2].power) == true then
		selection.tipe.pos_cap[1][2].power.fonction_gauche(selection.tipe,selection,selection.tipe.pos_cap[1][2].power)
	

	end
end
function B.clic_droit(B)
	if selection.tipe.pos_cap[1][2].power.condition(selection.tipe,selection,selection.tipe.pos_cap[1][2].power) == true then
		selection.tipe.pos_cap[1][2].power.fonction_droit(selection.tipe,selection,selection.tipe.pos_cap[1][2].power)
	

	end
end



function B.condition()
	if selection ~= nil
	and selection.tipe.pos_cap[1][2].power ~= nil then
		return(true)
	else
		return(false)
	end
	
end
