function unit_load()


	unit = {}
	unitlist = {}
	ia_list = {}
	local list = love.filesystem.getDirectoryItems("Data/unit")
	for i,h in ipairs(list) do
		table.insert( unitlist , {	nom = h ,
						app = {} ,
						santer = 1 ,
						armure = 1 ,
						speed = 2 ,
						circle_sise = 10 ,
						colision_circle = 10 ,
						selectable = false ,
						use_ia = false ,
						attacable = false ,
						build_time = 2 ,
						power = {} ,
						pos_cap = {{{},{},{}},{{},{},{}},{{},{},{}}},
						point = 1 ,
						vrais_nom = h ,
						present = false ,
						taille = 10,
						prix = 0,
						poid = .2,
						hauteur = 0 ,
						zone_sise = 0
						} )
	end
	for i,h in ipairs(unitlist) do
		_G["unit_"..h.nom..""] = h
		T = h
		love.filesystem.load("unit_base.lua")()
		--love.filesystem.load("Data/unit/"..h.nom.."/scripte.lua")()


		local liste = love.filesystem.getDirectoryItems("Data/unit/"..h.nom.."/scripte")
		for u,k in ipairs(liste) do
			love.filesystem.load("Data/unit/"..h.nom.."/scripte/"..k.."")()
		end








		h.load(h)
		if love.filesystem.exists( "Data/unit/"..h.nom.."/icone.png" ) then
			T.icone = love.graphics.newImage( "Data/unit/"..h.nom.."/icone.png" )
		elseif love.filesystem.exists( "Data/unit/"..h.nom.."/icone.gif" ) then
			T.icone = love.graphics.newImage( "Data/unit/"..h.nom.."/icone.gif" )
		else
			T.icone = rien
		end
		T.icone:setFilter( "nearest","nearest" )
		if love.filesystem.exists( "Data/unit/"..h.nom.."/sol.png" ) then
			T.sol = love.graphics.newImage( "Data/unit/"..h.nom.."/sol.png" )
		elseif love.filesystem.exists( "Data/unit/"..h.nom.."/sol.gif" ) then
			T.sol = love.graphics.newImage( "Data/unit/"..h.nom.."/sol.gif" )
			T.sol:setFilter( "nearest","nearest" )
		end
	end

	for i,h in ipairs(unitlist) do
		local liste = love.filesystem.getDirectoryItems("Data/unit/"..h.nom.."/power")
		for e,g in ipairs(liste) do
			table.insert(h.power,{	nom = g ,
						X = 1 ,
						Y = 1
							})
			newp = h.power[table.maxn(h.power)]
			P = newp
			love.filesystem.load("Data/unit/"..h.nom.."/power/"..g.."/scripte.lua")()
			P.load(h,P)
			h.pos_cap[P.X][P.Y].power = P
			if love.filesystem.exists( "Data/unit/"..h.nom.."/power/"..g.."/icone.png" ) then
				P.icone = love.graphics.newImage( "Data/unit/"..h.nom.."/power/"..g.."/icone.png" )
			elseif love.filesystem.exists( "Data/unit/"..h.nom.."/power/"..g.."/icone.gif" ) then
				P.icone = love.graphics.newImage( "Data/unit/"..h.nom.."/power/"..g.."/icone.gif" )
			else
				P.icone = rien
			end
			P.icone:setFilter( "nearest","nearest" )
		end
		local temp_son = 1
		h.son = {}
		local liste = love.filesystem.getDirectoryItems("Data/unit/"..h.nom.."/son")
		for e,g in ipairs(liste) do
			if love.filesystem.exists("Data/unit/"..h.nom.."/son/"..g.."/caract.lua")  then
				love.filesystem.load("Data/unit/"..h.nom.."/son/"..g.."/caract.lua")
			end
			_G["son_"..h.nom.."_"..g..""] =  new_son("Data/unit/"..h.nom.."/son/"..g.."/son.ogg",temp_son)

		end






	end


end




function last()
	return (unit[table.maxn(unit)])
end
function unit_start()
	elu = 1
	unit = {}

	for i,h in ipairs(unitlist) do
		h.start(h)
	end
end
function add_projet(tipe,eX,eY,equ)
	table.insert(equipe[equ].projet,{	X = eX ,
						Y = eY ,
						batiment = tipe ,
						etat = "normal" })
	return (equipe[equ].projet[table.maxn(equipe[equ].projet)])
