liste = {}
liste.collect_routine = {}
liste.collect_routine_fast = {}
liste.sort_routine = {}
liste.sort_routine_fast = {}
function add_list_to_collect_routine(list,nom,fast)
	list.eta = true
	list.collect = nom
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
	table.insert(list , data )
	if list.collect ~= nil then
		if data.eta == nil then
			data.eta = {}
		end
		data.eta[list.collect] = true
	end
	if list.sort ~= nil then
		if data[list.sort] == nil then
			data[list.sort] = 1
		end
		--txt = txt+1
		local P = table.maxn(list)
		txt = P
		while P > 1 and list.sens*list[P][list.sort] > list.sens*list[P-1][list.sort] do
			rapporter_erreur(""..P.."")
			list[P],list[P-1] = list[P-1],list[P]
			P = P-1
			txt = txt+1
		end
	end
--	rapporter_erreur("add to a sort list : "..list.sort.."")
	return (data)
end
local new = new_function(fonction,"update",0)
function new.F(dot)
	for i,h in ipairs(liste.collect_routine) do
		if h.eta == false or garbage_collect(h,h.collect) and table.maxn(h) == 0 then
		--	table.remove(liste.collect_routine , i )
		end
	end
	for i,h in ipairs(liste.collect_routine_fast) do
--rapporter_erreur(h.collect)
		if h.eta == false or garbage_collect_fast(h,h.collect) and table.maxn(h) == 0 then
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
function garbage_collect(list,nom)
	local rep = false
	if table.maxn(list) > 0 then
		if list.garbage_man == nil or list[list.garbage_man] == nil then
			list.garbage_man = 1
		end
		if list[list.garbage_man].eta == nil
		or list[list.garbage_man].eta == false
		or list[list.garbage_man].eta[nom] ~= true then
			table.remove( list , list.garbage_man )
			rep = true
		else
			list.garbage_man = list.garbage_man+1
			if list.garbage_man > table.maxn(list) then
				list.garbage_man = 1
			end
		end
	end
	return (rep)	--true si un/des élément a/ont été retiré
end
function garbage_collect_fast(list,nom)
	local rep = false
	for i,h in ipairs(list) do
		if h.eta == nil or h.eta == false or h.eta[nom] ~= true then
			table.remove( list , i )
			rep = true
--rapporter_erreur("element retiré a la liste  "..nom.."")
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
