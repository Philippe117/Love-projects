
local new = new_function(fonction,"load",10)
function new.F()
	unit_data = {}
	search_for_unit("Data/Unit")
end
local new = new_function(fonction,"start",0)
function new.F()
	unit = add_list_to_collect_routine({},"unit",false)
	unit.id = 1
	unit.team = {}
end
function add_unit(lieux,nom)
	local new = add_objet(lieux,nom)
	new.HP = 100
	new.killable = true
	unit_data[nom] = new
	new.unit = add_list_to_collect_routine({},"data",false)
	new.icone = load_image("Data/unit/"..h.nom.."/icone")
	U = new
	love.filesystem.load("unit_base.lua")()
	execute(new.load)
	table.insert( unit_data , new )
	return (new)
end
function search_for_unit(lieux)
	for i,h in ipairs(love.filesystem.enumerate(lieux)) do
		unit_data[h] = add_unit(lieux,h)
	end
end
function create_unit(data,team,X,Y,Z,A)
	local sx = 1
	if math.cos(A) ~= 0 then
		sx = math.cos(A)/math.abs(math.cos(A))
	end
	local new = objet_create(data,X,Y,Z,A,sx,1)
	new.eta.unit = true
	new.unit_id = unit.id
	unit.id = unit.id+1
	new.team = team
	new.HP = data.HP
	new.HPmax = data.HP
	new.killable = data.killable
	while table.maxn(unit.team) < team do
		table.insert(unit.team , add_list_to_collect_routine({},"team",false) )
	end
	add_data_to_a_list(unit,new,"unit")
	add_data_to_a_list(unit.team[new.team],new,"team")
	add_data_to_a_list(data.unit,new,"data")
	execute(data.creation,new)
	execute_fonction(unit_created,new)
	return (new)
end
function unit_hit(qui,domage)
	if qui.HP <= 0 then
		unit_kill(qui)
	end
	execute_fonction(qui.data.hit,qui)
	execute_fonction(unit_hitted,qui)
end
function unit_kill(qui)
	if qui.killable then
		qui.selectable = false
		qui.data.mort(qui.data,qui)
	end
	execute_fonction(unit_killed,qui)
end

