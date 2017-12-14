function save_model(model_data,lieux)
	for i,h in ipairs(model_data.input) do
		remove_input_intel(model,i)
	end
	lieux = love.filesystem.newFile(""..lieux.."/scripte.lua")
	lieux:open( "w" )

	lieux:write( "---------------------------------------bone----------------------\n" )
---------------------------------------bone----------------------
	lieux:write( "M.bone = {\n" )
	for i,h in ipairs(model_data.bone) do
		lieux:write( "		{ 	base = { tipe = "..h.base.tipe.." , " )
		if h.base.tipe == 0 then
			lieux:write( "pos = { X = "..h.base.pos.X.." , Y = "..h.base.pos.Y.." }")
		elseif h.base.tipe == 1 then
			lieux:write( "pos = "..h.base.pos.."")
		end

		lieux:write( "} ,--"..i.."\n			tete = { tipe = "..h.tete.tipe.." , L = "..h.tete.L.." ")
		if h.tete.tipe == 2 then
			lieux:write( ", pos = "..h.tete.pos.."")
		end
		if h.tete.input ~= nil then
			lieux:write( " , input = "..h.tete.input.." " )
			rapporter_erreur("input "..h.tete.input.."")
		end
		if model_data.bone[i+1] ~= nil then
			lieux:write( "}} ,\n" )
		else
			lieux:write( "}}\n" )
		end
	end
	lieux:write("	 }\n---------------------------------------bone----------------------\n--------------------------------------sprite---------------------\n")
---------------------------------------bone----------------------
--------------------------------------sprite---------------------
	lieux:write( "M.sprite = {\n")
	for i,h in ipairs(model.model_data.sprite) do
		if h.eritscale == 1 then
			lieux:write( "		{ sprite = "..h.sprite.." ,--"..i.."\n		chef = "..h.chef.." ,\n		eritrot = "..h.eritrot.." ,\n		eritscale = 1 ,\n		X = "..h.X.." ,\n		Y = "..h.Y.." ,\n		A = "..h.A.." ,\n		sx = "..h.sx.." ,\n		sy = "..h.sy.." }" )
		else
			lieux:write( "		{ sprite = "..h.sprite.." ,\n		chef = "..h.chef.." ,\n		eritrot = "..h.eritrot.." ,\n		eritscale = "..h.eritscale.." ,\n		D = "..h.D.." ,\n		L = "..h.L.." ,\n		A = "..h.A.." ,\n		sx = "..h.sx.." ,\n		sy = "..h.sy.." }" )
		end
		if model.model_data.sprite[i+1] ~= nil then
			lieux:write( " ,\n" )
		else
			lieux:write( "\n" )
		end
	end
	lieux:write("	   }\n--------------------------------------sprite---------------------\n---------------------------------------anim----------------------\n")
	lieux:write( "M.anim = {\n" )
	for i,h in ipairs(model.model_data.anim) do
		lieux:write( "		{ nom = \""..h.nom.."\" ,--"..i.."\n" )
		for e,g in ipairs(h) do
			lieux:write( "			{ temp = "..(math.floor(g.temp*1000)/1000).." ,	bone =  {--"..e.."\n" )
---------------------------------------anim--bone--------------------
			for u,k in ipairs(g.bone) do
				if model_data.bone[k.os].tete.tipe == 2 then
					table.remove(g.bone,u)

				end
			end
			for u,k in ipairs(g.bone) do
				lieux:write( "							{os="..k.os..",pos=" )
				if model_data.bone[k.os].tete.tipe == 0 then
					lieux:write( "{X="..k.pos.X..",Y="..k.pos.Y.."}," )
				elseif model_data.bone[k.os].tete.tipe == 1 then
					lieux:write( "{D="..k.pos.D..",L="..k.pos.L.."},eritrot = "..k.eritrot.."," )
				end
				lieux:write( "prestep="..k.prestep.step.."" )

				if model.model_data.bone[k.os].tete.input ~= nil then
					lieux:write( ",input="..k.input.."" )
				end
				if g.bone[u+1] ~= nil then
					lieux:write( "} ,\n" )
				else
					lieux:write( "}\n" )
				end
			end
			lieux:write( "						} ,\n					sprite = {\n" )
---------------------------------------anim--bone--------------------
---------------------------------------anim--sprite------------------
			for u,k in ipairs(g.sprite) do
				lieux:write( "							{spr="..k.spr..",eta={alpha="..k.eta.alpha..",frame="..k.eta.frame.."},prestep="..k.prestep.step.."" )
				if g.sprite[u+1] ~= nil then
					lieux:write( "} ,\n" )
				else
					lieux:write( "}\n" )
				end
			end
			lieux:write( "						 }\n" )
---------------------------------------anim--sprite------------------
			if h[e+1] ~= nil then
				lieux:write( "			} ,\n" )
			else
				lieux:write( "			}" )
			end
		end
		if model.model_data.anim[i+1] ~= nil then
			lieux:write( "\n		} ,\n" )
		else
			lieux:write( "\n		}\n" )
		end
	end
	lieux:write("	}\n---------------------------------------input----------------------\n---------------------------------------input---------------------\nM.input = {\n")

	for i,h in ipairs(model_data.input) do
		lieux:write( "		{ nom = \""..h.nom.."\" }" )
		if model.model_data.input[i+1] ~= nil then
			lieux:write( " ,\n" )
		else
			lieux:write( "" )
		end
	end
	lieux:write("\n	}\n---------------------------------------input---------------------\n---------------------------------------atach---------------------\nM.atach = {\n")
	for i,h in ipairs(model_data.atach) do
		lieux:write( "		{ chef = "..h.chef.." , nom = \""..h.nom.."\" " )
		if model.model_data.atach[i+1] ~= nil then
			lieux:write( "} ,\n" )
		else
			lieux:write( "}" )
		end
	end
	lieux:write("\n	}\n---------------------------------------atach---------------------")

	lieux:close( )
end
