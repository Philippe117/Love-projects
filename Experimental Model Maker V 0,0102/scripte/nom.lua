
function check_nom(liste,nom)
	local rep = true
	for i,h in ipairs(liste) do
		if h.nom == nom then
			rep = false

		end
	end

	local num = 0
	if not rep then
		num = 1
		num = check_nom_2(liste,nom,num)
	end

	if num ~= 0 then
		nom = ""..nom.."_"..num..""
	end

	return(nom)
end

function check_nom_2(liste,nom,num)
	txt = txt+10
	local rep = true
	for i,h in ipairs(liste) do
		if h.nom == ""..nom.."_"..num.."" then
			rep = false
			txt = txt+1
		end
	end
	if not rep then
		num = num+1
		num = check_nom_2(liste,nom,num)
	end
	return(num)
end

