function B.init(B)
	B.X = inter_liste_X+5*50
	B.Y = inter_liste_Y-14


	B.text = ""
end
function B.clic_gauche(B)

	if selection.liste[5] ~= nil
	and selection.liste[1].nb < 8 then
		selection.liste[5].nb = selection.liste[5].nb+1
	end


end
function B.clic_droit(B)
	if selection.liste[5] ~= nil then
		if selection.liste[5].nb > 1 then
			selection.liste[5].nb = selection.liste[5].nb-1

		else
			table.remove(selection.liste , 5 )
			if selection.pointe[1] >= 5 then
				if selection.pointe[1] == 5 then
					if selection.liste[5] ~= nil then
						selection.progression = selection.liste[5].unit.build_time
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
	and selection.liste[5] ~= nil then
		return(true)
	else
		return(false)
	end
	
end
