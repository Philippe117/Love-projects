local new = new_function(fonction,"load",10)
function new.F()
	search_for_objet("Data/Plateau")
end
function get_pos(plat,X,Y)
	return (plat.coord[100000*math.floor(X)+math.floor(Y)])
end

