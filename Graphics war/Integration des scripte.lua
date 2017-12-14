fonction = {}
function new_function(rep,nom,prio)--repertoire , nom de le liste , priorité d'éxécution
	local fonc = 0
	if rep == nil or rep == 0 then
		if _G[nom] == nil then
			_G[nom] = {prio = 1}
			table.insert(fonction,_G[nom])
		end
		fonc = _G[nom]
	else
		if rep[nom] == nil then
			rep[nom] = {prio = 1}
			table.insert(fonction,rep[nom])
		end
		fonc = rep[nom]
	end
	local new = { prio = prio }
	rapporter_erreur(""..nom.." "..prio.."")
	table.insert(fonc,new)
	return(new)
end
function execute_fonction(fonc,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10)
	if fonc ~= nil then
		for i,h in ipairs(fonc) do
			h.F(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10)
		end
	end
end
function execute(fonc,P1,P2,P3,P4,P5,P6,P7,P8,P9,P10)
	if fonc ~= nil then
		return (fonc(P1,P2,P3,P4,P5,P6,P7,P8,P9,P10))
	else
		return (false)
	end
end
function sort_func()
	for i,h in ipairs(fonction) do
		sort_fast( h , "prio" , 1 )
	end
end
function search_script(lieux)
	local list = love.filesystem.getDirectoryItems(lieux)
	for i,S in ipairs(list) do
		S = { nom = S }
		love.filesystem.load(""..lieux.."/"..S.nom.."" )()
	end
	sort_func()
end
