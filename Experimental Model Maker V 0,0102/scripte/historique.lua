local new = new_function(fonction,"load",12)
function new.F()
	histo = {}
	histo.pos = 1
	histo.maxpos = 1
end
function add_historique(model)
	new = {}
	table.insert(histo,new)
	histo.maxpos = table.maxn(histo)
	histo.pos = histo.maxpos
	new.lieux = save_backup(model.data)
	return new
end
function save_backup(data)
	--lieux = love.filesystem.newFile("historique/"..data.nom.."_"..histo.pos..".lua")
	--if not lieux:open( "w" ) then
	--	rapporter_erreur( "erreur de sauvegarde du modèle : "..data.nom.." dans le dossier : "..lieux..", ouverture impossible")
	--end
	--saving(data,lieux)
end
function historique_plus(model)
	if histo.pos < histo.maxpos then
		histo.pos = histo.pos+1
		M = model.data 
		love.filesystem.load("historique/"..model.data.nom.."_"..histo.pos..".lua" )()
		for i,h in ipairs(model.data.bone) do
			model.data.bone[h.nom] = h
		end
		for i,h in ipairs(model.anim) do
			model.data.anim[model.data.nom] = h
		end
		model = create_model(model.data)
	end
	return model
end
function historique_moin(model)
	if histo.pos > 1 then
		histo.pos = histo.pos-1
		M = model.data 
		love.filesystem.load("historique/"..model.data.nom.."_"..histo.pos..".lua" )()
		for i,h in ipairs(model.data.bone) do
			model.data.bone[h.nom] = h
		end
		for i,h in ipairs(model.anim) do
			model.data.anim[model.data.nom] = h
		end
		model = create_model(model.data)
	end
	return model
end








