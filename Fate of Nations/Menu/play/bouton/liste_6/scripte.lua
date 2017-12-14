function B.init(B)
	B.X = inter_liste_X+6*50
	B.Y = inter_liste_Y-14


	B.text = ""
end
function B.clic_gauche(B)

	if selection.liste[6] ~= nil
	and selection.liste[1].nb < 8 then
		selection.liste[6].nb = selection.liste[6].nb+1
	end


end
function B.clic_droit(B)
	if selection.liste[1] ~= nil then
		if selection.liste[6].nb > 1 then
			selection.liste[6].nb = selection.liste[6].nb-1

		else
			table.remove(selection.liste , 6 )
			if selection.pointe[1] >= 6 then
				if selection.pointe[1] == 6 then
					if selection.liste[6] ~= nil then
						selection.progression = selection.liste[6].unit.build_time
					end
					selection.pointe[2] = 1
				end
				selection.pointe[1] = math.max(1,selection.pointe[1]-1)
			end
		end
	end
end



function B.condition()
	if selection ~= nil
	and selection.liste ~= nil
	and selection.liste[6] ~= nil then
	return(true)
	else
		return(false)
	end
	
end
