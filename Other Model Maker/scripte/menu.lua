
local new = new_function(fonction,"load",-2)
function new.F()
	--menu_data = {}
	menu_actif = add_list_to_collect_routine({},"actif",false)
	--search_for_menu("Menu")
end
function search_for_menu(lieux)
	local list = love.filesystem.enumerate(lieux)
	for i,h in ipairs(list) do
		list[h] = add_menu(lieux,h)
	end
	return (list)
end
function load_menu(lieux,nom)
	rapporter_erreur("	-( gargement du menu "..nom.."")

	local new = { nom = nom , lieux = ""..lieux.."/"..nom..""  }
	if love.filesystem.exists( ""..lieux.."/"..nom.."/scriptes" ) then
		local listed = love.filesystem.enumerate(""..lieux.."/"..nom.."/scriptes")
		for u,k in ipairs(listed) do
			M = new
			love.filesystem.load(""..lieux.."/"..nom.."/scriptes/"..k.."")()
			execute( new.load , new )

		end
	end
	new.bouton = search_for_bouton(""..new.lieux.."/bouton")
	rapporter_erreur("		menu "..nom.." chargé )-")
	add_data_to_a_list(menu_actif,new)
	return(new)
end
function remove_menu(menu)
	menu.eta.actif = false
	for i,h in ipairs(menu.bouton) do
		h.eta.actif = false
	end
	return (menu)
end

local new = new_function(fonction,"MP",0)
function new.F()
	for e,g in ipairs(menu_actif) do
		if g.eta.actif then
			execute_en_silence(g.MP,g,k)
		end
	end
end
local new = new_function(fonction,"MR",0)
function new.F()
	for e,g in ipairs(menu_actif) do
		if g.eta.actif then
			execute_en_silence(g.MR,g,k)
		end
	end
end
local new = new_function(fonction,"KP",0)
function new.F(k)
	for e,g in ipairs(menu_actif) do
		if g.eta.actif then
			execute_en_silence(g.KP,g,k)
		end
	end
end

local new = new_function(fonction,"update",0)
function new.F(dot)
	pointer = 0

	for e,g in ipairs(menu_actif) do
		if g.eta.actif then
			execute_en_silence(g.update,g,dot)
		end
	end
end
local new = new_function(fonction,"draw",-10)
function new.F()
	love.graphics.setFont( ff )
	for e,g in ipairs(menu_actif) do
		g.draw(g)
	end
end

