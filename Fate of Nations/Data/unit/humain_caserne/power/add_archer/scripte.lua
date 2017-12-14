function P.load(T,P)
	P.X = 3
	P.Y = 1
	P.unit = unit_humain_archer

	P.description = "faire des archer\n\nprend "..P.unit.build_time.." seconde a produire"
end
function P.condition(T,Q,P)
	return(true)
end
function P.fonction_gauche(T,Q,P)
	if Q.liste[table.maxn(Q.liste)] == nil then
		Q.progression = P.unit.build_time
	end
	if Q.liste[table.maxn(Q.liste)] ~= nil
	and Q.liste[table.maxn(Q.liste)].unit == P.unit
	and Q.liste[table.maxn(Q.liste)].nb < 8 then
			Q.liste[table.maxn(Q.liste)].nb = Q.liste[table.maxn(Q.liste)].nb+1
	elseif table.maxn(Q.liste) < 6 then
		table.insert(Q.liste,{unit = P.unit , nb = 1})
		
	end
end
function P.fonction_droit(T,Q,P)
	
end