end
function unit_create(tipe,equipee,eX,eY,eZ,sens,mode)
	table.insert(unit , { 	X = eX ,
				Y = eY ,
				Z = eZ ,
				A = 0 ,
				alpha = 1 ,
				sc = 1 ,
				mX = 0 ,
				mY = 0 ,
				mZ = 0 ,
				speed = tipe.speed ,
				sens = sens ,
				tipe = tipe ,
				equipe = equipee,
				app = {} ,
				etat = "vivant" ,
				mode = "normal" ,
				attacable = tipe.attacable ,
				selectable = tipe.selectable ,
				santer = tipe.santer ,
				chemin = {} ,
				nextpoint = 1 ,
				can_die = true ,
				can_order = true ,
				ligne = false
				 	} )
	local new = unit[table.maxn(unit)]
	if tipe.sol ~= nil then
		new.a_sol = 0
	end
	if mode ~= nil then
		new.mode = mode
	end
	if equipee ~= 0
	and tipe.present == true then
		table.insert( equipe[equipee].unit , { unit = new } )
		--new.coequipier = equipe[equipee].unit[table.maxn(equipe[equipee].unit)]
	end
	for i,h in ipairs(tipe.app) do
		model_create(h.app,eX,eY,eZ,0,sens)
		table.insert(new.app , {app = app[table.maxn(app)]})
	end
	if tipe.use_ia == true then
		table.insert( ia_list , { unit = new , etat = "normal" } )
		new.ia = ia_list[table.maxn(ia_list)]
	end
	tipe.creation(tipe,new)
	return (new)
end
function hit_zone(ex,ey,damage,range,equ,multi)


	nearest = nil
	near = range
	for i,h in ipairs(equipe[3-equ].unit) do
		if h.unit.etat ~= "mort"
		and h.unit.etat ~= "fini"
		and h.unit.attacable == true then
			local dist = math.sqrt((ex-h.unit.X)^2+(ey-h.unit.Y)^2)-h.unit.tipe.colision_circle-range
			if dist < range then
				if multi == true then
					unit_hit(h.unit,damage,"normal")
				else
					if dist < near then
						nearest = h.unit
						near = dist
					end
				end
			end
		end
	end
	if multi == false then
		if nearest ~= nil then
			unit_hit(nearest,damage,"normal")
		end
	end
	if nearest ~= nil
	and nearest.etat == "mort" then
		nearest = nil
	end
	return (nearest)
end

function unit_hit(qui,domage,tipe)
	qui.santer = qui.santer-domage
	if qui.santer <= 0
	and qui.etat ~= "mort"
	and qui.etat ~= "fini" then
		unit_kill(qui)
	end
	qui.tipe.hit(qui.tipe,qui)
end
function unit_stun(qui,temp)
	qui.etat = "stuned"
	qui.stuned_time = crono+temp
	qui.tipe.stun(qui.tipe,qui)
end
function unit_destun(qui)
	qui.etat = "vivant"
	qui.tipe.destun(qui.tipe,qui)
end


function unit_kill(qui)
	if qui.can_die == true then
		if qui.tipe.use_ia == true then
			qui.ia.etat = "fini"
		end
		qui.selectable = false
		qui.etat = "mort"
		qui.tipe.mort(qui.tipe,qui)
	end
end
function unit_update(dot)
	for i,h in ipairs(ia_list) do
		if h.etat == "fini" then
			table.remove(ia_list,i)
		end
	end
	for e,g in ipairs(equipe) do
		for i,h in ipairs(g.unit) do
			if h.unit.etat == "stuned" then
				if h.unit.stuned_time < crono then
					h.unit.etat = "vivant"
					h.unit.tipe.destun(h.unit.tipe,h.unit)

				end


			elseif h.unit.etat == "mort" then

				if h.unit.tipe.sol ~= nil then
					h.unit.a_sol = h.unit.a_sol*.9
				end
			elseif h.unit.etat == "fini" then
				table.remove(equipe[e].unit,i)
			else
				if h.unit.tipe.sol ~= nil then
					h.unit.a_sol = h.unit.a_sol+.05*(255-h.unit.a_sol)
				end
			end
		end
		for i,h in ipairs(g.projet) do
			if h.etat == "fini" then
				table.remove(g.projet,i)
			end
		end
	end
	elu = elu+1
	if ia_list[elu] ~= nil then
		ia_list[elu].unit.tipe.ia(ia_list[elu].unit.tipe,ia_list[elu].unit)
	else
		elu = 0
	end
	elu = elu+1
	if ia_list[elu] ~= nil then
		ia_list[elu].unit.tipe.ia(ia_list[elu].unit.tipe,ia_list[elu].unit)
	else
		elu = 0
	end
	elu = elu+1
	if ia_list[elu] ~= nil then
		ia_list[elu].unit.tipe.ia(ia_list[elu].unit.tipe,ia_list[elu].unit)
	else
		elu = 0
	end
	elu = elu+1
	if ia_list[elu] ~= nil then
		ia_list[elu].unit.tipe.ia(ia_list[elu].unit.tipe,ia_list[elu].unit)
	else
		elu = 0
	end


	for i,h in ipairs(unit) do
		if h.etat == "fini" then
			table.remove(unit,i)
			for e,g in ipairs(h.app) do
				g.app.etat = "fini"
			end
		else
			h.tipe.update(h.tipe,h,dot)
		end
	end
end
