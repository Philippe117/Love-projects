liste = {}
liste.collect_routine = {}
liste.collect_routine_fast = {}
liste.sort_routine = {}
liste.sort_routine_fast = {}
function add_list_to_collect_routine(list,nom,fast,fonc) -- nom est pour la variable utilisé pour connaitre l'éta de l'élément
	list.eta = true
	list.collect = nom
	list.collectf = fonc
	if fast then
		table.insert(liste.collect_routine_fast , list )
		rapporter_erreur("add collect list fast : "..nom.."")
	else
		table.insert(liste.collect_routine , list )
		rapporter_erreur("add collect list : "..nom.."")
	end
	return (list)
end
function add_list_to_sort_routine(list,var,sens,fast)
	list.eta = true
	list.sort = var
	list.sens = sens
	list[var] = 2
	if fast then
		table.insert(liste.sort_routine_fast , list )
	else
		table.insert(liste.sort_routine , list )
	end
	rapporter_erreur("add sort list : "..var.."")
	return (list)
end
function add_data_to_a_list(list,data)--ajoute un element a une liste
	table.insert( list , data )
	if list.collect then
		if not data.eta then
			data.eta = {}
		end
		data.eta[list.collect] = list.collectf or true
	end
	if list.sort then
		if not data[list.sort] then
			data[list.sort] = 0
		end
		local P = table.maxn(list)
		txt = P
		while P > 1 and list.sens*list[P][list.sort] > list.sens*list[P-1][list.sort] do
			--rapporter_erreur(""..P.."")
			list[P],list[P-1] = list[P-1],list[P]
			P = P-1
			txt = txt+1
		end
	end
	return (data)
end
function election_in_a_list(list1,list2,condi)--cherche dans la liste1 les candidat répondant aux condition d'ajout à la liste2
	for i,h in ipairs(list1) do
		if condi(h) then
			add_data_to_a_list(list2,h)
		end
	end
end
function clear_list(list)--vide une liste
	if list.collect then
		local i = 1
		while list[i] do
			list[i].eta[list.collect] = nil
			list[i] = nil
			i = i+1
		end
	else
		local i = 1
		while list[i] do
			list[i] = nil
			i = i+1
		end
	end
end

function copy_list(list1,list2)--copie une liste ver une autre
	clear_list(list2)
	for i,h in ipairs(list1) do
		add_data_to_a_list(list2,h)
	end
end
function add_list(list1,list2)--ajoute une liste à une autre
	for i,h in ipairs(list1) do
		add_data_to_a_list(list2,h)
	end
end
local new = new_function(fonction,"update",0)
function new.F(dot)
	for i,h in ipairs(liste.collect_routine) do
		if h.eta == false or garbage_collect(h,h.collect,h.collectf) and table.maxn(h) == 0 then
		--	table.remove(liste.collect_routine , i )
		end
	end
	for i,h in ipairs(liste.collect_routine_fast) do
		if h.eta == false or garbage_collect_fast(h,h.collect,h.collectf) and table.maxn(h) == 0 then
		--	table.remove(liste.collect_routine , i )

		end
	end
	for i,h in ipairs(liste.sort_routine) do
		if h.eta ~= false then
			sort(h,h.sort,h.sens)
		else
			table.remove(liste.sort_routine , i )
		end
	end
	for i,h in ipairs(liste.sort_routine_fast) do
		if h.eta ~= false then
			sort(h,h.sort,h.sens)
		else
			table.remove(liste.sort_routine_fast , i )
		end
	end
end
function get_eta(val,nom,colf)
	if colf then
		return colf(val) and val.eta and val.eta[nom]
	else
		return val.eta and val.eta[nom]
	end
end
function garbage_collect(list,nom,colf)
	local rep = false
	if table.maxn(list) > 0 then
		if not list.garbage_man or not list[list.garbage_man] then
			list.garbage_man = 1
		end
--if colf  then txt = txt+1 end
		if not get_eta(list[list.garbage_man],nom,colf) then
			--rapporter_erreur("un os "..nom.." ")
		--	list[list.garbage_man].eta[nom] = false
			table.remove( list , list.garbage_man )
			rep = true

		end
	end
	return rep	--true si un/des élément a/ont été retiré
end
function garbage_collect_fast(list,nom,colf)
	local rep = false
	for i,h in ipairs(list) do
		if not get_eta(h,nom,colf) then
			table.remove( list , i )
			rep = true
		end
	end
	return (rep)	--true si un/des élément a/ont été retiré
end
function sort(list,var,sens) --   <-->   1,2,3,...
	--rapporter_erreur(var)
	if table.maxn(list) > 1 then
		if list[var] >= table.maxn(list) then
			list[var] = 2
		else
			list[var] = list[var]+1
		end
		
		local P = list[var]
		while P > 1 and sens*list[P][var] > sens*list[P-1][var] do
			list[P],list[P-1] = list[P-1],list[P]
			P = P-1
		end
	end
end
function sort_fast(list,var,sens) --   <-->   1,2,3,...
	if table.maxn(list) > 1 then
		for i,h in ipairs(list) do
			local P = i
			while P > 1 and sens*list[P][var] > sens*list[P-1][var] do
				list[P],list[P-1] = list[P-1],list[P]
				P = P-1
			end
		end
	end
end
function draw_list(list,nom,X,Y)

	for i,h in ipairs(list) do
		nome = h[nom] or "{...}"
		love.graphics.print( "["..i.."]:"..nome.."" , X , Y+20*i )
	end
end










