local new = new_function(fonction,"load",18)
function new.F()
	objet_created = {}
	objet_data = {}
	search_for_objet("Data/Objet")
end
local new = new_function(fonction,"start",0)
function new.F()
	objet = add_list_to_collect_routine({},"objet",false)
	objet.id = 1
end
function search_for_objet(lieux)
	local list = love.filesystem.getDirectoryItems(lieux)
	for i,h in ipairs(list) do
		objet_data[h] = add_objet(lieux,h)
	end
end
function add_objet(lieux,nom)
	local new = { 	nom = nom ,
			vrais_nom = nom ,
			lieux = ""..lieux.."/"..nom.."" ,
			objet = {}
			}
	if love.filesystem.exists( ""..lieux.."/"..nom.."/scripte" ) then
		local liste = love.filesystem.getDirectoryItems(""..lieux.."/"..nom.."/scripte")
		for u,k in ipairs(liste) do
			S = new
			love.filesystem.load(""..lieux.."/"..nom.."/scripte/"..k.."")()
			execute( new.load , new )
		end
	end
	rapporter_erreur("objet chargé: "..new.nom.."")
	table.insert(objet_data , new )
	return (new)
end
function objet_create(data,X,Y,Z,A)
	if data ~= nil then
		local new = { 	data = data ,
				eta = { objet = true } ,
				objet_id = objet.id ,
				draw_cam = data.draw_cam ,
				X = X ,
				Y = Y ,
				Z = Z ,
				A = A
			 				}
		rapporter_erreur("objet créé: "..data.nom.."")
		add_data_to_a_list( objet , new )
		add_data_to_a_list( data.objet , new )
		execute( data.creation , new )
		execute_fonction(objet_created,new)
		objet.id  = objet.id+1
		return (new)
	end
end
function objet_set_vec(obj,vec)
	if vec.direction == nil then vec.direction = obj.mov.direction else obj.mov.direction = vec.direction end
	if vec.speed == nil then vec.speed = obj.mov.speed else obj.mov.speed = vec.speed end
	if vec.Zdirection == nil then vec.Zdirection = obj.mov.Zdirection else obj.mov.Zdirection = vec.Zdirection end
	h.mov.X = h.mov.speed*math.cos(h.mov.direction)*math.cos(h.mov.Zdirection)
	h.mov.Y = h.mov.speed*math.sin(h.mov.direction)*math.cos(h.mov.Zdirection)
	h.mov.Z = h.mov.speed*math.sin(h.mov.Zdirection)
end
function objet_set_axe(obj,axe)
	if axe.X == nil then axe.X = obj.mov.X else obj.mov.X = axe.X end
	if axe.Y == nil then axe.Y = obj.mov.Y else obj.mov.Y = axe.Y end
	if axe.Z == nil then axe.Z = obj.mov.Z else obj.mov.Z = axe.Z end
	h.mov.speed = math.sqrt((obj.mov.X)^2+(obj.mov.Y)^2+(obj.mov.Z)^2)
	if h.mov.speed ~= 0 then
		h.mov.direction = math.atan2(obj.mov.Y/obj.mov.X)
		h.mov.Zdirection = math.atan(obj.mov.Z/h.mov.speed)
	end
end
local new = new_function(fonction,"update",10)
function new.F(dot)
	if objet_update ~= nil then
		for i,h in ipairs(objet_update) do
				h.F(h.obj,dot)
		end
	end
end
