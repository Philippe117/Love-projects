function B.init(B)
	B.X = inter_liste_X+1*50
	B.Y = inter_liste_Y-14


	B.text = ""
end
function B.clic_gauche(B)

	if selection.liste[1] ~= nil
	and selection.liste[1].nb < 8 then
		selection.liste[1].nb = selection.liste[1].nb+1

	end


end
function B.clic_droit(B)
	if selection.liste[1] ~= nil then
		if selection.liste[1].nb > 1 then
			selection.liste[1].nb = selection.liste[1].nb-1
		else
			table.remove(selection.liste , 1 )
			if selection.pointe[1] >= 1 then
				if selection.pointe[1] == 1 then
					selection.pointe[2] = 1
					if selection.liste[1] ~= nil then
						selection.progression = selection.liste[1].unit.build_time
					end
				end
				selection.pointe[1] = math.max(1,selection.pointe[1]-1)

			end
		end
	end
end



function B.condition()
	if selection ~= nil
	and selection.liste ~= nil
	and selection.liste[1] ~= nil then
		return(true)
	else
		return(false)
	end
	
end
