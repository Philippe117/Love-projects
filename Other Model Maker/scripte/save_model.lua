function save_model(data,lieux)
	rapporter_erreur( "sauvegarde du modèle : "..data.nom.." dans le dossier : "..lieux.."")

	lieux2 = love.filesystem.newFile(""..lieux.."/scripte.lua")
	if not lieux2:open( "w" ) then
		rapporter_erreur( "erreur de sauvegarde du modèle : "..data.nom.." dans le dossier : "..lieux..", ouverture impossible")
	else
		lieux2:write( "M.nom = \""..data.nom.."\"\n")
		saving(data,lieux2)
	end

end
function saving(data,lieux)

	lieux:write( "M.nom = \""..data.nom.."\"\n")
	lieux:write( "--MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM bone MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM--\n" )
	lieux:write( "M.bone = {}\n" )
	for i,h in ipairs(data.bone) do
		lieux:write( "M.bone["..i.."] = {	nom = \""..h.nom.."\" ,\n")
		if h.base.tipe == 0 then
			lieux:write( "		base = { tipe = 0 , pos = { X = "..h.base.pos.X.." , Y = "..h.base.pos.Y.." } } ,\n" )
		elseif h.base.tipe == 1 then
			lieux:write( "		base = { tipe = 1 , pos = "..h.base.pos.." } ,\n" )
		end
		if h.tete.tipe == 0 then
			lieux:write( "		tete = { tipe = 0 , pos = { X = "..h.tete.pos.X.." , Y = "..h.tete.pos.Y.." } } }\n\n")
		elseif h.tete.tipe == 1 then
			lieux:write( "		tete = { tipe = 1 , vec = { D = "..h.tete.vec.D.." , L = "..h.tete.vec.L.." } } }\n\n")
		elseif h.tete.tipe == 2 then
			lieux:write( "		tete = { tipe = 2 , pos = "..h.tete.pos.." } }\n\n")
		end
	end
	lieux:write( "--WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW bone WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW--\n\n" )
	lieux:write( "--MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM animations MMMMMMMMMMMMMMMMMMMMMMMMMM--\n" )


	for e,g in ipairs(data.anim) do
		lieux:write( "--((-------------------( "..g.nom.." (----------------((--\n" )
		lieux:write( "M.anim["..e.."] = { nom = \""..g.nom.."\" , duration = "..g.duration.." , bone = {} }\n")

		for i,h in ipairs(g.bone) do
			lieux:write( "----"..data.bone[i].nom.."----\nM.anim["..e.."].bone["..i.."] = {} \n")
			local u = 0
			while h[u] do
				k = h[u]
				if data.bone[i].tete.tipe == 0 then
					lieux:write( "M.anim["..e.."].bone["..i.."]["..u.."] = { pos = { X = "..k.pos.X.." , Y = "..k.pos.Y.." } , temps = "..k.temps.." , duration = "..k.duration.." , Sdep = "..k.Sdep.." , Sari = "..k.Sari.." } \n")
				elseif data.bone[i].tete.tipe == 1 then
					lieux:write( "M.anim["..e.."].bone["..i.."]["..u.."] = { vec = { D = "..k.vec.D.." , L = "..k.vec.L.." , eritrot = "..k.vec.eritrot.." } , temps = "..k.temps.." , duration = "..k.duration.." , Sdep = "..k.Sdep.." , Sari = "..k.Sari.." } \n")
				end
				u = u+1
			end
			--lieux:write( "\n" )
		end
		lieux:write( "--))-------------------) "..g.nom.." )----------------))--\n\n" )
	end
	lieux:write( "--WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW animation WWWWWWWWWWWWWWWWWWWWWWWWWWW--\n" )
	lieux:close( )
	return lieux
end
